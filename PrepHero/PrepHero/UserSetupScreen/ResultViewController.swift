//
//  ResultViewController.swift
//  PrepHero
//
//  Created by Admin_Vserv on 01/04/23.
//

import UIKit

class ResultViewController: UIViewController {
    let viewFactory = CustomViewFactory()
    let selectDate_Arr = ["1 APRIL","2 APRIL","3 APRIL","4 APRIL","5 APRIL","6 APRIL"]
    let selectPlan_Arr1 = ["FAT LOSS","WEIGHT GAIN","BODY BUILDING"]
    let selectPlan_Arr2 = ["1100 - 1300 Cal.","1500 - 1800 Cal.","1800 - 2000 Cal."]
    @IBOutlet weak var yourResult_Lbl: UIView!
    @IBOutlet weak var summary_V: UIView!
    @IBOutlet weak var summaryChart_V: UIView!
    @IBOutlet weak var protien_Lbl: UILabel!
    @IBOutlet weak var protien_stack: UIStackView!
    @IBOutlet weak var carbs_Lbl: UILabel!
    @IBOutlet weak var carbs_stack: UIStackView!
    @IBOutlet weak var fat_Lbl: UILabel!
    @IBOutlet weak var fat_stack: UIStackView!
    @IBOutlet weak var recomPlan_Lbl: UIView!
    @IBOutlet weak var recomPlanSub_Lbl: UILabel!
    @IBOutlet weak var selectDateCollection: UICollectionView!
    @IBOutlet weak var breakFast_V: UIView!
    @IBOutlet weak var breakFast_Img: UIImageView!
    @IBOutlet weak var breakFast_Lbl: UILabel!
    @IBOutlet weak var lunch_V: UIView!
    @IBOutlet weak var lunch_Img: UIImageView!
    @IBOutlet weak var lunch_Lbl: UILabel!
    @IBOutlet weak var dinner_V: UIView!
    @IBOutlet weak var dinner_Img: UIImageView!
    @IBOutlet weak var dinner_Lbl: UILabel!
    @IBOutlet weak var am_snack_V: UIView!
    @IBOutlet weak var am_snack_Img: UIImageView!
    @IBOutlet weak var am_snack_Lbl: UILabel!
    @IBOutlet weak var pm_snack_V: UIView!
    @IBOutlet weak var pm_snack_Img: UIImageView!
    @IBOutlet weak var pm_snack_Lbl: UILabel!
    @IBOutlet weak var subNow_Lbl: UIView!
    @IBOutlet weak var selectPlanCollection: UICollectionView!
    @IBOutlet weak var selectAnotherPlan_Lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UPDATE HEADER's & SUB HEADER's
        updateHeaders()
        updateSubHeaders()
        
        // ADD CORNER RADIUS
        roundCorners()
        
        // REGISTER XIB's
        registerXIBs()
        
        // RELOAD COLLECTION VIEW
        selectDateCollection.reloadData()
        selectPlanCollection.reloadData()
        
    }

}

