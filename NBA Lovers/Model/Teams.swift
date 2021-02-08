//
//  Teams.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 09/02/2021.
//

import Foundation

struct Teamsdata:Decodable {
    var teams : [Teams]
}

struct Teams:Decodable {
    var id : Int?
    var abbreviation : String?
    var city : String?
    var conference : String?
    var division : String?
    var full_name : String?
    var name : String?
}
