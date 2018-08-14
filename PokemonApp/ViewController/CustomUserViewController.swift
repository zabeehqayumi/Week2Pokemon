//
//  CustomUserViewController.swift
//  ScrollAndPageView
//
//  Created by Kevin Yu on 8/13/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

import UIKit

// enumeration for character names
enum CharacterName {
    case Ash
    case Brock
    case Selfie
}

// must conform to:
// UIImagePickerControllerDelegate - let VC have use of camera
// UINavigationControllerDelegate - let VC control the camera modal presentation
class CustomUserViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: XIB Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selfieButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    // MARK: Properties
    
    var characterName: CharacterName!
    var imagePicker: UIImagePickerController!

    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up our VC accordingly, depending on our initial string we set in the PageViewController
        self.setupWithName(self.characterName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Custom Setup methods
    
    // set up with pictures corresponding to the character we set up
    // or just as a selfie with no default picture, otherwise
    func setupWithName(_ charName: CharacterName!) {
        if charName != nil {
            switch (charName) {
            case .Ash:
                self.imageView.image = UIImage.init(named: "Ash")
                self.selfieButton.isHidden = true
            case .Brock:
                self.imageView.image = UIImage.init(named: "Brock")
                self.selfieButton.isHidden = true
            default:
                // imageView.image = nil // to remove image, just set as nil
                // placeholder images are better, helps spacing with Auto Layout
                self.imageView.image = UIImage.init(named: "selfie")
                self.selfieButton.isHidden = false
            }
        }
    }

    // MARK: Custom Action Methods
    
    // show the camera option
    @IBAction func selfieAction(_ sender: Any) {
        // set up our imagePickerController
        self.imagePicker = UIImagePickerController.init()
        
        // set delegate as self so this VC can dismiss/present/handle methods from the imagePickerController
        imagePicker.delegate = self
        
        // check if a camera exists
        // trying to open a camera on a simulator or any device without a camera will cause it to crash
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // for true selfie-mode, set source as the front-facing camera
            self.imagePicker.sourceType = .camera   // be sure to check out the other enumerations and options here
            self.imagePicker.cameraDevice = .front
            
            // finally, modally present our imagePicker
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        else {
            print("camera not available, do something else")
            
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func logInAction(_ sender: Any) {
        print("user did try to log in as: \(self.characterName)")
        if (SaveDataManager.sharedInstance.isLoading == false) {
            self.performSegue(withIdentifier: "toPokedex", sender: nil)
        }
    }
    
    // MARK: UIImagePickerController Delegate Methods
    
    // handle the choosing a picture
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // as we only need one picture, dismiss the imagePickerController upon selection
        self.imagePicker.dismiss(animated: true, completion: nil)
        
        // retreive the image the user took and set it up in the imageView
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    
}

