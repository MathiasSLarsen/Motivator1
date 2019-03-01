//
//  BarChartViewController.swift
//  Motivator1
//
//  Created by Mathias Larsen on 27/02/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet weak var BarChart: BarChartView!
    
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //BarChart.delegate = self
        
        BarChart.chartDescription?.enabled = false
        
        BarChart.drawBarShadowEnabled = false
        BarChart.highlightFullBarEnabled = false
        
        
        
        let l = BarChart.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        //        chartView.legend = l
        
        let rightAxis = BarChart.rightAxis
        rightAxis.axisMinimum = 0
        
        let leftAxis = BarChart.leftAxis
        leftAxis.axisMinimum = 0
        
        let xAxis = BarChart.xAxis
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        
        self.updateChartData()
    }
    func updateChartData(){
        let entry1 = BarChartDataEntry(x: 1, y: 6.6)
        let entry2 = BarChartDataEntry(x: 2, y: 9.6)
        let entry3 = BarChartDataEntry(x: 3, y: 3.6)
        let dataset = BarChartDataSet(values: [entry1, entry2, entry3], label: "hej")
        let data = BarChartData(dataSets: [dataset])
        BarChart.data = data
        BarChart.chartDescription?.text = "test"
        
        BarChart.notifyDataSetChanged()
        
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
        return months[Int(value) % months.count]
    }
}
