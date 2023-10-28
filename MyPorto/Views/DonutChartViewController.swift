//
//  DonutChartViewController.swift
//  MyPorto
//
//  Created by Panca Setiawan on 28/10/23.
//

import UIKit
import Charts

class DonutChartViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var donutChartView: PieChartView!
    @IBOutlet weak var chartWidth: NSLayoutConstraint!
    @IBOutlet weak var chartHeight: NSLayoutConstraint!
    
    var donutDataItem = [DonutDataItem]()
    var dataItemLabel = [String]()
    var dataItemPercentage = [Double]()
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTitle.text = "My Portfolio"
        //setChart(dataPoints: players, values: goals.map{ Double($0) })
        fetchDonutChartData()
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        chartWidth.constant = screenWidth - 30
        chartHeight.constant = chartWidth.constant
        
        super.updateViewConstraints()
    }
    
    func fetchDonutChartData() {
        guard let path = Bundle.main.path(forResource: "DataChart", ofType: "json") else {
            print("JSON file not found.")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let chartData = try JSONDecoder().decode([DataChartResponse].self, from: data)
            if let donutData = chartData.first(where: { $0.type == "donutChart" }) {
                switch donutData.data {
                case .donutChart(let dataItems):
                    self.donutDataItem = dataItems
                    for i in 0..<dataItems.count {
                        self.dataItemLabel.append(dataItems[i].label)
                        self.dataItemPercentage.append(Double(dataItems[i].percentage) ?? 0.0)
                    }
                    setChart(dataPoints: dataItemLabel, values: dataItemPercentage)
                default:
                    print("Failed to get data")
                }
            }
        } catch {
            print(error)
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        print("Disiiiiiniiii")
        donutChartView.delegate = self
        // 1. Set ChartDataEntry
          var dataEntries: [ChartDataEntry] = []
          for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
          }
          // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = ChartColorTemplates.colorful()
          // 3. Set ChartData
          let pieChartData = PieChartData(dataSet: pieChartDataSet)
          let format = NumberFormatter()
          format.numberStyle = .none
          let formatter = DefaultValueFormatter(formatter: format)
          pieChartData.setValueFormatter(formatter)
          // 4. Assign it to the chart’s data
          donutChartView.data = pieChartData
    }

}

extension DonutChartViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //print(entry.y)
        for i in 0..<dataItemPercentage.count {
            if dataItemPercentage[i] == entry.y {
//                print(i)
//                print(donutDataItem[i].data)
//                print(entry.y)
                
                DispatchQueue.main.async(){
                    let xib = DetailTransactionViewController(nibName: "DetailTransactionViewController", bundle: nil)
                    xib.titleItem = self.donutDataItem[i].label
                    print(self.donutDataItem[i].label)
                    xib.transactions = self.donutDataItem[i].data
                    let navController = UINavigationController(rootViewController: xib)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
                }
            }
        }
    }
}
