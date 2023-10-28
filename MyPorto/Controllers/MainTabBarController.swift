//
//  MainTabBarController.swift
//  MyPorto
//
//  Created by Panca Setiawan on 28/10/23.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBar()
    }
    
    func setTabBar() {
        self.delegate = self
        
        let vc1 = UINavigationController(rootViewController: DonutChartViewController())
        let vc2 = UINavigationController(rootViewController: LineChartViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "chart.pie.fill")
        vc2.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
       
        vc1.title = "Donut Chart"
        vc2.title = "Line Chart"
        
        tabBar.tintColor = .red
        
        setViewControllers([vc1, vc2], animated: true)
    }

}
