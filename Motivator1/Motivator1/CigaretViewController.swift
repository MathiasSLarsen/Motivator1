//
//  CombinedChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import UIKit
import Charts

private let ITEM_COUNT = 12

class CigaretViewController: UIViewController {
   
    @IBOutlet weak var chartView: CombinedChartView!
    
    var firebase = Firebase.firebase
    var user = User.user
    let formatter = DateFormatter()
    var barDataEntries = [BarChartDataEntry]()
    var lineDataEntries = [ChartDataEntry]()
    var valuesArray = [Double]()
    
    let hoursArray = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebase.getCigarets()
        
        valuesArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
        chartView.chartDescription?.enabled = false
        
        chartView.drawBarShadowEnabled = false
        chartView.highlightFullBarEnabled = false
        
        
        chartView.drawOrder = [DrawOrder.bar.rawValue,                       DrawOrder.line.rawValue]
        
        let l = chartView.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        //        chartView.legend = l
        
        let rightAxis = chartView.rightAxis
        rightAxis.axisMinimum = 0
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        //xAxis.valueFormatter = self
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.updateChartData()
        })
        
    }
    
    func updateChartData() {
        for i in 0..<valuesArray.count{
            valuesArray[i] = 0
        }
        self.setChartData()
    }
    
    func setChartData() {
        let data = CombinedChartData()
        data.barData = generateBarData()
        data.lineData = generateLineData()
        
        chartView.xAxis.axisMaximum = data.xMax + 0.25
        
        chartView.data = data
    }
    
    
    func generateLineData() -> LineChartData {
        formatter.dateFormat = "H"
        let now = Int(formatter.string(from: Date()))
        for i in 0...now!{
            var sum = 0
            for j in 0..<i{
                sum = sum + Int(valuesArray[j])
            }
            let entry = ChartDataEntry(x: Double(i-1), y: Double(sum))
            lineDataEntries.append(entry)
            
        }
        let dataset = LineChartDataSet(values: lineDataEntries, label: "hej")
        let data = LineChartData(dataSets: [dataset])
        chartView.data = data
        chartView.chartDescription?.text = "test"
        
        chartView.notifyDataSetChanged()
        
        return data
        /*
        let entries = (0..<ITEM_COUNT).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i) + 0.5, y: Double(arc4random_uniform(15) + 5))
        }
        
        let set = LineChartDataSet(values: entries, label: "Line DataSet")
        set.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.lineWidth = 2.5
        set.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        
        set.axisDependency = .left
        
        return LineChartData(dataSet: set)
 */
    }
    
    func generateBarData() -> BarChartData {
        for i in 0..<user.cigiArray.count{
            let houre = Int(user.cigiArray[i].houre)
            valuesArray[houre!]+=1
        }
        for i in 0..<valuesArray.count{
            let entry = BarChartDataEntry(x: Double(i), y: valuesArray[i])
            barDataEntries.append(entry)
        }
        let dataset = BarChartDataSet(values: barDataEntries, label: "hej")
        let data = BarChartData(dataSets: [dataset])
        chartView.data = data
        chartView.chartDescription?.text = "test"
        
        chartView.notifyDataSetChanged()
        
        return data
    }
    
    @IBAction func addCigaret(_ sender: Any) {
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.string(from: Date())
        print(date)
        formatter.dateFormat = "H"
        let houre = formatter.string(from: Date())
        print(houre)
        let cigi = Cigaret(date: date, houre: houre)
        user.cigiArray.append(cigi)
        firebase.saveCigaret(cigaret: cigi)
        
        updateChartData()
    }
    
}

extension CigaretViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return hoursArray[Int(value) % hoursArray.count]
    }
}

