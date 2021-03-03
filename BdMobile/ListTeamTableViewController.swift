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

    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* let team = Team(context: managedContext)
        let player = Player(context: managedContext)
        player.firstname = "Egor"
        team.name = "Vitalityprivate var teams: [Team] = []private var teams: [Team] = []"
        team.hltv_points = 563
        team.addToPlayers(player)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()*/
        
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
        let destination = segue.destination as! TeamTableViewController
        destination.loadTeam(team: teams[tableView.indexPath(for: sender as! UITableViewCell)!.row])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "team_list_cell", for: indexPath)
        let team = teams[indexPath.row]
        cell.textLabel?.text = team.name
        cell.detailTextLabel?.text = String(team.hltv_points)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


}

