//
//  MainViewController.swift
//  MyPorto
//
//  Created by Panca Setiawan on 27/10/23.
//

import UIKit
import Charts

class MainViewController: UIViewController, ChartViewDelegate {
    
    //var pieChart = PieChartView()

    override func viewDidLoad() {
        super.viewDidLoad()

        //pieChart.delegate = self
        
        updateChartData()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        pieChart.frame = CGRect(x: 0, y: 0,
//                                width: self.view.frame.size.width,
//                                height: self.view.frame.size.width)
//        pieChart.center = view.center
//
//        view.addSubview(pieChart)
//
//        var entries = [ChartDataEntry]()
//
//        for x in 0..<10{
//            entries.append(ChartDataEntry(x: Double(x),
//                                          y: Double(x)))
//        }
//
//        let set = PieChartDataSet(entries: entries)
//        set.colors = ChartColorTemplates.colorful()
//        let data = PieChartData(dataSet: set)
//        pieChart.data = data
//    }
    
    func updateChartData()  {

        let chart = PieChartView(frame: self.view.frame)
        // 2. generate chart data entries
        let track = ["Income", "Expense", "Wallet", "Bank"]
        let money = [650, 456.13, 78.67, 856.52]

        var entries = [PieChartDataEntry]()
        for (index, value) in money.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = value
            entry.label = track[index]
            entries.append(entry)
        }

        // 3. chart setup
        let set = PieChartDataSet(entries: entries, label: "Pie Chart")
        // this is custom extension method. Download the code for more details.
        set.colors = ChartColorTemplates.colorful()
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        // user interaction
        chart.isUserInteractionEnabled = true

        chart.centerText = "Pie Chart"
        chart.holeRadiusPercent = 0.5
        chart.transparentCircleColor = UIColor.clear
        self.view.addSubview(chart)

    }
}
