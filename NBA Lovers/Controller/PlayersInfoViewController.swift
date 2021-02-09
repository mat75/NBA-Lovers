//
//  PlayersInfoViewController.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 08/02/2021.
//

import UIKit

class PlayersInfoViewController: UIViewController {
    
    var player:Player?
    @IBOutlet var playersView: PlayerDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillOutPlayerInfo(player:self.player)
    }
    
    func fillOutPlayerInfo(player:Player?){
        if let playerName = player?.first_name , let playerLastName = player?.last_name {
            self.playersView.playersName.text = "\(playerName) \(playerLastName)"
        }
        if let playerTeam = player?.team?.full_name {
            self.playersView.playersTeam.text = playerTeam
        }
        if let heightFeet = player?.height_feet, let heightIncheds = player?.height_inches {
            self.playersView.playersHeight.text = "\(String(heightFeet)).\(String(heightIncheds)) ft"
        }else{
            self.playersView.playersHeight.text = "n/a"
        }
        if let weight = player?.weight_pounds {
            self.playersView.playersWeight.text = "\(String(weight)) lbs"
        }else{
            self.playersView.playersWeight.text = "n/a"
        }
    }
    
    @IBAction func dismissPlayerDetails(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
