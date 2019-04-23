//
//  REST.swift
//  Motivator1
//
//  Created by Mathias Larsen on 23/04/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

struct RespondsData: Decodable{
    let id: Int
    let userName: String?
    let totalXp: Int?
    let dailyXp: [DailyXpResp]?
    let cigaret: [CigaretResp]?
    let achievements: [AchievementsResp]?
   
    
    /*
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        userName = json["userName"] as? String ?? "def"
        totalXp = json["totalXp"] as? Int ?? 0
        dailyXp = json["dailyXp"] as? [DailyXpResp] ?? []
        cigaret = json["cigaret"] as? [CigaretResp] ?? []
        achievements = json["achievements"] as? [achievementsResp] ?? []
        
    }
 */
}

struct DailyXpResp: Decodable{
    let id: Int?
    let userId: Int?
    let dailyXP: Int?
    let dateTime: Date?
}

struct CigaretResp: Decodable {
    let id: Int?
    let dateTime: Date?
    let userId: Int?
    let hour: Int?
}

struct AchievementsResp: Decodable {
    let id: Int?
    let userId: Int?
    let name: String?
    let dateTime: Date?
    let streakDays: Int?
}

class REST {
    
    static let rest = REST()
    var user = User.user
    
    func createUser(username: String){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/users")
        let parameter = ["userName": username, "totalXp": user.lvlSystem.xp] as [String : Any]
        var urlRequest = URLRequest(url: url! as URL)
        let session = URLSession.shared
        urlRequest.httpMethod = "POST"
        
        do{
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        }
        catch let error{
            print(error.localizedDescription)
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: urlRequest) { (data, responds, error) in
        
            guard let data = data else {return}
            
            do{
                let respondsData = try JSONDecoder().decode(RespondsData.self, from: data)
                print("user id is: \(respondsData.id)")
                self.user.dbId = respondsData.id
            }catch let jsonError{
                print("error", jsonError)
            }
        }.resume()
    }
    
}
