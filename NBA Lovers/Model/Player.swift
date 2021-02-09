//
//  Player.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 09/02/2021.
//

import Foundation
struct PlayerData : Decodable {
    var data:[Player]
    var meta:MetaDataPlayer
}
struct Player : Decodable {
    var id:Int?
    var first_name:String?
    var last_name:String?
    var height_feet:Int?
    var height_inches:Int?
    var position:String?
    var team:Team?
}

struct MetaDataPlayer : Decodable {
    var total_pages:Int?
    var current_page:Int?
    var next_page:Int?
    var per_page:Int?
    var total_count:Int?
}
