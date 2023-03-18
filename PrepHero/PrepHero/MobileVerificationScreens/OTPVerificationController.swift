//
//  OTPVerificationController.swift
//  PrepHero
//
//  Created by Cloy Monis on 15/03/23.
//

import UIKit

class OTPVerificationController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    var heading: UILabel?
    var subHeading: UILabel?
    var leftArrow: UIButton?
    var buttonVerifyOtp: UIButton?
    var mobileNumber: String?
    @IBOutlet weak var otpContainer: UIView!
    let otpStackView = OTPStackView()
    let httpCient = HttpClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
}
extension OTPVerificationController {
    func setUpViews() {
        heading = viewFactory.getHeading(view: view)
        heading?.text = PageHeadings.otp.rawValue
        subHeading = viewFactory.getSubHeading(view: view)
        var subHeadingText = PageSubHeading.otp.rawValue
        if let mobileNumber = mobileNumber {
            subHeadingText = subHeadingText + mobileNumber
        }
        subHeading?.text = subHeadingText
        leftArrow = viewFactory.getLeftArrow(view: view)
        leftArrow?.addTarget(self, action: #selector(actionPrevious), for: .touchUpInside)
        buttonVerifyOtp = viewFactory.getButton(view: view, title: "Verify")
        buttonVerifyOtp?.addTarget(self, action: #selector(verifyOtp), for: .touchUpInside)
        //otpContainer.backgroundColor = .red
        otpContainer.addSubview(otpStackView)
        otpStackView.delegate = self
        otpStackView.viewController = self
        otpStackView.heightAnchor.constraint(equalTo: otpContainer.heightAnchor).isActive = true
        otpStackView.centerXAnchor.constraint(equalTo: otpContainer.centerXAnchor).isActive = true
        otpStackView.centerYAnchor.constraint(equalTo: otpContainer.centerYAnchor).isActive = true
    }
    @objc func actionPrevious(){
        self.dismiss(animated: true)
    }
    @objc func verifyOtp(){
        let otp = otpStackView.getOTP()
        guard otp.count == 4 else {
            return
        }
        if let nextVC = self.viewControllerPresenter.getNextViewController(current: self, nextVC: CreateAccountViewController.self) as? CreateAccountViewController {
            self.present(nextVC, animated: true)
        }
//        httpCient.request(api: .verifyOtp, data: "971544834733/\(otp)") { result in
//            switch result {
//            case .success(let success):
//                DispatchQueue.main.async {
//                    print(success)
//                    if let nextVC = self.viewControllerPresenter.getNextViewController(current: self, nextVC: CreateAccountViewController.self) as? CreateAccountViewController {
//
//                        self.present(nextVC, animated: true)
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    }
}
extension OTPVerificationController: OTPDelegate {
    func didChangeValidity(isValid: Bool) {
        
    }
}
