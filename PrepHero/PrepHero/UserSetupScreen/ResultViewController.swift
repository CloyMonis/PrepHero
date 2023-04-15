//
//  ResultViewController.swift
//  PrepHero
//
//  Created by Admin_Vserv on 01/04/23.
//

import UIKit

class MenuOption {
    let date: String
    var isSelected: Bool = false
    init(date: String) {
        self.date = date
    }
}

class ResultViewController: UIViewController {
    var prepareResult = PrepareResultData()
    private let viewFactory = CustomViewFactory()
    private var selectMenu_Arr = [MenuOption]()
    private var selectPlan_Arr = [PreparePlanList]()
    private let cachedImages = NSCache<NSURL, UIImage>()
    private let apiDateFormat = "yyyy-MM-dd"
    private let showDateFormat = "d MMM"
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
        updateMenuArray()
        updatePlanArray()
        
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

extension ResultViewController {
    private func updateDateFormat(for date: String, from date1: String, to date2: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = date1
        let showDate = dateFormat.date(from: date)
        dateFormat.dateFormat = date2
        return dateFormat.string(from: showDate ?? Date())
    }
    private func updateMenuArray() {
        guard let menus = prepareResult.SampleMenu else {
            print("Sample Menu is empty or nil")
            return
        }
        for menu in menus {
            if let mealDate = menu.MealDate {
                let convertedDate = updateDateFormat(for: mealDate, from: apiDateFormat, to: showDateFormat).uppercased()
                if !selectMenu_Arr.contains(where: { $0.date == convertedDate }) {
                    selectMenu_Arr.append(MenuOption(date: convertedDate))
                }
            }
        }
        if selectMenu_Arr.count > 1 {
            selectMenu_Arr[0].isSelected = true
        }
    }
    private func updatePlanArray() {
        guard let plans = prepareResult.PlanList else {
            print("Plan List is empty or nil")
            return
        }
        for plan in plans {
            selectPlan_Arr.append(plan)
        }
    }
    private func updateImageArray(date: String) {
        let year = Calendar.current.component(.year, from: Date())
        guard let menus = prepareResult.SampleMenu else {
            print("Sample Menu is empty or nil")
            return
        }
        let convertedDate = updateDateFormat(for: date+" \(year)", from: showDateFormat, to: apiDateFormat)
        for menu in menus {
            if let mealDate = menu.MealDate {
                if mealDate == convertedDate {
                    if let mealName = menu.MealName {
                        DispatchQueue.main.async {
                            switch PrepareMeal(rawValue: mealName) {
                            case .none:
                                print("")
                            case .some(.breakfast):
                                self.breakFast_Img.image = self.loadImage(url: menu.RecipeImage) ?? UIImage(named: "breakfast")
                            case .some(.lunch):
                                self.lunch_Img.image = self.loadImage(url: menu.RecipeImage) ?? UIImage(named: "lunch")
                            case .some(.dinner):
                                self.dinner_Img.image = self.loadImage(url: menu.RecipeImage) ?? UIImage(named: "dinner")
                            case .some(.amSnack):
                                self.am_snack_Img.image = self.loadImage(url: menu.RecipeImage) ?? UIImage(named: "am_snack")
                            case .some(.pmSnack):
                                self.pm_snack_Img.image = self.loadImage(url: menu.RecipeImage) ?? UIImage(named: "pm_snack")
                            }
                        }
                    }
                }
            }
        }
    }
    private func loadImage(url: String?) -> UIImage? {
        guard let urlString = url else {
            print("String is empty or nil")
            return nil
        }
        guard let url = URL(string: urlString) else {
            print("Image URL is empty or nil")
            return nil
        }
        if let cachedImage = cachedImages.object(forKey: url as NSURL) {
            return cachedImage
        }
        guard let data = try? Data(contentsOf: url) else {
            print("Image Data is corrupted or nil")
            return nil
        }
        guard let image = UIImage(data: data) else {
            print("Image is corrupted or nil")
            return nil
        }
        cachedImages.setObject(image, forKey: url as NSURL, cost: data.count)
        return image
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func registerXIBs () {
        selectDateCollection.register(UINib(nibName: "SelectDateCollectionCell", bundle: nil), forCellWithReuseIdentifier: SelectDateCollectionCell.getCellName())
        selectPlanCollection.register(UINib(nibName: "SelectSubscriptionCollectionCell", bundle: nil), forCellWithReuseIdentifier: SelectSubscriptionCollectionCell.getCellName())
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectDateCollection {
            return selectMenu_Arr.count
        }
        if collectionView == selectPlanCollection {
            return selectPlan_Arr.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == selectDateCollection {
            if selectMenu_Arr.count < indexPath.row { return UICollectionViewCell() }
            if indexPath.row == 0 { updateImageArray(date: selectMenu_Arr[indexPath.row].date) }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectDateCollectionCell.getCellName(), for: indexPath) as! SelectDateCollectionCell
            viewFactory.updateLabel(for: cell.date_Lbl, font: .bold, text: selectMenu_Arr[indexPath.row].date, size: 15)
            cell.dateSelected.backgroundColor = selectMenu_Arr[indexPath.row].isSelected ? UIColor(hex: "#FAA21C") : UIColor(hex: "#EAEAEA")
            cell.isSelected = indexPath.row == 0 ? true : false
            cell.isHighlighted = indexPath.row == 0 ? true : false
            return cell
        }
        if collectionView == selectPlanCollection {
            if selectPlan_Arr.count < indexPath.row { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectSubscriptionCollectionCell.getCellName(), for: indexPath) as! SelectSubscriptionCollectionCell
            cell.backView.layer.cornerRadius = 10
            cell.backView.layer.borderWidth = 1.0
            cell.backView.layer.borderColor = UIColor(hex: "#EAEAEA")?.cgColor
            viewFactory.updateLabel(for: cell.title_Lbl, font: .regular, text: selectPlan_Arr[indexPath.row].PlanName ?? "", size: 14)
            viewFactory.updateLabel(for: cell.subTitle_Lbl, font: .regular, text: selectPlan_Arr[indexPath.row].CalRange ?? "", size: 14)
            cell.subscription_Img.layer.cornerRadius = 10.0
            let planText = selectPlan_Arr[indexPath.row].PlanText ?? [PreparePlanText]()
            let text1 = planText.count >= 1 ? (planText[0].Text ?? "") : "Includes Breakfast, Lunch, Dinner & 2 Snacks"
            viewFactory.updateLabel(for: cell.includedPlan1_Lbl, font: .regular, text: text1, size: 10)
            let text2 = planText.count >= 2 ? (planText[1].Text ?? "") : "Serves you recomended calorie range"
            viewFactory.updateLabel(for: cell.includedPlan2_Lbl, font: .regular, text: text2, size: 10)
            let text3 = planText.count >= 3 ? (planText[2].Text ?? "") : "5 Days / 4 Weeks"
            viewFactory.updateLabel(for: cell.includedPlan3_Lbl, font: .regular, text: text3, size: 10)
            let text4 = planText.count >= 4 ? (planText[3].Text ?? "") : "Unlimited Pauses / Changes"
            viewFactory.updateLabel(for: cell.includedPlan4_Lbl, font: .regular, text: text4, size: 10)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == selectDateCollection {
            return CGSize(width: 65, height: 35)
        }
        if collectionView == selectPlanCollection {
            return CGSize(width: 205, height: 420)
        }
        return CGSize()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == selectDateCollection {
            updateImageArray(date: selectMenu_Arr[indexPath.row].date)
            selectItem(index: indexPath.row)
        }
        if collectionView == selectPlanCollection {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    func selectItem(index: Int){
        let item: MenuOption = selectMenu_Arr[index]
        if item.isSelected {
            item.isSelected = false
        } else {
            for eachItem in selectMenu_Arr {
                eachItem.isSelected = false
            }
            item.isSelected = true
        }
        selectDateCollection.reloadData()
    }
}
