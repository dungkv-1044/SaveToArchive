//
//  PersonTableViewController.swift
//  SaveToArchive
//
//  Created by Khuất Dũng on 2/6/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import os.log


class PersonTableViewController: UITableViewController {

    var persons = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PersonTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PersonTableViewCell else {
            fatalError("The dequeued cell is not an instance of PersonTableViewCell")
        }
        let person = persons[indexPath.row]
        cell.nameLabel.text = person.name
        cell.phoneLabel.text = "\(person.phone!)"
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "AddPeople":
            os_log("Adding a new person", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let personDetailViewController = segue.destination as? ViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedPersonCell = sender as? PersonTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedPersonCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedPerson = persons[indexPath.row]
            personDetailViewController.person = selectedPerson
        default:
             fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: Private methods
    private func loadSampleData(){
        guard let sample1 = Person(name: "Dung", phone: 554) else {
            fatalError("Unable to instantiate person1")
        }
        persons += [sample1]
    }
    /// Unwind
    @IBAction func unwindToPersonList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let person = sourceViewController.person {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //update
                persons[selectedIndexPath.row] = person
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: persons.count, section: 0)
                persons.append(person)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    
    
    
    
}
