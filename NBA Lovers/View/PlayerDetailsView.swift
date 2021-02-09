//
//  PlayerDetailsView.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 09/02/2021.
//

import UIKit

class PlayerDetailsView: UIView {

    @IBOutlet weak var playersName: UILabel!
    @IBOutlet weak var playersTeam: UILabel!
     @IBOutlet weak var playersWeight: UILabel!
    @IBOutlet weak var playersHeight: UILabel!
    @IBOutlet weak var weightImage: UIImageView!
    @IBOutlet weak var heightImage: UIImageView!
    override func draw(_ rect: CGRect){
        self.weightImage.image = UIImage(named:"weight")?.withRenderingMode(.alwaysTemplate)
        self.heightImage.image = UIImage(named:"height")?.withRenderingMode(.alwaysTemplate)
        weightImage.tintColor = .white
        heightImage.tintColor = .white
    }
}
