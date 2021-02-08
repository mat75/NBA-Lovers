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
    
    @IBOutlet weak var conteiningView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.conteiningView.layer.cornerRadius = 10
        self.conteiningView.layer.borderColor = UIColor.lightGray.cgColor
        self.conteiningView.layer.borderWidth = 0.7
        self.conteiningView.clipsToBounds = true
        self.backgroundColor = .dirtyWhite
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
