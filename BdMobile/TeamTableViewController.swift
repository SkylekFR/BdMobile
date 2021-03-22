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
    private var team: Team = Team()
    
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
            cell.textLabel?.text = (team.players?.allObjects as! [Player])[indexPath.row].firstname
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
