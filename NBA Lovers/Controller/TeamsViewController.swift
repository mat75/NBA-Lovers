//
//  TeamsViewController.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 08/02/2021.
//

import UIKit

class TeamsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var teamsArray = [Team]()
    var selectedTeam:Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setStatusBar(backgroundColor: .systemIndigo)
        setupTableView()
    }
    
    //load all teams from API
    func loadTeams(){
        RapidApi.shared.loadTeams { (completed, teams) in
            if completed {
                self.teamsArray = []
                DispatchQueue.main.async {
                    self.teamsArray = teams
                    print(self.teamsArray)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTeams()
    }
    
    //setup table view programatically
    func setupTableView(){
        self.tableView.register(UINib(nibName: K.teamCellNibName, bundle: nil), forCellReuseIdentifier: K.teamcellIdentifier)
        self.tableView.backgroundColor = .dirtyWhite
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}
    
//MARK: - table view datasource
extension TeamsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = self.teamsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.teamcellIdentifier) as! TeamTableViewCell
            cell.setupTeam(team: team)
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    //MARK: - table view delegate

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let team = self.teamsArray[indexPath.row]
            self.selectedTeam = team
            self.performSegue(withIdentifier: K.SegueIdentifier.toTeamDetails, sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == K.SegueIdentifier.toTeamDetails {
                if let controller = segue.destination as? PlayersListViewController {
                    controller.team = self.selectedTeam
                }
            }
        }
}



