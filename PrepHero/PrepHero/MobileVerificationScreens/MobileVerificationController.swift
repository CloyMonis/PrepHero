//
//  MobileVerificationController.swift
//  PrepHero
//
//  Created by Cloy Monis on 15/03/23.
//

import UIKit

class MobileVerificationController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    var heading: UILabel?
    var subHeading: UILabel?
    var leftArrow: UIButton?
    var buttonSendOtp: UIButton?
    @IBOutlet weak var textFieldContainer: UIView!
    @IBOutlet weak var labelMobileNumber: UILabel!
    @IBOutlet weak var textFieldMobile: UITextField!
    let httpCient = HttpClient()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
}
extension MobileVerificationController {
    func setUpViews() {
        heading = viewFactory.getHeading(view: view)
        heading?.text = PageHeadings.welcome.rawValue
        subHeading = viewFactory.getSubHeading(view: view)
        subHeading?.text = PageSubHeading.welcome.rawValue
        leftArrow = viewFactory.getLeftArrow(view: view)
        leftArrow?.addTarget(self, action: #selector(actionPrevious), for: .touchUpInside)
        textFieldContainer.layer.borderWidth = 1
        textFieldContainer.layer.borderColor =  AppColors.viewBorder
        textFieldContainer.layer.cornerRadius = 10
        textFieldContainer.backgroundColor = .clear
        textFieldMobile?.borderStyle = .none
        textFieldMobile.keyboardType = .phonePad
        textFieldMobile.delegate = self
        if let font = UIFont(name: CustomFonts.bold.rawValue, size: 17) {
            labelMobileNumber.font = UIFontMetrics.default.scaledFont(for: font)
            labelMobileNumber.adjustsFontForContentSizeCategory = true
        }
        labelMobileNumber.text = "+971 "
        buttonSendOtp = viewFactory.getButton(view: view, title: "Send OTP")
        buttonSendOtp?.addTarget(self, action: #selector(sendOtp), for: .touchUpInside)
        textFieldMobile?.addTarget(self, action: #selector(textDidChanged), for: .allEditingEvents)
    }
    @objc func actionPrevious(){
        self.dismiss(animated: true)
    }
    @objc func sendOtp(){
        //guard let text = textFieldMobile.text, text.count == 10 else {
        //    textFieldContainer.layer.borderColor = UIColor.red.cgColor
        //    return
        //}
        if let nextVC = self.viewControllerPresenter.getNextViewController(current: self, nextVC: OTPVerificationController.self) as? OTPVerificationController {
            //if let code = self.labelMobileNumber.text {
            //    //nextVC.mobileNumber = code + text
            //} else {
            //    //nextVC.mobileNumber = text
            //}
            self.present(nextVC, animated: true)
        }
//        httpCient.request(api: .sendOtp, data: "971544834733") { result in
//            switch result {
//            case .success(let success):
//                DispatchQueue.main.async {
//                    print(success)
//                    if let nextVC = self.viewControllerPresenter.getNextViewController(current: self, nextVC: OTPVerificationController.self) as? OTPVerificationController {
//                        if let code = self.labelMobileNumber.text {
//                            nextVC.mobileNumber = code + text
//                        } else {
//                            nextVC.mobileNumber = text
//                        }
//                        self.present(nextVC, animated: true)
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    }
    @objc func textDidChanged(){
        guard let textField = textFieldMobile, let text = textField.text else {
            return
        }
        if text.count > 0 {
            textFieldContainer.layer.borderColor =  AppColors.viewBorder
        }
    }
}
extension MobileVerificationController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
