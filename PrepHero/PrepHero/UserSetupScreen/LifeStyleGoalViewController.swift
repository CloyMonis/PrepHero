//
//  LifeStyleGoalViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit

class LifeStyleOption {
    let itemName: String
    var isSelected: Bool = false
    init(itemName: String) {
        self.itemName = itemName
    }
}

class LifeStyleGoalViewController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    var stackView: UIStackView?
    var heading: UILabel?
    var subHeading: UILabel?
    var previousButton: UIButton?
    var nextButton: UIButton?
    var skipButton: UIButton?
    var signUpOptions: SignUpOptions?
    var items = [LifeStyleOption]()
    @IBOutlet weak var tableView: UITableView!
    var prepUserInfo: PrepUserInfo?
    var selectedIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        //print(prepUserInfo)
        setUpViews()
        if let signUpOptions = signUpOptions {
            let goalOptions: [LifeStyleOption] = signUpOptions.options.goals.compactMap{ LifeStyleOption(itemName: $0.option) }
            items.append(contentsOf: goalOptions)
            print("items:\(items)")
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
    @objc func actionNext(){
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: SetWeightViewController.self) as? SetWeightViewController {
            nextVC.signUpOptions = signUpOptions
            self.present(nextVC, animated: true)
        }
    }
    @objc func actionPrevious(){
        self.dismiss(animated: true)
    }
}

extension LifeStyleGoalViewController {
    func setUpViews() {
        let stackAndSkip = viewFactory.getProcessAndSkip(view: view, currentStep: 2, totalSteps: 9)
        stackView = stackAndSkip.0
        skipButton = stackAndSkip.1
        heading = viewFactory.getHeading(view: view)
        heading?.text = PageHeadings.lifeStyleGoal.rawValue
        subHeading = viewFactory.getSubHeading(view: view)
        subHeading?.text = PageSubHeading.lifeStyleGoal.rawValue
        previousButton = viewFactory.getPreviousButton(view: view)
        nextButton = viewFactory.getNextButton(view: view)
        previousButton?.addTarget(self, action: #selector(actionPrevious), for: .touchUpInside)
        nextButton?.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
    }
}

extension LifeStyleGoalViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LifeStyleCell", for: indexPath) as? LifeStyleCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.label.text = item.itemName
        cell.button.setTitle("", for: .normal)
        cell.containerView.backgroundColor = .clear
        cell.containerView.layer.borderWidth = 1
        cell.containerView.layer.borderColor =  AppColors.viewBorder
        cell.containerView.layer.cornerRadius = 10
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(actionCheckBoxClicked(_:)), for: .touchUpInside)
        if item.isSelected {
            cell.button.setImage(UIImage(named: "CheckBox_Filled"), for: .normal)
            cell.containerView.layer.borderColor =  AppColors.viewActivity?.cgColor
        } else {
            cell.button.setImage(UIImage(named: "CheckBox_Empty"), for: .normal)
            cell.containerView.layer.borderColor =  AppColors.viewBorder
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    @objc func actionCheckBoxClicked(_ sender: UIButton){
        selectItem(index: sender.tag)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectItem(index: indexPath.row)
    }
    func selectItem(index: Int){
        var item: LifeStyleOption = items[index]
        if item.isSelected {
            item.isSelected = false
        } else {
            for eachItem in items {
                eachItem.isSelected = false
            }
            item.isSelected = true
        }
        self.tableView.reloadData()
    }
}
