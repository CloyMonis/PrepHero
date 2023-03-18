//
//  LifeStyleCell.swift
//  PrepHero
//
//  Created by Cloy Vserv on 19/02/23.
//

import UIKit

class LifeStyleCell: UITableViewCell {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func updateSelection(state: Bool){
        switch state {
        case true:
            button.setImage(UIImage(named: "CheckBox_Filled"), for: .normal)
            containerView.layer.borderColor =  AppColors.viewActivity?.cgColor
        case false:
            button.setImage(UIImage(named: "CheckBox_Empty"), for: .normal)
            containerView.layer.borderColor =  AppColors.viewBorder
        }
    }
}
