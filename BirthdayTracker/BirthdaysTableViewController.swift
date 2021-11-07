//
//  BirthdaysTableViewController.swift
//  BirthdayTracker
//
//  Created by Matthew on 06.11.2021.
//

import UIKit
import CoreData

class BirthdaysTableViewController: UITableViewController,AddBirthdayViewControllerDelegate{
    func addBirthdayViewController(addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday) {
        
        birthdays.append(birthday)
        tableView.reloadData()
    
        
    }
    
    
    var birthdays = [Birthday]()
    
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        //RU ЛОКАЛИЗАЦИЯ dateFormatter
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = Birthday.fetchRequest() as NSFetchRequest<Birthday>
        
        //СОРТИРОВКА СПИСКА
        
        let sortDesc1 = NSSortDescriptor(key: "lastName", ascending: true)
        let sortDesc2 = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [sortDesc1,sortDesc2]
        
        do{
            birthdays = try context.fetch(fetchRequest)
        }catch let error {
            print("Данные не загружены :\(error)")
        }
        tableView.reloadData()
    }
    


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCellIdentifier", for: indexPath)
        let birthday = birthdays[indexPath.row]
        let firstName = birthday.firstName ?? ""
        let lastName = birthday.lastName ?? ""
        cell.textLabel?.text = firstName + " " + lastName
        
        if let date = birthday.birthDate as Date? {
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        }else {
            cell.detailTextLabel?.text = " "
        }
        
        return cell 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let addBirthdayViewController = navigationController.topViewController as! AddBirthdayViewController
        
        addBirthdayViewController.delegate = self
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
