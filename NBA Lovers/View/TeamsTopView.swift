//
//  TeamsTopView.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 09/02/2021.
//

import UIKit

class TeamsTopView: UIView {
    
    @IBOutlet var teamConference:UILabel!
    @IBOutlet var cityTeam:UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    

}
