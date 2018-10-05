//
//  ComposeViewController.swift
//  instagram
//
//  Created by Brandon Shimizu on 10/2/18.
//  Copyright © 2018 Brandon Shimizu. All rights reserved.
//

import UIKit
import Photos
import Toucan

class ComposeViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var captiontext: UITextView!
    let vc = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.delegate = self
        imageView.isUserInteractionEnabled = true
        
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (PHAuthorizationStatus) in
                self.present(self.vc, animated: true, completion: nil)
                
            }
        } else if (photos == .authorized){
            self.present(vc, animated: true, completion: nil)
            
        }
        print("got here")
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        let editedImage = Toucan.Resize.resizeImage(originalImage, size: CGSize(width: 414
            , height: 414))
        
        // Do something with the images (based on your use case)
        imageView.image = editedImage
        imageView.contentMode = .scaleAspectFit
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPost(_ sender: Any) {
        Post.postUserImage(image: imageView.image, withCaption: captiontext.text){(success, error) in
            if success {
                print("post successful")
                self.performSegue(withIdentifier: "postSegue", sender: nil)
            }
            else if let e = error as NSError? {
                print (e.localizedDescription)
            }
        }
    }
    @IBAction func onCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "cancelSegue", sender: nil)
    }
    
}
