//
//  AddTeamTableViewController.swift
//  BdMobile
//
//  Created by Emilien Champion on 22/03/2021.
//

import UIKit
import CoreData

class AddTeamTableViewController: UITableViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var teamNameTextField: UITextField!
    
    @IBOutlet weak var teamOwnerTextField: UITextField!
    private var managedContext: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    weak var delegate: AddTeamTableViewControllerDelegate?
    
    private var team: Team = Team(context: AppDelegate.shared.persistentContainer.viewContext)
    
    @IBAction func doneButton(_ sender: Any) {
        team.name = teamNameTextField.text
        team.owner = teamOwnerTextField.text
     
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        delegate?.addTeamTableViewController(self, didAddTeam: team)
        dismiss(animated: true, completion: nil)
    }
    
  
    
  

}

protocol AddTeamTableViewControllerDelegate: class {
    func addTeamTableViewController(_ controller: AddTeamTableViewController, didAddTeam team: Team)
}
