//
//  AddTeamTableViewController.swift
//  BdMobile
//
//  Created by Emilien Champion on 22/03/2021.
//

import UIKit
import CoreData

class AddTeamTableViewController: UITableViewController {
    
    private var managedContext: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    weak var delegate: ListTeamTableViewController?
    
    private var team: Team = Team(context: AppDelegate.shared.persistentContainer.viewContext)
    
    @IBAction func doneButton(_ sender: Any) {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        delegate?.addTeamTableViewController(self, didAddTeam: team)
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "add_team_cell", for: indexPath)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

}

protocol AddTeamTableViewControllerDelegate: class {
    func addTeamTableViewController(_ controller: AddTeamTableViewController, didAddTeam team: Team)
}
