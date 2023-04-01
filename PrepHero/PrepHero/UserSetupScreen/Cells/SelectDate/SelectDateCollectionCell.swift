//
//  SelectDateCollectionCell.swift
//  PrepHero
//
//  Created by Admin_Vserv on 01/04/23.
//

import UIKit

class SelectDateCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var date_Lbl: UILabel!
    @IBOutlet weak var dateSelected: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        dateSelected.backgroundColor = UIColor(hex: "#EAEAEA")
    }
    
    override func prepareForReuse() {
        dateSelected.backgroundColor = UIColor(hex: "#EAEAEA")
    }
    
    static func getCellName() -> String {
        return "selectDate"
    }

}
