//
//  DetailTransactionViewController.swift
//  MyPorto
//
//  Created by Panca Setiawan on 28/10/23.
//

import UIKit

class DetailTransactionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titleItem = ""
    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setTableView()
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .blue
        
        let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth - (screenWidth/3), height: 30.0))
        let tapGestureback = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer:)))
        customView.isUserInteractionEnabled = true
        customView.addGestureRecognizer(tapGestureback)
        
        let button = UIButton.init(type: .custom)
        button.setBackgroundImage(UIImage(named: "IconBack"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 8, width: 10.0, height: 15.0)
        button.addTarget(self, action: #selector(menuBack), for: .touchUpInside)
        customView.addSubview(button)
        
        let label_nav = UILabel(frame: CGRect(x: 30, y: 0, width: screenWidth - (screenWidth/3), height: 30.0))
        label_nav.text = titleItem
        label_nav.textColor = UIColor.white
        label_nav.textAlignment = .left
        label_nav.font = UIFont(name: "Helvetica-Regular", size: 20)
        customView.addSubview(label_nav)
        
        let leftButton = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
    func setTableView() {
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib.init(nibName: "ItemCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        self.tableView.separatorStyle = .none
    }
    
    @objc func viewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @objc func menuBack(sender: UIButton!) {
        self.dismiss(animated: true)
    }

}

extension DetailTransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let dict = transactions[indexPath.row]
        cell.labelDate.text = dict.trx_date
        cell.labelNominal.text = "Rp. \(Int(dict.nominal))"
        
        cell.selectionStyle = ItemCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = transactions[indexPath.row]
        
        print(dict.trx_date)
    }
    
    
}
