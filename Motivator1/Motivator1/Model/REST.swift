//
//  REST.swift
//  Motivator1
//
//  Created by Mathias Larsen on 23/04/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation

struct UserResp: Decodable{
    let id: Int
    let userName: String?
    let totalXp: Int?
    let kcals: Int?
    let kcalsTimeDate: String?
    let dailyXps: [DailyXps]?
    let cigaret: [CigaretResp]?
    let achievements: [Achievements]?
}

struct DailyXps: Decodable{
    let id: Int?
    let userId: Int?
    let dailyXP: Int?
    let dateTime: String?
}

struct CigaretResp: Decodable {
    let id: Int?
    let dateTime: Date?
    let userId: Int?
    let hour: Int?
}

struct Achievements: Decodable {
    let id: Int?
    let userId: Int?
    let name: String?
    let dateTime: String?
    let streakDays: Int?
}

class REST {
    
    static let rest = REST()
    var user = User.user
    var firebase = Firebase.firebase
    
    func createUser(username: String){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/users")
        let parameter = ["userName": username,
                         "totalXp": user.lvlSystem.xp,
                         "kcals": user.kcal.kcal ,
                         "KcalsTimeDate": user.kcal.date] as [String : Any]
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
                let respondsData = try JSONDecoder().decode(UserResp.self, from: data)
                print("user id is: \(respondsData.id)")
                self.user.dbId = respondsData.id
                self.user.userName = respondsData.userName!
                print("userid is set to: \(self.user.dbId)")
            }catch let jsonError{
                print("error", jsonError)
                print("error in create user")
            }
        }.resume()
    }
    
    func updateUser(){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/users/\(user.dbId)")
        let parameter = ["id": user.dbId,
                         "userName": user.userName,
                         "totalXp": user.lvlSystem.xp,
                         "kcals": user.kcal.kcal,
                         "KcalsTimeDate": user.kcal.date] as [String : Any]
        var urlRequest = URLRequest(url: url! as URL)
        let session = URLSession.shared
        urlRequest.httpMethod = "PUT"
        
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
                let respondsData = try JSONDecoder().decode(UserResp.self, from: data)
                print("user id is: \(respondsData.id)")
                //self.user.dbId = respondsData.id
                print("userid is set to: \(self.user.dbId)")
            }catch let jsonError{
                print("error", jsonError)
                print("error in update user")
            }
            }.resume()
    }
    
    func createDailyxp(){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/dailyxps")
        let parameter = ["userId": user.dbId,
                         "dailyXp": user.lvlSystem.dalyXp,
                         "dateTime": user.lvlSystem.date] as [String : Any]
        print("ffffffffffffffffff \(user.dbId)")
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
                let respondsData = try JSONDecoder().decode(DailyXps.self, from: data)
                print("user id is: \(respondsData.id!)")
                self.user.lvlSystem.dailyId = respondsData.id!
                print("dailyid is set to: \(self.user.lvlSystem.dailyId)")
            }catch let jsonError{
                print("error", jsonError)
                print("error in create daily")
            }
 
 
            }.resume()
    }
    
    func createNormAchievement(achievement: NormAchivement){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/achievements")
        let parameter = ["userId": user.dbId,
                         "name": achievement.name,
                         "dateTime": achievement.date,
                         "streakDays": achievement.days] as [String : Any]
        print("ffffffffffffffffff \(user.dbId)")
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
                let respondsData = try JSONDecoder().decode(DailyXps.self, from: data)
                print("user id is: \(respondsData.id!)")
                achievement.dbId = respondsData.id!
                print("achive is set to: \(achievement.dbId)")
            }catch let jsonError{
                print("error", jsonError)
                print("error in create achice")
            }
            
            
            }.resume()
    }
    
    func updateNormAchievement(achievement: NormAchivement){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/achievements")
        let parameter = ["id": achievement.dbId,
                         "userId": user.dbId,
                         "name": achievement.name,
                         "dateTime": achievement.date,
                         "streakDays": achievement.days] as [String : Any]
        print("ffffffffffffffffff \(user.dbId)")
        var urlRequest = URLRequest(url: url! as URL)
        let session = URLSession.shared
        urlRequest.httpMethod = "PUT"
        
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
                let respondsData = try JSONDecoder().decode(DailyXps.self, from: data)
                print("user id is: \(respondsData.id!)")
                //achievement.dbId = respondsData.id!
                print("achive is set to: \(achievement.dbId)")
            }catch let jsonError{
                print("error", jsonError)
                print("error in create achice")
            }
            
            
            }.resume()
    }
    
    func updateKcalAchievement(achievement: KcalAchivement){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/achievements/\(achievement.dbId)")
        let parameter = ["id": achievement.dbId,
                         "userId": user.dbId,
                         "name": achievement.name,
                         "dateTime": achievement.date,
                         "streakDays": achievement.days] as [String : Any]
        print("ffffffffffffffffff \(user.dbId)")
        var urlRequest = URLRequest(url: url! as URL)
        let session = URLSession.shared
        urlRequest.httpMethod = "PUT"
        
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
                let respondsData = try JSONDecoder().decode(DailyXps.self, from: data)
                print("user id is: \(respondsData.id!)")
                //achievement.dbId = respondsData.id!
                print("achive is set to: \(achievement.dbId)")
            }catch let jsonError{
                print("error", jsonError)
                print("error in update kcal achice")
            }
            
            
            }.resume()
    }
    
    func createKcalAchievement(achievement: KcalAchivement){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/achievements")
        let parameter = ["userId": user.dbId,
                         "name": achievement.name,
                         "dateTime": achievement.date,
                         "streakDays": achievement.days] as [String : Any]
        print("ffffffffffffffffff \(user.dbId)")
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
                let respondsData = try JSONDecoder().decode(DailyXps.self, from: data)
                print("user id is: \(respondsData.id!)")
                achievement.dbId = respondsData.id!
                print("achive is set to: \(achievement.dbId)")
            }catch let jsonError{
                print("error", jsonError)
                print("error in create kcal achice")
            }
            
            
            }.resume()
    }
    
    func initUser(id: Int){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/users/\(id)")
        
        var urlRequest = URLRequest(url: url! as URL)
        let session = URLSession.shared
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: urlRequest) { (data, responds, error) in
            
            guard let data = data else {return}
            
            do{
                let respondsData = try JSONDecoder().decode(UserResp.self, from: data)
                self.user.lvlSystem.xp = Double(respondsData.totalXp!)
                
                //set dailyxp
                
                for dailyxp in respondsData.dailyXps!{
                    if (dailyxp.dateTime?.elementsEqual(formatter.string(from: Date())))!{
                        self.user.lvlSystem.dalyXp = Double(dailyxp.dailyXP!)
                    }
                }
                
                //set all normAchievement
                for achieve in respondsData.achievements!{
                    for localAchieve in self.user.normAchiveArray{
                        if achieve.name == localAchieve.name{
                            localAchieve.days = achieve.streakDays!
                            localAchieve.dbId = achieve.id!
                            localAchieve.date = achieve.dateTime!
                        }
                    }
                }
                
                //set all kcalAchievement
                for achieve in respondsData.achievements!{
                    for localAchieve in self.user.kcalAchiveArray{
                        if achieve.name == localAchieve.name{
                            localAchieve.days = achieve.streakDays!
                            localAchieve.dbId = achieve.id!
                            localAchieve.date = achieve.dateTime!
                        }
                    }
                }
                
                //set kcal
                
                self.user.kcal.kcal = Double(respondsData.kcals!)
                self.user.kcal.date = respondsData.kcalsTimeDate!
 
            }catch let jsonError{
                print("error", jsonError)
                print("error in init user")
            }
            
            
            }.resume()
    }
}
