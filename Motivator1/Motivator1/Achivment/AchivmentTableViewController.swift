//
//  AchivmentTableViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 31/03/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit

struct cellData {
    let message : String!
    let progress : Float!
    let progressText : String!
}
class AchivmentTableViewController: UITableViewController {

    var cellDataArray = [cellData]()
    override func viewDidLoad() {
        cellDataArray = [cellData(message: "test1", progress: 0.3, progressText: "1/3"),
                         cellData(message: "test2", progress: 0.5, progressText: "1/4"),
                         cellData(message: "test3", progress: 0.7, progressText: "1/5")]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("AchivmentTableViewCell", owner: self, options: nil)?.first as! AchivmentTableViewCell
        
        cell.messageLable.text = cellDataArray[indexPath.row].message
        cell.progressBar.progress = cellDataArray[indexPath.row].progress
        cell.progressLable.text = cellDataArray[indexPath.row].progressText
        
        return cell
    }
}
