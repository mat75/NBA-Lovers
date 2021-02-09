//
//  TeamsViewController.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 08/02/2021.
//

import UIKit

class TeamsViewController: UIViewController {
    
    @IBOutlet var tableView: CustomTableView!
    var teamsArray = [Team]()
    var selectedTeam:Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setStatusBar(backgroundColor: .systemIndigo)
        self.tableView.refreshIndicator.addTarget(self, action: #selector(loadTeams), for: .valueChanged)
        setupTableView()
        loadTeams()
    }
    
    //load all teams from API
    @objc func loadTeams(){
        self.tableView.activityIndicator.startAnimating()
        self.tableView.messageLabel.text = "Loading teams..."
        RapidApi.shared.loadTeams { (error, teams) in
            if error == nil {
                self.teamsArray = []
                DispatchQueue.main.async {
                    self.teamsArray = teams
                    self.tableView.activityIndicator.stopAnimating()
                    self.tableView.refreshIndicator.endRefreshing()
                    self.tableView.reloadData()
                }
            }else{
                print(error.debugDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
extension TeamsViewController : UITableViewDataSource {
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
}

//MARK: - table view delegate
extension TeamsViewController : UITableViewDelegate {
    
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
