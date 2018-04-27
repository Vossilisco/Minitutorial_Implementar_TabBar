import UIKit
import os.log

//Clase principal que maneja el TabBar
class MealTabBarController: UITabBarController {
    
    //MARK: Properties
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    //Para poder referirnos a esta clase, desde dentro de las 3 (mealnameVC,photoVC y ratingVC)
    weak var nameVC: MealNameViewController?
    weak var photoVC: MealPhotoViewController?
    weak var ratingVC: MealRatingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
        }
    }
    
    //MARK: Navigation
    //Gestiona la vista que se vera cuando se cancele o se guarde la comida. Lo hace mirando si viene de un push o del modal.
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameVC?.nameTextField.text ?? ""
        let photo = photoVC?.photoImageView.image ?? meal?.photo
        let rating = ratingVC?.ratingControl.rating ?? meal?.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating ?? 0)
    }
    
    //MARK: Private Methods
    
    //Para cuando se esta escribiendo, quita el boton de guardar y ademas actualiza el titulo de la pagina
    func updateSaveButtonState(withText text: String) {
        // Disable the Save button if the text field is empty.
        saveButton.isEnabled = !text.isEmpty
        navigationItem.title = text
    }
}
