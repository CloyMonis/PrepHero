//
//  ActivityViewCell.swift
//  PrepHero
//
//  Created by Admin_Vserv on 22/04/23.
//

import UIKit

class ActivityViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var subHeaderLbl: UILabel!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityLevel: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 8
        activityView.layer.cornerRadius = 5
    }
    
    static func getCellName() -> String {
        return "activityCell"
    }

}
