//
//  PlayersListViewController.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 08/02/2021.
//

import UIKit

class PlayersListViewController: UIViewController {
    
    var team:Team?
    var playersArray = [Player]()
    @IBOutlet var tableView: CustomTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = team?.name
        setupTableView()
    }
    
    //load all teams from API
    func loadPlayers(){
        self.tableView.activityIndicator.startAnimating()
        self.tableView.messageLabel.text = "Loading players..."
        RapidApi.shared.loadPlayersData { (error, playerData) in
            if error == nil {
                self.playersArray = []
                if let pages = playerData?.meta.total_pages{
                    RapidApi.shared.loadPlayers(team: self.team! ,pages: pages) { (error, players) in
                        if error == nil {
                            DispatchQueue.main.async {
                                self.playersArray = players
                                self.tableView.activityIndicator.stopAnimating()
                                self.tableView.reloadData()
                            }
                        }else{
                            print(error?.localizedDescription)
                        }
                    }
                }
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPlayers()
    }
    
    //setup table view programatically
    func setupTableView(){
        self.tableView.register(UINib(nibName: K.playerCellNibName, bundle: nil), forCellReuseIdentifier: K.playerellIdentifier)
        self.tableView.register(CustomTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CustomTableViewHeaderFooterView.reuseIdentifer)

        self.tableView.backgroundColor = .dirtyWhite
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

//MARK: - table view datasource
extension PlayersListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = self.playersArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.playerellIdentifier) as! PlayersTableViewCell
        cell.setupPlayer(player: player)
        cell.isUserInteractionEnabled = true
        return cell
    }
}

//  MARK: - table view delegate

extension PlayersListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTableViewHeaderFooterView.reuseIdentifer) as? CustomTableViewHeaderFooterView else {
            return nil }
        header.tintColor = .dirtyWhite
        header.customLabel.textColor = .systemIndigo
            header.customLabel.text = "Team Players"
            return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 40
       }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = self.playersArray[indexPath.row]
        let alert = UIAlertController(title: "\(player.first_name!) \(player.last_name!)", message: "\(player.team?.full_name) \(player.id)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //            if segue.identifier == K.SegueIdentifier.toTeamDetails {
    //                if let controller = segue.destination as? PlayersListViewController {
    //                    controller.team = self.selectedTeam
    //                }
    //            }
    //        }
}

