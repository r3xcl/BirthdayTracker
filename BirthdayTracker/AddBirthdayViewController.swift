//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Matthew on 05.11.2021.
//

import UIKit

protocol AddBirthdayViewControllerDelegate {
    func addBirthdayViewController (addBirthdayViewController : AddBirthdayViewController, didAddBirthday birthday : Birthday)
}

class AddBirthdayViewController: UIViewController {
    
    @IBOutlet var firstNameInput : UITextField!
    @IBOutlet var lastNameInput : UITextField!
    @IBOutlet var birthDatePicker : UIDatePicker!
    
    var delegate: AddBirthdayViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthDatePicker.maximumDate = Date()

    }
    
    @IBAction func saveBut(){
        let firstName = firstNameInput.text ?? ""
        let lastName = lastNameInput.text ?? ""
        let birthDate = birthDatePicker.date
        
        let newBirthday = Birthday(firstName: firstName, lastName: lastName, birthDate: birthDate)
        
        delegate?.addBirthdayViewController(addBirthdayViewController: self, didAddBirthday: newBirthday)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBut(){
        dismiss(animated: true, completion: nil)
    }
    
    


}

