//
//  IntroViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 15/02/23.
//

import UIKit

class IntroViewController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    @IBOutlet weak private var imageViewLeft: UIImageView!
    @IBOutlet weak private var imageViewRight: UIImageView!
    @IBOutlet weak private var constraintRightSmall: NSLayoutConstraint!
    @IBOutlet weak private var constraintRightLarge: NSLayoutConstraint!
    @IBOutlet weak private var constraintLeftSmall: NSLayoutConstraint!
    @IBOutlet weak private var constraintLeftLarge: NSLayoutConstraint!
    @IBOutlet weak private var labelHeading: UILabel!
    @IBOutlet weak private var labelSubHeading: UILabel!
    @IBOutlet weak var imageProcessOne: UIImageView!
    @IBOutlet weak var imageProcessTwo: UIImageView!
    @IBOutlet weak var imageProcessThree: UIImageView!
    @IBOutlet weak var imageProcessFour: UIImageView!
    var nextButton: UIButton?
    var model: IntroModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
    @objc func actionNext(){
        guard let model = self.model else {
            print("model is empty")
            return
        }
        switch model.stepCount {
        case 1,2,3:
            if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: IntroViewController.self) as? IntroViewController {
                nextVC.model = IntroModel(count: model.stepCount + 1)
                self.present(nextVC, animated: true)
            }
        case 4:
            if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: StartViewController.self) {
                self.present(nextVC, animated: true)
            }
        default:
            print("stepCount is invalid")
        }
    }
}
extension IntroViewController {
    func setUpViews() {
        guard let model = self.model else {
            print("model is empty")
            return
        }
        imageViewLeft.image = model.leftImage
        imageViewRight.image = model.rightImage
        constraintLeftSmall.isActive = model.leftImageIsSmall
        constraintLeftLarge.isActive = !model.leftImageIsSmall
        constraintRightSmall.isActive = !model.leftImageIsSmall
        constraintRightLarge.isActive = model.leftImageIsSmall
        nextButton = viewFactory.getNextButton(view: view)
        nextButton?.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        if let poppinsBold = UIFont(name: CustomFonts.bold.rawValue, size: 25) {
            labelHeading.font = UIFontMetrics.default.scaledFont(for: poppinsBold)
            labelHeading.adjustsFontForContentSizeCategory = true
            labelHeading.text = model.heading
        }
        if let poppinsRegular = UIFont(name: CustomFonts.regular.rawValue, size: UIFont.labelFontSize) {
            labelSubHeading.font = UIFontMetrics.default.scaledFont(for: poppinsRegular)
            labelSubHeading.adjustsFontForContentSizeCategory = true
            labelSubHeading.text = model.subHeading
        }
        switch model.stepCount {
        case 1 :
            imageProcessOne.image = UIImage(named: "Process")
        case 2 :
            imageProcessTwo.image = UIImage(named: "Process")
        case 3 :
            imageProcessThree.image = UIImage(named: "Process")
        case 4 :
            imageProcessFour.image = UIImage(named: "Process")
        default:
            print("no image")
        }
    }
}
