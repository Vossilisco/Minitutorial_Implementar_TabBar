//
//  MealRatingViewController.swift
//  FoodTracker
//
//  Created by Rafael Martinez on 26/4/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import os.log
//Clase para gestionar la valoracion de la comida.
class MealRatingViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var ratingControl: RatingControl!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        title = "Valoracion"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Con esto podremos sacar la valoracion de la comida, aun estando dentro de esta clase.
        //Lo que hace es acceder a un atributo de la clase padre para asi conseguir el nombre
        if let tBC = tabBarController as? MealTabBarController {
            tBC.ratingVC = self
            if let meal = tBC.meal {
                ratingControl.rating = meal.rating
            }
        }
    }
}
