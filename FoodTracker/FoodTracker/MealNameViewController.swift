//
//  MealNameViewController.swift
//  FoodTracker
//
//  Created by Rafael Martinez on 26/4/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import os.log

//Clase para gestionar el nombre de la comida.
class MealNameViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        title = "Nombre"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        //Con esto podremos sacar el nombre de la comida, aun estando dentro de esta clase.
        //Lo que hace es acceder a un atributo de la clase padre para asi conseguir el nombre
        if let tBC = tabBarController as? MealTabBarController {
            tBC.nameVC = self
            if let meal = tBC.meal {
                nameTextField.text = meal.name
            }
            tBC.updateSaveButtonState(withText: nameTextField.text ?? "")
        }
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        if let tBC = tabBarController as? MealTabBarController {
            tBC.saveButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let tBC = tabBarController as? MealTabBarController {
            tBC.updateSaveButtonState(withText: nameTextField.text ?? "")
        }
    }
}
