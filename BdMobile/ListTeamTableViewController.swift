//
//  ViewController.swift
//  BdMobile
//
//  Created by Emilien Champion on 24/02/2021.
//

import UIKit
import CoreData
class ListTeamTableViewController: UITableViewController {
    
    private var teams: [Team] = []
    
    private var managedContext: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        teams = fetchTeamsFromCoreData()
        
        // Do any additional setup after loading the view.
    }
    
    private func fetchTeamsFromCoreData() -> [Team] {
        let fetchRq: NSFetchRequest<Team> = Team.fetchRequest()
        do {
            return try managedContext.fetch(fetchRq)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        
        case "add_team":
            let navigationC = segue.destination as! UINavigationController
            let destination = navigationC.topViewController as! AddTeamTableViewController
            destination.delegate = self
            
        case "team_detail":
            let destination = segue.destination as! TeamTableViewController
            destination.loadTeam(team: teams[tableView.indexPath(for: sender as! UITableViewCell)!.row])
            
        default:
            print("unknown identifier")
        }
       
           
        
        
        
            
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "team_list_cell", for: indexPath)
        let team = teams[indexPath.row]
        cell.textLabel?.text = team.name
        cell.detailTextLabel?.text = String(team.hltv_points)
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            managedContext.delete(teams[indexPath.row])
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            teams.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
            
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


}

extension ListTeamTableViewController: AddTeamTableViewControllerDelegate {
    func addTeamTableViewController(_ controller: AddTeamTableViewController, didAddTeam team: Team) {
        /// version cloudkit avec fetch v1
        teams = fetchTeamsFromCoreData()
        tableView.reloadData()
        
        
        
        /// version autre v2
    }
    
    
}
