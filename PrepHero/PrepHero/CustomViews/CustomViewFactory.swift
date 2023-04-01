//
//  ProcessView.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

// ToDo Implement Factory Design Pattern

import UIKit

class CustomViewFactory {
    enum ProcessImageType {
        case filled
        case empty
    }
    func getLeftArrow(view: UIView) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .clear
        //button.setTitle("Skip", for: .normal)
        //button.setTitleColor(.blue, for: .normal)
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.frame = CGRect(x: 5 , y: 50, width: 60 , height: 60)
        view.addSubview(button)
        return button
    }
    func getProcessAndSkip(view: UIView, currentStep: Int,totalSteps: Int) -> (UIStackView, UIButton) {
        let stackView = getProcess(view: view, currentStep: currentStep, totalSteps: totalSteps)
        stackView.frame = CGRect(x: 20, y: 80, width: view.frame.width - 100 , height: 40)
        let skipButton = getSkipButton(view: view)
        return (stackView, skipButton)
    }
    func getProcess(view: UIView, currentStep: Int,totalSteps: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        for i in 0..<totalSteps {
            if i < currentStep {
                stackView.addArrangedSubview(getProcessImage(type: .filled))
            } else {
                stackView.addArrangedSubview(getProcessImage(type: .empty))
            }
        }
        stackView.frame = CGRect(x: 20, y: 80, width: view.frame.width - 50 , height: 40)
        view.addSubview(stackView)
        return stackView
    }
    private func getSkipButton(view: UIView) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.frame = CGRect(x: view.frame.width - 70 , y: 60, width: 40 , height: 40)
        view.addSubview(button)
        return button
    }
    func getLabel(font: CustomFonts, size: CGFloat = 25) -> UILabel {
        let label = UILabel()
        if let poppinsBold = UIFont(name: font.rawValue, size: size) {
            label.font = UIFontMetrics.default.scaledFont(for: poppinsBold)
            label.adjustsFontForContentSizeCategory = true
        }
        return label
    }
    func updateLabel(for label: UILabel, font: CustomFonts, text: String, size: CGFloat) {
        if let poppinsBold = UIFont(name: font.rawValue, size: size) {
            label.font = UIFontMetrics.default.scaledFont(for: poppinsBold)
            label.adjustsFontForContentSizeCategory = true
        }
        label.text = text
    }
    func getHeading(view: UIView) -> UILabel {
        let label = UILabel()
        if let poppinsBold = UIFont(name: CustomFonts.bold.rawValue, size: 25) {
            label.font = UIFontMetrics.default.scaledFont(for: poppinsBold)
            label.adjustsFontForContentSizeCategory = true
        }
        label.frame = CGRect(x: 20, y: 100, width: view.frame.width , height: 100)
        view.addSubview(label)
        return label
    }
    func getSubHeading(view: UIView) -> UILabel {
        let label = UILabel()
        if let font = UIFont(name: CustomFonts.regular.rawValue, size: 17) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
            label.adjustsFontForContentSizeCategory = true
        }
        label.frame = CGRect(x: 20, y: 160, width: view.frame.width - 20 , height: 100)
        label.numberOfLines = 0
        view.addSubview(label)
        return label
    }
    func getButton(view: UIView, title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#E3185E")
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        if let poppinsBold = UIFont(name: CustomFonts.bold.rawValue, size: 20) {
            button.titleLabel?.font = poppinsBold
        }
        button.frame = CGRect(x: view.frame.width * 0.15 , y: view.frame.height - 100, width: view.frame.width * 0.7 , height: 60)
        view.addSubview(button)
        return button
    }
    func getPreviousButton(view: UIView) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#F2F2F2")
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(.black, for: .normal)
        if let poppinsBold = UIFont(name: CustomFonts.bold.rawValue, size: 20) {
            button.titleLabel?.font = poppinsBold
        }
        button.frame = CGRect(x: 30, y: view.frame.height - 120, width: 150 , height: 60)
        view.addSubview(button)
        return button
    }
    func getNextButton(view: UIView) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#E3185E")
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        if let poppinsBold = UIFont(name: CustomFonts.bold.rawValue, size: 20) {
            button.titleLabel?.font = poppinsBold
        }
        button.frame = CGRect(x: view.frame.width - 180, y: view.frame.height - 120, width: 150 , height: 60)
        view.addSubview(button)
        return button
    }
    func customizeActivtyHeading(label: UILabel){
        if let font = UIFont(name: CustomFonts.bold.rawValue, size: 20) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
            label.adjustsFontForContentSizeCategory = true
        }
    }
    func customizeSubActivtyHeading(label: UILabel){
        if let font = UIFont(name: CustomFonts.regular.rawValue, size: 15) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
            label.adjustsFontForContentSizeCategory = true
        }
    }
}
extension CustomViewFactory {
    private func getProcessImage(type: ProcessImageType) -> UIImageView {
        let imageView = UIImageView()
        switch type {
        case .empty:
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
            let image = UIImage(named: "Rectangle_Empty")
            imageView.image = image
        case .filled:
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
            let processImage = UIImage(named: "Rectangle_Fill")
            imageView.image = processImage
        }
        return imageView
    }
}
