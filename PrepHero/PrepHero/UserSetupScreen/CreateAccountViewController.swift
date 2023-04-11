//
//  CreateAccountViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    let genders = ["Male", "Female", "Other"]
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    let httpCient = HttpClient()
    var signUpOptions: SignUpOptions?
    var signUpResult = SignUpResult()
    var stackView: UIStackView?
    var heading: UILabel?
    var previousButton: UIButton?
    var nextButton: UIButton?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var firstNameView: LabelWithTextField!
    @IBOutlet weak var lastNameView: LabelWithTextField!
    @IBOutlet weak var emailView: LabelWithTextField!
    @IBOutlet weak var dobView: ButtonWithImage!
    @IBOutlet weak var genderView: ButtonWithImage!
    let tagDOB = 111
    let tagGender = 112
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpDelegates()
        httpCient.request(api: .signUpOptions) { result in
            switch result {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let obj):
                let decoder = JSONDecoder()
                if let response = try? decoder.decode(SignUpOptions.self, from: obj) {
                    self.signUpOptions = response
                }
            }
        }
    }
    @objc func actionNext() {
        guard let firstNameTextField = firstNameView.textField, let firstName = firstNameTextField.text, firstName.count > 1 else {
            validationsFailed(text: "firstName")
            firstNameView.validationsFailed()
            return
        }
        signUpResult.FirstName = firstName
        guard let lastNameTextField = lastNameView.textField, let lastName = lastNameTextField.text, lastName.count > 1 else {
            validationsFailed(text: "lastName")
            lastNameView.validationsFailed()
            return
        }
        signUpResult.LastName = lastName
        guard let emailTextField = emailView.textField, let email = emailTextField.text, email.count > 1 else {
            validationsFailed(text: "email")
            emailView.validationsFailed()
            return
        }
        signUpResult.Email = email
        guard dobView.buttonText.count > 1 else {
            validationsFailed(text: "date of Birth")
            dobView.validationsFailed()
            return
        }
        signUpResult.DOB = dobView.buttonText
        guard genderView.buttonText.count > 1 else {
            validationsFailed(text: "gender")
            genderView.validationsFailed()
            return
        }
        signUpResult.Gender = genderView.buttonText
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: LifeStyleGoalViewController.self) as? LifeStyleGoalViewController {
            nextVC.signUpOptions = signUpOptions
            nextVC.signUpResult = signUpResult
            self.present(nextVC, animated: true)
        }
    }
    @objc func actionPrevious() {
        // Show SingUp Page
        // self.dismiss(animated: true)
    }
    func validationsFailed(text: String) {
        print("validationsFailed",text)
    }
}
extension CreateAccountViewController {
    func setUpViews() {
        stackView = viewFactory.getProcess(view: self.view, currentStep: 1, totalSteps: 9)
        heading = viewFactory.getHeading(view: view)
        heading?.text = PageHeadings.createAccount.rawValue
        previousButton = viewFactory.getPreviousButton(view: view)
        nextButton = viewFactory.getNextButton(view: view)
        scrollView.customize()
        scrollContentView.customizeScrollContentView()
        previousButton?.addTarget(self, action: #selector(actionPrevious), for: .touchUpInside)
        nextButton?.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
    }
    func setUpDelegates(){
        firstNameView.textField?.delegate = self
        firstNameView.textField?.keyboardType = .namePhonePad
        lastNameView.textField?.delegate = self
        lastNameView.textField?.keyboardType = .namePhonePad
        emailView.textField?.delegate = self
        emailView.textField?.keyboardType = .emailAddress
        dobView.delegate = self
        dobView.tag = tagDOB
        genderView.delegate = self
        genderView.tag = tagGender
    }
}
extension CreateAccountViewController: ButtonWithImageDelegate {
    func buttonClicked(tag: Int) {
        switch tag {
        case tagDOB:
            RPicker.selectDate { [weak self] (selectedDate) in
                let date = selectedDate.dateString("dd-MMM-YYYY")
                print("\(date)")
                self?.dobView.buttonText = date
            }
        case tagGender:
            RPicker.selectOption(dataArray: genders) {[weak self] (selctedText, atIndex) in
                let selection = selctedText + " selcted at \(atIndex)"
                print("\(selection)")
                self?.genderView.buttonText = selctedText
            }
        default:
            print("")
        }
    }
}
extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
