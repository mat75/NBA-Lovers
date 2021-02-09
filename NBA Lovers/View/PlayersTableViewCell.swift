//
//  PlayersTableViewCell.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 09/02/2021.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var conteiningView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .dirtyWhite
        self.playerNameLabel.textColor = .nbaDarkGray
        self.playerPositionLabel.layer.cornerRadius = 24
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.conteiningView.layer.cornerRadius = 8
        let shadowPath = UIBezierPath(roundedRect: self.conteiningView.bounds, cornerRadius: 8)
        self.conteiningView.layer.borderWidth = 0.1
        self.conteiningView.clipsToBounds = true
        self.conteiningView.layer.masksToBounds = false
        self.conteiningView.layer.shadowColor = UIColor.lightGray.cgColor
        self.conteiningView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.conteiningView.layer.shadowOpacity = 0.25
        self.conteiningView.layer.shadowPath = shadowPath.cgPath
    }
    
    func setupPlayer(player:Player){
        if let fullName = player.first_name, let lastName = player.last_name  {
            self.playerNameLabel.text = "\(fullName) \(lastName)"
        }
        if let position = player.position {
            if position != "" {
                self.playerPositionLabel.layer.backgroundColor = UIColor.systemIndigo.cgColor
                self.playerPositionLabel.textColor = .white
            }
            self.playerPositionLabel.text = position
        }
    }
    
    override func prepareForReuse() {
        self.playerPositionLabel.layer.backgroundColor = UIColor.clear.cgColor
    }
}
