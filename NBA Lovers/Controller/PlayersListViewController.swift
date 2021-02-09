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
    @IBOutlet var tableView: UITableView!
    var selectedPlayer:Player?
    
    @IBOutlet weak var teamsTopView: TeamsTopView!
    var activityIndicator:UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        ai.color = .systemIndigo
        return ai
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = team?.name?.uppercased()
        if let city = team?.city {
            self.teamsTopView.cityTeam.text = city.uppercased()
        }
        if let division = team?.division {
            self.teamsTopView.teamConference.text = "\(division) division"
        }
    
        setupTableView()
    }
    
    //load all teams from API
    @objc func loadPlayers(){
        self.activityIndicator.startAnimating()
        RapidApi.shared.loadPlayersWithConcurrentCalls(team: team!) { (error, player) in
            if error != nil {
                // there is an error
                print(error.debugDescription)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.playersArray = player.filter({$0.team?.abbreviation == self.team?.abbreviation })
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPlayers()
    }
    
    //setup table view programatically
    func setupTableView(){
        self.tableView.refreshControl?.removeFromSuperview()
        self.tableView.register(UINib(nibName: K.playerCellNibName, bundle: nil), forCellReuseIdentifier: K.playerellIdentifier)
        self.tableView.register(CustomTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CustomTableViewHeaderFooterView.reuseIdentifer)
        self.tableView.backgroundColor = .dirtyWhite
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
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
        self.selectedPlayer = self.playersArray[indexPath.row]
        self.performSegue(withIdentifier: K.SegueIdentifier.playerSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.SegueIdentifier.playerSegue {
            if let controller = segue.destination as? PlayersInfoViewController {
                controller.player = self.selectedPlayer
            }
        }
    }
}

