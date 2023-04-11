//
//  SetWeightViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit

class SetWeightViewController: UIViewController {
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
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelWeight: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
    @objc func actionNext() {
        signUpResult.Weight = Int(slider.value)
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: SetHeightViewController.self) as? SetHeightViewController {
            nextVC.signUpOptions = signUpOptions
            nextVC.signUpResult = signUpResult
            self.present(nextVC, animated: true)
        }
    }
    @objc func actionPrevious() {
        self.dismiss(animated: true)
    }
    @IBAction func sliderChanged(_ sender: Any) {
        labelWeight.text = String(Int(slider.value)) + " Kg"
    }
}

extension SetWeightViewController {
    func setUpViews() {
        let stackAndSkip = viewFactory.getProcessAndSkip(view: view, currentStep: 3, totalSteps: 9)
        stackView = stackAndSkip.0
        skipButton = stackAndSkip.1
        heading = viewFactory.getHeading(view: view)
        heading?.text = PageHeadings.weight.rawValue
        subHeading = viewFactory.getSubHeading(view: view)
        subHeading?.text = PageSubHeading.weight.rawValue
        previousButton = viewFactory.getPreviousButton(view: view)
        nextButton = viewFactory.getNextButton(view: view)
        previousButton?.addTarget(self, action: #selector(actionPrevious), for: .touchUpInside)
        nextButton?.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        if let font = UIFont(name: CustomFonts.bold.rawValue, size: 25) {
            labelWeight.font = UIFontMetrics.default.scaledFont(for: font)
            labelWeight.adjustsFontForContentSizeCategory = true
        }
        labelWeight.text = String(Int(slider.value)) + " Kg"
        slider.setThumbImage(UIImage(named: "SilderThumb"), for: .normal)
        slider.setThumbImage(UIImage(named: "SilderThumb"), for: .focused)
        slider.setThumbImage(UIImage(named: "SilderThumb"), for: .highlighted)
        slider.setThumbImage(UIImage(named: "SilderThumb"), for: .application)
        slider.setThumbImage(UIImage(named: "SilderThumb"), for: .disabled)
        slider.setThumbImage(UIImage(named: "SilderThumb"), for: .reserved)
        slider.setThumbImage(UIImage(named: "SilderThumb"), for: .selected)
    }
}
