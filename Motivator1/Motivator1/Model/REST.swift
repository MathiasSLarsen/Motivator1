//
//  REST.swift
//  Motivator1
//
//  Created by Mathias Larsen on 23/04/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import Foundation
struct OldDaliyXp {
    let dailyXp: Double
    let date: String
}

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
                self.user.dbId = respondsData.id
                self.user.userName = respondsData.userName!
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
                self.user.lvlSystem.dailyId = respondsData.id!
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
                achievement.dbId = respondsData.id!
            }catch let jsonError{
                print("error", jsonError)
                print("error in create achice")
            }
            
            
            }.resume()
    }
    
    func updateNormAchievement(achievement: NormAchivement){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/achievements/\(achievement.dbId)")
        let parameter = ["id": achievement.dbId,
                         "userId": user.dbId,
                         "name": achievement.name,
                         "dateTime": achievement.date,
                         "streakDays": achievement.days] as [String : Any]
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
                achievement.dbId = respondsData.id!
            }catch let jsonError{
                print("error", jsonError)
                print("error in create kcal achice")
            }
            
            
            }.resume()
    }
    
    func initUser(id: Int){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        var url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/users/\(id)")
        
        var urlRequest = URLRequest(url: url! as URL)
        var session = URLSession.shared
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: urlRequest) { (data, responds, error) in
            
            guard let data = data else {return}
            
            do{
                let respondsData = try JSONDecoder().decode(UserResp.self, from: data)
                self.user.lvlSystem.xp = Double(respondsData.totalXp!)
                
                //set kcal
                self.user.kcal.kcal = Double(respondsData.kcals!)
                self.user.kcal.date = respondsData.kcalsTimeDate!
                //set dailyxp
                /*
                for dailyxp in respondsData.dailyXps!{
                    if (dailyxp.dateTime?.elementsEqual(formatter.string(from: Date())))!{
                        self.user.lvlSystem.dalyXp = Double(dailyxp.dailyXP!)
                    }
                }
                */
                /*
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
 */
            }catch let jsonError{
                print("error", jsonError)
                print("error in init user")
            }
            
            
            }.resume()
        
        //set dailyxp
        url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/dailyxps")
        urlRequest = URLRequest(url: url! as URL)
        session = URLSession.shared
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: urlRequest) { (data, responds, error) in
            
            guard let data = data else {return}
            
            do{
                let respondsData = try JSONDecoder().decode([DailyXps].self, from: data)
                for dailyxp in respondsData{
                    if (id == dailyxp.userId! && (dailyxp.dateTime?.elementsEqual(formatter.string(from: Date())))!){
                        self.user.lvlSystem.dalyXp = Double(dailyxp.dailyXP!)
                    }
                }
            }catch let jsonError{
                print("error", jsonError)
                print("error in get daily")
            }
            
            
            }.resume()
        
        //set avhievements
        url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/achievements")
        
        urlRequest = URLRequest(url: url! as URL)
        session = URLSession.shared
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: urlRequest) { (data, responds, error) in
            
            guard let data = data else {return}
            
            do{
                let respondsData = try JSONDecoder().decode([Achievements].self, from: data)
                
                for achieve in respondsData{
                    for localAchieve in self.user.normAchiveArray{
                        if achieve.name == localAchieve.name && id == achieve.userId{
                            localAchieve.days = achieve.streakDays!
                            localAchieve.dbId = achieve.id!
                            localAchieve.date = achieve.dateTime!
                            print("\(achieve.name) is set")
                        }
                    }
                }
                
                //set all kcalAchievement
                for achieve in respondsData{
                    for localAchieve in self.user.kcalAchiveArray{
                        if achieve.name == localAchieve.name && id == achieve.userId{
                            localAchieve.days = achieve.streakDays!
                            localAchieve.dbId = achieve.id!
                            localAchieve.date = achieve.dateTime!
                            print("\(achieve.name) is set")
                        }
                    }
                }
            }catch let jsonError{
                print("error", jsonError)
                print("error in get achievements")
            }
            
            
            }.resume()
        
    }
    
    func lastSevenDailyxp(){
        let url = NSURL(string: "https://motivatorapi.azurewebsites.net/api/users/\(user.dbId)/lastSevenDailyxps")
        var urlRequest = URLRequest(url: url! as URL)
        let session = URLSession.shared
        urlRequest.httpMethod = "GET"
        /*
        do{
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        }
        catch let error{
            print(error.localizedDescription)
        }
        */
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: urlRequest) { (data, responds, error) in
            
            guard let data = data else {return}
            
            do{
                let respondsData = try JSONDecoder().decode([DailyXps].self, from: data)
                for daily in respondsData{
                    print("oldDaily xp is \(daily.dailyXP!)")
                    let oldDailyXp = User.OldDailyXp.init(dailyXp: Double(daily.dailyXP!), date: daily.dateTime!)
                    self.user.oldDailyXpArray.append(oldDailyXp)
                }
            }catch let jsonError{
                print("error", jsonError)
                print("error in create daily")
            }
            
            
            }.resume()
    }
}
