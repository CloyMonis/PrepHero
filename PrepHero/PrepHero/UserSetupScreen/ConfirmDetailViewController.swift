//
//  ConfirmDetailViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit

class ConfirmDetailViewController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    var signUpResult = SignUpResult()
    var stackView: UIStackView?
    var heading: UILabel?
    var previousButton: UIButton?
    var nextButton: UIButton?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var addrNickNameView: LabelWithTextField!
    @IBOutlet weak var flatVillaView: LabelWithTextField!
    @IBOutlet weak var buildingNameView: LabelWithTextField!
    @IBOutlet weak var streetNameView: LabelWithTextField!
    @IBOutlet weak var areaView: LabelWithTextField!
    @IBOutlet weak var cityView: LabelWithTextField!
    @IBOutlet weak var deliveryInstView: LabelWithTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpDelegates()
    }
    func validationsFailed(text: String) {
        print("validationsFailed",text)
    }
    @objc func actionPrevious() {
        self.dismiss(animated: true)
    }
    @objc func actionNext() {
        guard let addressNickname = addrNickNameView.textField, let address = addressNickname.text, address.count > 1 else {
            validationsFailed(text: "addressNickname")
            addrNickNameView.validationsFailed()
            return
        }
        signUpResult.AddrNickname = address
        guard let flatVilla = flatVillaView.textField, let flat = flatVilla.text, flat.count > 1 else {
            validationsFailed(text: "flatVilla")
            flatVillaView.validationsFailed()
            return
        }
        signUpResult.FlatVilla = flat
        guard let buildingName = buildingNameView.textField, let building = buildingName.text, building.count > 1 else {
            validationsFailed(text: "buildingName")
            buildingNameView.validationsFailed()
            return
        }
        signUpResult.Building = building
        guard let streetName = streetNameView.textField, let street = streetName.text, street.count > 1 else {
            validationsFailed(text: "streetName")
            streetNameView.validationsFailed()
            return
        }
        signUpResult.Street = street
        guard let areaTf = areaView.textField, let area = areaTf.text, area.count > 1 else {
            validationsFailed(text: "area")
            areaView.validationsFailed()
            return
        }
        signUpResult.Area = area
        guard let cityTf = cityView.textField, let city = cityTf.text, city.count > 1 else {
            validationsFailed(text: "city")
            cityView.validationsFailed()
            return
        }
        signUpResult.City = city
        if let deliveryInst = deliveryInstView.textField, let delivery = deliveryInst.text {
            signUpResult.DelivInst = delivery
        }
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: PrepareResultViewController.self) as? PrepareResultViewController {
            nextVC.signUpResult = signUpResult
            self.present(nextVC, animated: true)
        }
    }
}

extension ConfirmDetailViewController {
    func setUpViews() {
        stackView = viewFactory.getProcess(view: self.view, currentStep: 9, totalSteps: 9)
        heading = viewFactory.getHeading(view: view)
        heading?.text = PageHeadings.confirmDetails.rawValue
        previousButton = viewFactory.getPreviousButton(view: view)
        nextButton = viewFactory.getNextButton(view: view)
        scrollView.customize()
        scrollContentView.customizeScrollContentView()
        previousButton?.addTarget(self, action: #selector(actionPrevious), for: .touchUpInside)
        nextButton?.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
    }
    func setUpDelegates() {
        addrNickNameView.textField?.delegate = self
        flatVillaView.textField?.delegate = self
        buildingNameView.textField?.delegate = self
        streetNameView.textField?.delegate = self
        areaView.textField?.delegate = self
        cityView.textField?.delegate = self
        deliveryInstView.textField?.delegate = self
    }
}
extension ConfirmDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
