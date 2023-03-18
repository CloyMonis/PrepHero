//
//  StartViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit

class StartViewController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var buttonHelpStart: UIButton!
    @IBOutlet weak var buttonUserKnows: UIButton!
    @IBOutlet weak var buttonLogIn: UIButton!
    @IBOutlet weak var leftLine: UIView!
    @IBOutlet weak var rightLine: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    @IBAction func actionHelpStart(_ sender: Any) {
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: MobileVerificationController.self) {
        //if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: CreateAccountViewController.self) {
            self.present(nextVC, animated: true)
        }
    }
    @IBAction func actionUserKnows(_ sender: Any) {
    }
}

extension StartViewController {
    func setUpViews() {
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 30
        viewMain.layer.maskedCorners = [ .layerMaxXMinYCorner , .layerMinXMinYCorner ]
        if let poppinsBold = UIFont(name: CustomFonts.bold.rawValue, size: 25) {
            labelHeading.font = UIFontMetrics.default.scaledFont(for: poppinsBold)
            labelHeading.adjustsFontForContentSizeCategory = true
        }
        if let font = UIFont(name: CustomFonts.bold.rawValue, size: 20) {
            buttonHelpStart.titleLabel?.font = font
        }
        buttonUserKnows.backgroundColor = .white
        buttonUserKnows.layer.borderWidth = 1
        buttonUserKnows.layer.borderColor = UIColor.black.cgColor
        if let font = UIFont(name: CustomFonts.bold.rawValue, size: 20) {
            buttonUserKnows.titleLabel?.font = font
        }
        buttonUserKnows.titleLabel?.textColor = .black
        let firstText = NSMutableAttributedString(string: "Already have an account? ", attributes: [ NSAttributedString.Key.font: UIFont(name: CustomFonts.regular.rawValue, size: 14), NSAttributedString.Key.foregroundColor: UIColor.gray ] )
        let secondText = NSAttributedString(string: "Log In", attributes: [ NSAttributedString.Key.font: UIFont(name: CustomFonts.regular.rawValue, size: 14), NSAttributedString.Key.foregroundColor: UIColor.red ] )
        firstText.append(secondText)
        buttonLogIn.setAttributedTitle(firstText, for: .normal)
        leftLine.backgroundColor = UIColor(cgColor: AppColors.viewBorder!)
        rightLine.backgroundColor = UIColor(cgColor: AppColors.viewBorder!)
        
    }
}
