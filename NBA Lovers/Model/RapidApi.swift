//
//  RapidApi.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 09/02/2021.
//

import Foundation
class RapidApi: NSObject {
    
    //API headers
    let headers = [
        "x-rapidapi-key": "18b10a868bmsh5dcca7c677df398p1d0622jsn48b8b3476537",
        "x-rapidapi-host": "free-nba.p.rapidapi.com"
    ]
    //SINGLENTON for RapidApi
    static let shared = RapidApi()
    
    //returns an array of Team
    func loadTeams(completion: @escaping (_ error:Error?, _ teams:[Team] ) -> ()){
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
                completion(nil, teamsResult.data)
            }else{
                guard let error = result.error else {return}
                completion(error, [])
            }
        }
    }
    
    //returns an array with all players data
    func loadPlayersData(completion: @escaping (_ error:Error?, _ playerData:PlayerData?) -> ()){
        let rest = RestManager()
        for (key, value) in headers {
            rest.requestHttpHeaders.add(value: value, forKey: key)
        }
        // 100 pages is maximum possible number of pages
        rest.makeRequest(withEndPoint: "players?per_page=100", withHttpMethod: .get) { (result) in
            guard let response = result.response else {return}
            if response.httpStatusCode == 200 {
                guard let data = result.data else {return}
                //print(data.printJSON())
                let decoder = JSONDecoder()
                guard let playerResult = try? decoder.decode(PlayerData.self, from: data) else { return }
                completion(nil, playerResult)
            }else{
                guard let error = result.error else {return}
                completion(error, nil)
            }
        }
    }
    
    func loadPlayersWithConcurrentCalls(team:Team, completion: @escaping (_ error:Error?, _ players:[Player]) -> ()){
        //Create a dispatch queue
        var players = [Player]()
        var playerData:PlayerData?
        self.loadPlayersData { (error, data) in
            if error != nil{
                print(error.debugDescription)
            }else{
                guard let data = data else {return}
                playerData = data
            }
            let rest = RestManager()
            for (key, value) in self.headers {
                rest.requestHttpHeaders.add(value: value, forKey: key)
            }
            //added semaphore and backgroundQueue to manage multiple api calls
            let backgroundQueue = DispatchQueue(label: "requests")
            let semaphore = DispatchSemaphore(value: 1)
            backgroundQueue.async {
                for page in 1..<playerData!.meta.total_pages! {
                    semaphore.wait()
                    rest.makeRequest(withEndPoint: "players?per_page=100&page=\(page)", withHttpMethod: .get) { (result) in
                        guard let response = result.response else {return}
                        if response.httpStatusCode == 200 {
                            guard let data = result.data else {return}
                            let decoder = JSONDecoder()
                            guard let playerResult = try? decoder.decode(PlayerData.self, from: data) else { return }
                            players.append(contentsOf: playerResult.data)
                                semaphore.signal()
                        }else{
                            print(response.httpStatusCode)
                            completion(error,[])
                        }
                        completion(nil,players)
                    }
                }
            }
        }
    }

    
}
