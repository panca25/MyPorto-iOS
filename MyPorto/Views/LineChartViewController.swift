//
//  LineChartViewController.swift
//  MyPorto
//
//  Created by Panca Setiawan on 28/10/23.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var chartHeight: NSLayoutConstraint!
    @IBOutlet weak var chartWidth: NSLayoutConstraint!
    
    var dataLineChart = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTitle.text = "My Portfolio"
        fetchChartData()
    }
    
    override func updateViewConstraints() {
        chartWidth.constant = screenWidth - 30
        chartHeight.constant = chartWidth.constant
        
        super.updateViewConstraints()
    }
    
    func fetchChartData() {
        guard let path = Bundle.main.path(forResource: "DataChart", ofType: "json") else {
            print("JSON file not found.")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let chartData = try JSONDecoder().decode([DataChartResponse].self, from: data)
            if let lineData = chartData.first(where: { $0.type == "lineChart" }) {
                switch lineData.data {
                case .lineChart(let dataItems):
                    for i in 0..<dataItems.month.count {
                        self.dataLineChart.append(dataItems.month[i])
                    }
                    setChart()
                default:
                    print("Failed to get data")
                }
            }
        } catch {
            print(error)
        }
    }
    
    func setChart() {
        print("Disiiiiiniiii")
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataLineChart.count {
          let dataEntry = ChartDataEntry(x: Double(i), y: Double(dataLineChart[i]))
          dataEntries.append(dataEntry)
        }

        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
    }

}
