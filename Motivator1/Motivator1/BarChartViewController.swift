//
//  BarChartViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 27/02/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit
import Charts
import Firebase

class BarChartViewController: UIViewController {

    @IBOutlet weak var BarChart: BarChartView!
    
    var datesArray = [String]()
    var valuesArray = [Double]()
    var dataEntries = [BarChartDataEntry]()
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //BarChart.delegate = self
        setChartData()
        BarChart.chartDescription?.enabled = false
        
        BarChart.drawBarShadowEnabled = false
        BarChart.highlightFullBarEnabled = false
        
        BarChart.noDataText = "Loading data"
        BarChart.noDataTextColor = .white
        
        
        let l = BarChart.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.textColor = .white
        //        chartView.legend = l
        
        let rightAxis = BarChart.rightAxis
        rightAxis.axisMinimum = 0
        rightAxis.labelTextColor = .white
        
        let leftAxis = BarChart.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.labelTextColor = .white
        
        let xAxis = BarChart.xAxis
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        xAxis.labelTextColor = .white
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.valuesArray.reverse()
            self.updateChartData()
        })
        
        
    }
    func updateChartData(){
        print("\(valuesArray.count)")
        for i in 0...6{
            let entry = BarChartDataEntry(x: Double(i), y: valuesArray[i])
            dataEntries.append(entry)
        }
        
        let dataset = BarChartDataSet(values: dataEntries, label: "DailyXp")
        let data = BarChartData(dataSets: [dataset])
        BarChart.data = data
        BarChart.chartDescription?.text = "test"
        
        BarChart.notifyDataSetChanged()
        
    }
    
    func setChartData(){
        //let calender = Calendar.current
        let now = Date()
        let formater1 = DateFormatter()
        formater1.dateFormat = "dd-MM-yyyy"
        let formater2 = DateFormatter()
        formater2.dateFormat = "dd/MM"
        
        for i in 0...6{
            let dateElement = formater2.calendar.date(byAdding: .day, value: -i, to: now)
            datesArray.append(formater2.string(from: dateElement!))
            print("\(formater2.string(from: dateElement!))")
            
            let uid = Auth.auth().currentUser?.uid
           let dateElement2 = formater1.calendar.date(byAdding: .day, value: -i, to: now)
            let dateString = formater1.string(from: dateElement2!)
            ref.child("users").child(uid!).child("xp").child("dailyxp").child(dateString).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                var value = snapshot.value as? Double
                
                //if the value does not excist in database set it to 0.0
                if value == nil {
                    value = 0.0
                }
                self.valuesArray.append(value!)
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
        //valuesArray.reverse()
        datesArray.reverse()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BarChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return datesArray[Int(value) % datesArray.count]
    }
}
