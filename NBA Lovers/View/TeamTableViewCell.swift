//
//  TeamTableViewCell.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 08/02/2021.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamFullNameLabel: UILabel!
    @IBOutlet weak var teamAbbreviationLabel: UILabel!
    @IBOutlet weak var teamDivisionLabel: UILabel!
    @IBOutlet weak var teamCityLabel: UILabel!
    var team : Team?
    
    @IBOutlet weak var conteiningView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .dirtyWhite
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
    
    func setupTeam(team:Team){
        if let fullName = team.full_name {
            self.teamFullNameLabel.text = fullName
        }
        if let abbreviation = team.abbreviation {
            self.teamAbbreviationLabel.text = abbreviation
        }
        if let division = team.division {
            self.teamDivisionLabel.text = "\(division) division"
        }
        if let teamCity = team.city {
            self.teamCityLabel.text = teamCity
        }
    }    
}
