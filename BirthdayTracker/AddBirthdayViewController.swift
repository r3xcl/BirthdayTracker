//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Matthew on 05.11.2021.
//

import UIKit
import CoreData

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
        
        //RU ЛОКАЛИЗАЦИЯ DATE PICKER
        birthDatePicker.locale = Locale(identifier: "ru_RU")
        

    }
    
    @IBAction func saveBut(){
        let firstName = firstNameInput.text ?? ""
        let lastName = lastNameInput.text ?? ""
        let birthDate = birthDatePicker.date
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context =   appDelegate.persistentContainer.viewContext
        
        let newBirthday = Birthday (context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthDate = birthDate as Date?
        newBirthday.birthDayId = UUID().uuidString
        
        delegate?.addBirthdayViewController(addBirthdayViewController: self, didAddBirthday: newBirthday)
        dismiss(animated: true, completion: nil)
        
        do{
            try context.save()
        }catch let error {
            print("Не сохранено :\(error).")
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBut(){
        dismiss(animated: true, completion: nil)
    }
    
    


}

