//
//  AchivmentTableViewController.swift
//  
//
//  Created by Mathias Larsen on 31/03/2019.
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
        cellDataArray = [cellData(message: "test", progress: 0.3, progressText: "1/3")]
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AchivmentTableViewCell", owner: self, options: nil)?.first as! AchivmentTableViewCell
        
        cell.messageLable.text = cellDataArray[indexPath.row].message
        cell.progressBar.progress = cellDataArray[indexPath.row].progress
        cell.progressTextLable.text = cellDataArray[indexPath.row].progressText
        
        return cell
    }
}