extension ResultViewController {
    func updateHeaders() {
        let yourResult = viewFactory.getLabel(font: .bold)
        yourResult.text = "YOUR RESULTS"
        yourResult.frame = CGRect(x: 26, y: 0, width: yourResult_Lbl.bounds.width, height: yourResult_Lbl.bounds.height)
        yourResult_Lbl.addSubview(yourResult)
        
        let recomPlan = viewFactory.getLabel(font: .bold)
        recomPlan.text = "RECOMENDED PLAN"
        recomPlan.frame = CGRect(x: 26, y: 0, width: recomPlan_Lbl.bounds.width, height: recomPlan_Lbl.bounds.height)
        recomPlan_Lbl.addSubview(recomPlan)
        
        let subNow = viewFactory.getLabel(font: .bold)
        subNow.text = "SUBSCRIBE NOW"
        subNow.frame = CGRect(x: 26, y: 0, width: subNow_Lbl.bounds.width, height: subNow_Lbl.bounds.height)
        subNow_Lbl.addSubview(subNow)
    }
    func updateSubHeaders() {
        viewFactory.updateLabel(for: protien_Lbl, font: .regular, text: "109g", size: 12)
        viewFactory.updateLabel(for: carbs_Lbl, font: .regular, text: "65g", size: 12)
        viewFactory.updateLabel(for: fat_Lbl, font: .regular, text: "143g", size: 12)
        
        viewFactory.updateLabel(for: breakFast_Lbl, font: .regular, text: "BREAKFAST", size: 15)
        viewFactory.updateLabel(for: lunch_Lbl, font: .regular, text: "LUNCH", size: 15)
        viewFactory.updateLabel(for: dinner_Lbl, font: .regular, text: "DINNER", size: 15)
        viewFactory.updateLabel(for: am_snack_Lbl, font: .regular, text: "AM SNACK", size: 15)
        viewFactory.updateLabel(for: pm_snack_Lbl, font: .regular, text: "PM SNACK", size: 15)
        
        viewFactory.updateLabel(for: selectAnotherPlan_Lbl, font: .regular, text: "SELECT ANOTHER PLAN", size: 14)
    }
    func roundCorners() {
        summary_V.layer.cornerRadius = 10
        summary_V.layer.borderWidth = 1.0
        summary_V.layer.borderColor = UIColor(hex: "#EAEAEA")?.cgColor
        
        breakFast_Img.layer.cornerRadius = 10.0
        lunch_Img.layer.cornerRadius = 10.0
        dinner_Img.layer.cornerRadius = 10.0
        am_snack_Img.layer.cornerRadius = 10.0
        pm_snack_Img.layer.cornerRadius = 10.0
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func registerXIBs () {
        selectDateCollection.register(UINib(nibName: "SelectDateCollectionCell", bundle: nil), forCellWithReuseIdentifier: SelectDateCollectionCell.getCellName())
        selectPlanCollection.register(UINib(nibName: "SelectSubscriptionCollectionCell", bundle: nil), forCellWithReuseIdentifier: SelectSubscriptionCollectionCell.getCellName())
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectDateCollection {
            return 5
        }
        if collectionView == selectPlanCollection {
            return 3
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == selectDateCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectDateCollectionCell.getCellName(), for: indexPath) as! SelectDateCollectionCell
            viewFactory.updateLabel(for: cell.date_Lbl, font: .bold, text: selectDate_Arr[indexPath.row], size: 15)
            cell.dateSelected.backgroundColor = indexPath.row == 0 ? UIColor(hex: "#FAA21C") : UIColor(hex: "#EAEAEA")
            cell.isSelected = indexPath.row == 0 ? true : false
            cell.isHighlighted = indexPath.row == 0 ? true : false
            return cell
        }
        if collectionView == selectPlanCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectSubscriptionCollectionCell.getCellName(), for: indexPath) as! SelectSubscriptionCollectionCell
            cell.backView.layer.cornerRadius = 10
            cell.backView.layer.borderWidth = 1.0
            cell.backView.layer.borderColor = UIColor(hex: "#EAEAEA")?.cgColor
            viewFactory.updateLabel(for: cell.title_Lbl, font: .regular, text: selectPlan_Arr1[indexPath.row], size: 14)
            viewFactory.updateLabel(for: cell.subTitle_Lbl, font: .regular, text: selectPlan_Arr2[indexPath.row], size: 14)
            cell.subscription_Img.layer.cornerRadius = 10.0
            viewFactory.updateLabel(for: cell.includedPlan1_Lbl, font: .regular, text: "Includes Breakfast, Lunch, Dinner & 2 Snacks", size: 10)
            viewFactory.updateLabel(for: cell.includedPlan2_Lbl, font: .regular, text: "Serves you recomended calorie range", size: 10)
            viewFactory.updateLabel(for: cell.includedPlan3_Lbl, font: .regular, text: "5 Days / 4 Weeks", size: 10)
            viewFactory.updateLabel(for: cell.includedPlan4_Lbl, font: .regular, text: "Unlimited Pauses / Changes", size: 10)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == selectDateCollection {
            return CGSize(width: 100, height: 35)
        }
        if collectionView == selectPlanCollection {
            return CGSize(width: 205, height: 420)
        }
        return CGSize()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == selectDateCollection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectDateCollectionCell.getCellName(), for: indexPath) as? SelectDateCollectionCell {
                cell.dateSelected.backgroundColor = UIColor(hex: "#FAA21C")
            }
        }
        if collectionView == selectPlanCollection {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == selectDateCollection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectDateCollectionCell.getCellName(), for: indexPath) as? SelectDateCollectionCell {
                cell.dateSelected.backgroundColor = UIColor(hex: "#EAEAEA")
            }
        }
    }
}
