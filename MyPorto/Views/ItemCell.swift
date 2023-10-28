//
//  ItemCell.swift
//  MyPorto
//
//  Created by Panca Setiawan on 28/10/23.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelNominal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = mainView.frame.height / 6
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.lightGray.cgColor
        mainView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
