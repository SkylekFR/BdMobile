//
//  AddPlayerTableViewController.swift
//  BdMobile
//
//  Created by Emilien Champion on 23/05/2021.
//

import UIKit
import CoreData
class AddPlayerTableViewController: UITableViewController {
    
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var firstnameTextfield: UITextField!
    
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var ratingTextField: UITextField!
    
    
    @IBAction func saveButton(_ sender: Any) {
        player.firstname = firstnameTextfield.text
        player.lastname = lastnameTextField.text
        player.username = usernameTextField.text
        player.age = Int16(ageTextField.text ?? "0") ?? 0
        player.rating = Float(ratingTextField.text ?? "0") ?? 0.0
        delegate?.team.addToPlayers(player)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        dismiss(animated: true) {
            self.delegate?.addPlayerTableViewController(self, didAddPlayerInTeam: self.delegate!.team)
        }
    }
    
    
    private var managedContext: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    weak var delegate: TeamTableViewController?
    
    
    private var player: Player = Player(context: AppDelegate.shared.persistentContainer.viewContext)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
  
    
}

protocol AddPlayerTableViewControllerDelegate: class {
    func addPlayerTableViewController(_ controller: AddPlayerTableViewController, didAddPlayerInTeam team: Team)
}
