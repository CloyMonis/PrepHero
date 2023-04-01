//
//  SelectSubscriptionCollectionCell.swift
//  PrepHero
//
//  Created by Admin_Vserv on 01/04/23.
//

import UIKit

class SelectSubscriptionCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var title_Lbl: UILabel!
    @IBOutlet weak var subTitle_Lbl: UILabel!
    @IBOutlet weak var subscription_Img: UIImageView!
    @IBOutlet weak var includedPlan1_Lbl: UILabel!
    @IBOutlet weak var includedPlan1_Img: UIImageView!
    @IBOutlet weak var includedPlan2_Lbl: UILabel!
    @IBOutlet weak var includedPlan2_Img: UIImageView!
    @IBOutlet weak var includedPlan3_Lbl: UILabel!
    @IBOutlet weak var includedPlan3_Img: UIImageView!
    @IBOutlet weak var includedPlan4_Lbl: UILabel!
    @IBOutlet weak var includedPlan4_Img: UIImageView!
    @IBOutlet weak var getPlan_Btn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func getCellName() -> String {
        return "selectSubscription"
    }

}
