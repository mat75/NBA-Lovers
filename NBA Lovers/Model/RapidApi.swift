//
//  RapidApi.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 09/02/2021.
//

import Foundation
class RapidApi: NSObject {
    
    let headers = [
        "x-rapidapi-key": "18b10a868bmsh5dcca7c677df398p1d0622jsn48b8b3476537",
        "x-rapidapi-host": "free-nba.p.rapidapi.com"
    ]
    
    //SINGLENTON for RapidApi
    static let shared = RapidApi()
    
    func loadTeams(completion: @escaping (_ success:Bool, _ teams:[Team] ) -> ()){
        let rest = RestManager()
        for (key, value) in headers {
        rest.requestHttpHeaders.add(value: value, forKey: key)
        }
        rest.makeRequest(withEndPoint: "teams", withHttpMethod: .get) { (result) in
            guard let response = result.response else {return}
            if response.httpStatusCode == 200 {
                guard let data = result.data else {return}
                let decoder = JSONDecoder()
                guard let teamsResult = try? decoder.decode(Teamsdata.self, from: data) else { return }
                completion(true, teamsResult.data)
            }else{
                guard let error = result.error else {return}
                completion(false, [])
                print(error.localizedDescription)
            }
        }
    }
    func loadPlayersData(completion: @escaping (_ success:Bool, _ playerData:PlayerData?) -> ()){
        let rest = RestManager()
        for (key, value) in headers {
        rest.requestHttpHeaders.add(value: value, forKey: key)
        }
        rest.makeRequest(withEndPoint: "players?per_page=100", withHttpMethod: .get) { (result) in
            guard let response = result.response else {return}
            if response.httpStatusCode == 200 {
                guard let data = result.data else {return}
                print(data.printJSON())

                let decoder = JSONDecoder()
                guard let playerResult = try? decoder.decode(PlayerData.self, from: data) else { return }
                completion(true, playerResult)
            }else{
                guard let error = result.error else {return}
                completion(false, nil)
                print(error.localizedDescription)
            }
        }
    }
    
    func loadPlayers(team:Team, pages: Int?, completion: @escaping (_ success:Bool, _ players:[Player]) -> ()){
        var players = [Player]()
        let rest = RestManager()
        for (key, value) in headers {
        rest.requestHttpHeaders.add(value: value, forKey: key)
        }
        for page in 1..<pages! {
            rest.makeRequest(withEndPoint: "players?per_page=100&page=\(page)", withHttpMethod: .get) { (result) in
                guard let response = result.response else {return}
                if response.httpStatusCode == 200 {
                    guard let data = result.data else {return}
                    print(data.printJSON())
                    let decoder = JSONDecoder()
                    guard let playerResult = try? decoder.decode(PlayerData.self, from: data) else { return }
                    for player in playerResult.data {
                        DispatchQueue.main.async {
                            if player.team?.abbreviation == team.abbreviation {
                                players.append(player)
                            }
                        }
                    }
                }else{
                        guard let error = result.error else {return}
                        completion(false, [])
                        print(error.localizedDescription)
                }

                completion(true, players)

            }
        }
    }
}
