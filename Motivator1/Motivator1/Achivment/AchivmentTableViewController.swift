//
//  AchivmentTableViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 31/03/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit

struct cellData {
    let message : String?
    let progress : Float?
    let progressText : String?
}
class AchivmentTableViewController: UITableViewController {

    var user = User.user
    
    var cellDataArray = [cellData]()
    
    
    @IBOutlet var appTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fillArray()
    }
    override func viewDidAppear(_ animated: Bool) {
        print("candy days \(user.candyAchive.days)")
        print("elements in array \(cellDataArray.count)")
        cellDataArray.removeAll()
        print("elements in array \(cellDataArray.count)")
        
        fillArray()
        print("elements in array \(cellDataArray.count)")
        self.tableView.reloadData()
    }
    
    
    func fillArray(){
        var tempCellData = cellData(message: "Don't eat fast food", progress: user.foodAchiv.progress(), progressText: "\(user.foodAchiv.days)/\(user.foodAchiv.Next())")
        cellDataArray.append(tempCellData)
        
        tempCellData = cellData(message: "Don't drink soda", progress: user.sodaAchive.progress(), progressText: "\(user.sodaAchive.days)/\(user.sodaAchive.Next())")
        cellDataArray.append(tempCellData)
        
        tempCellData = cellData(message: "Don't eat candy", progress: user.candyAchive.progress(), progressText: "\(user.candyAchive.days)/\(user.candyAchive.Next())")
        cellDataArray.append(tempCellData)
        
        tempCellData = cellData(message: "Don't smoke cigarettes", progress: user.cigiAchive.progress(), progressText: "\(user.cigiAchive.days)/\(user.cigiAchive.Next())")
        cellDataArray.append(tempCellData)
        
        tempCellData = cellData(message: "Don't vape", progress: user.vapeAchive.progress(), progressText: "\(user.vapeAchive.days)/\(user.vapeAchive.Next())")
        cellDataArray.append(tempCellData)
        
        tempCellData = cellData(message: "Burn over 100 Kcal", progress: user.over100Achive.progress(), progressText: "\(user.over100Achive.days)/\(user.over100Achive.Next())")
        cellDataArray.append(tempCellData)
        
        tempCellData = cellData(message: "Burn over 200 Kcal", progress: user.over200Achive.progress(), progressText: "\(user.over200Achive.days)/\(user.over200Achive.Next())")
        cellDataArray.append(tempCellData)
        
        tempCellData = cellData(message: "Burn over 300 Kcal", progress: user.over300Achive.progress(), progressText: "\(user.over300Achive.days)/\(user.over300Achive.Next())")
        cellDataArray.append(tempCellData)
        
        tempCellData = cellData(message: "Burn over 400 Kcal", progress: user.over400Achvie.progress(), progressText: "\(user.over400Achvie.days)/\(user.over400Achvie.Next())")
        cellDataArray.append(tempCellData)
        
        tempCellData = cellData(message: "Burn over 500 Kcal", progress: user.over500Achive.progress(), progressText: "\(user.over500Achive.days)/\(user.over500Achive.Next())")
        cellDataArray.append(tempCellData)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("AchivmentTableViewCell", owner: self, options: nil)?.first as! AchivmentTableViewCell
        
        cell.messageLable.text = cellDataArray[indexPath.row].message!
        cell.progressBar.progress = cellDataArray[indexPath.row].progress!
        cell.progressLable.text = cellDataArray[indexPath.row].progressText!
        
        return cell
    }
}
