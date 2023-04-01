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
    var stackView: UIStackView?
    var heading: UILabel?
    var previousButton: UIButton?
    var nextButton: UIButton?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
    @objc func actionNext() {
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: ResultViewController.self) {
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
        nextButton?.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
    }
}
