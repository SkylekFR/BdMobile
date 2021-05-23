//
//  TeamTableViewController.swift
//  BdMobile
//
//  Created by Emilien Champion on 03/03/2021.
//

import UIKit
import CoreData

class TeamTableViewController: UITableViewController {
    enum Section: CaseIterable {
        case informations
        case players
    }
    public var team: Team = Team()
    
    private var managedContext: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = team.name

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    public func loadTeam(team: Team) {
        self.team = team
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch Section.allCases[section] {
        case .informations:
            return 3
        case .players:
            return team.players!.count
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navDestination = segue.destination as! UINavigationController
        let destination = navDestination.topViewController as! AddPlayerTableViewController
        destination.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch Section.allCases[indexPath.section] {
        case .informations:
            cell = tableView.dequeueReusableCell(withIdentifier: "team_cell_information", for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Owner: \(team.owner ?? "unknown")"
            case 1:
                cell.textLabel?.text = "Hltv Points: \(team.hltv_points)"
            case 2:
                cell.textLabel?.text = "Ranking: No rank"
            default:
                cell.textLabel?.text = ""
            }
           
            
            
        case .players:
            cell = tableView.dequeueReusableCell(withIdentifier: "team_cell_player", for: indexPath)
            let player = (team.players?.allObjects as! [Player])[indexPath.row]
            cell.textLabel?.text = "\(player.firstname ?? "") \"\(player.username ?? "")\" \(player.lastname ?? "") | \(player.age) ans | \(player.rating) rating"
        }
        

        // Configure the cell...
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section.allCases[section] {
        case .informations:
            return "Team informations"
            
        case .players:
            return "Player list"
        }
    }

    

}

extension TeamTableViewController: AddPlayerTableViewControllerDelegate {
    func addPlayerTableViewController(_ controller: AddPlayerTableViewController, didAddPlayerInTeam team: Team) {
        loadTeam(team: team)
        tableView.reloadData()
    }
    
    
}
