//
//  MealPhotoViewController.swift
//  FoodTracker
//
//  Created by Rafael Martinez on 26/4/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import os.log

//Clase para gestionar la foto de la comida.
class MealPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        title = "Foto"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Con esto podremos sacar la foto de la comida, aun estando dentro de esta clase.
        //Lo que hace es acceder a un atributo de la clase padre para asi conseguir el nombre
        if let tBC = tabBarController as? MealTabBarController {
            tBC.photoVC = self
            if let meal = tBC.meal {
                photoImageView.image = meal.photo
            }
        }
    }
    
    //Las dos proximas funciones son para el Delegate de la imagen, sirven para que se escoja la correcta.
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    //Metodo para el Tap Gesture, con el detecta el tap y gestiona la galeria.
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}
