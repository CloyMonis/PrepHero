//
//  SelectDietViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit

class DietCell: UICollectionViewCell {
    @IBOutlet weak var labelDiet: UILabel!
}

class SelectDietViewController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    var stackView: UIStackView?
    var heading: UILabel?
    var subHeading: UILabel?
    var previousButton: UIButton?
    var nextButton: UIButton?
    var skipButton: UIButton?
    var signUpOptions: SignUpOptions?
    var signUpResult = SignUpResult()
    @IBOutlet weak var collectionView: UICollectionView!
    private let reuseIdentifier = "DietCell"
    var items = [PrepItem]()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        if let signUpOptions = signUpOptions {
            let goalOptions: [PrepItem] = signUpOptions.options.diets.compactMap{ PrepItem(itemName: $0.option) }
            items.append(contentsOf: goalOptions)
            print("items:\(items)")
        }
        if items.count > 0 {
            items[0].isSelected = true
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    @objc func actionNext() {
        let result = items.filter{ $0.isSelected }
        let diet = result.map{ $0.itemName }
        if diet.count == 0 {
            createAnAlert(message: "Please select a value before proceeding.")
        }
        signUpResult.Diets = diet.joined(separator: ",")
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: SelectActivityLevelViewController.self) as? SelectActivityLevelViewController {
            nextVC.signUpResult = signUpResult
            self.present(nextVC, animated: true)
        }
    }
    @objc func actionPrevious() {
        self.dismiss(animated: true)
    }
}

extension SelectDietViewController {
    func setUpViews() {
        let stackAndSkip = viewFactory.getProcessAndSkip(view: view, currentStep: 6, totalSteps: 9)
        stackView = stackAndSkip.0
        skipButton = stackAndSkip.1
        heading = viewFactory.getHeading(view: view)
        heading?.text = PageHeadings.diet.rawValue
        subHeading = viewFactory.getSubHeading(view: view)
        subHeading?.text = PageSubHeading.diet.rawValue
        previousButton = viewFactory.getPreviousButton(view: view)
        nextButton = viewFactory.getNextButton(view: view)
        previousButton?.addTarget(self, action: #selector(actionPrevious), for: .touchUpInside)
        nextButton?.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
    }
}
extension SelectDietViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? DietCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.row]
        cell.labelDiet.text = item.itemName
        if let font = UIFont(name: CustomFonts.regular.rawValue, size: 17) {
            cell.labelDiet.font = UIFontMetrics.default.scaledFont(for: font)
            cell.labelDiet.adjustsFontForContentSizeCategory = true
        }
        cell.layer.borderWidth = 1
        cell.layer.borderColor =  AppColors.viewBorder
        cell.layer.cornerRadius = 10
        if item.isSelected {
            cell.backgroundColor = AppColors.appThemeColor
            cell.labelDiet.textColor = .white
            cell.layer.borderColor = UIColor.clear.cgColor
        } else {
            cell.backgroundColor = .white
            cell.labelDiet.textColor = .black
            cell.layer.borderColor =  AppColors.viewBorder
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.row]
        let text = item.itemName as NSString
        let font = UIFont(name: CustomFonts.regular.rawValue, size: 17) ?? UIFont.systemFont(ofSize: 17)
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font : font])
        let collectionSize = collectionView.bounds.width - 20
        let maxWidth = (collectionSize / 3).rounded()
        let width = textSize.width.rounded() > maxWidth ? textSize.width.rounded() + 10 : maxWidth
        return CGSize(width: width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("selected Index Position : \(indexPath.row)")
        let item = items[indexPath.row]
        if indexPath.row == 0 && item.isSelected == false {
            items.forEach{ $0.isSelected = false }
            items[0].isSelected = true
        } else if item.isSelected == true {
            item.isSelected = false
            // if any item selected is false then select the first item
            var atLeastOneItemSelected = false
            for each in items {
                if each.isSelected == true {
                    atLeastOneItemSelected = true
                    break
                }
            }
            if atLeastOneItemSelected == false {
                items[0].isSelected = true
            }
            //..
        } else {
            item.isSelected = true
            items[0].isSelected = false
        }
        collectionView.reloadData()
    }
}
