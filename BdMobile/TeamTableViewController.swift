//
//  ViewController.swift
//  BdMobile
//
//  Created by Emilien Champion on 24/02/2021.
//

import UIKit
import CoreData
class TeamTableViewController: UITableViewController {
    
    private var teams: [Team] = []
    
    private var managedContext: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let team = Team(context: managedContext)
        team.name = "Vitality"
        team.hltv_points = 563
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "team_cell", for: indexPath)
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

