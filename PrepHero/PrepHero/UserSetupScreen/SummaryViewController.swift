//
//  SummaryViewController.swift
//  PrepHero
//
//  Created by Admin_Vserv on 20/05/23.
//

import UIKit

class SummaryViewController: UIViewController {
    private let viewFactory = CustomViewFactory()
    private var numberOfDays = ["5 DAYS","6 DAYS","7 DAYS"]
    private var numberOfWeeks = ["2 WEEKS","4 WEEKS","8 WEEKS"]
    
    @IBOutlet weak var summary_Lbl: UIView!
    @IBOutlet weak var clientName_Lbl: UILabel!
    @IBOutlet weak var clientProgram_Lbl: UILabel!
    @IBOutlet weak var selectDate_V: UIView!
    @IBOutlet weak var selectDate_Tf: UITextField!
    @IBOutlet weak var days_SV: UIStackView!
    @IBOutlet weak var weeks_SV: UIStackView!
    @IBOutlet weak var height_V: UIView!
    @IBOutlet weak var height_Lbl: UILabel!
    @IBOutlet weak var weight_V: UIView!
    @IBOutlet weak var weight_Lbl: UILabel!
    @IBOutlet weak var age_V: UIView!
    @IBOutlet weak var age_Lbl: UILabel!
    @IBOutlet weak var calories_V: UIView!
    @IBOutlet weak var calories_Lbl: UILabel!
    @IBOutlet weak var bmr_V: UIView!
    @IBOutlet weak var bmr_Lbl: UILabel!
    @IBOutlet weak var calorieDeficit_V: UIView!
    @IBOutlet weak var calorieDeficit_Lbl: UILabel!
    @IBOutlet weak var calorieDeficitDesc_Lbl: UILabel!
    @IBOutlet weak var mealPlan_Lbl: UILabel!
    @IBOutlet weak var duration_Lbl: UILabel!
    @IBOutlet weak var meals_Lbl: UILabel!
    @IBOutlet weak var mealCalorie_Lbl: UILabel!
    @IBOutlet weak var price_Lbl: UILabel!
    
    @IBAction func previous_Btn_Clicked(_ sender: UIButton) {
        
    }
    
    @IBAction func next_Btn_Clicked(_ sender: UIButton) {
        
    }
    
    @objc func days_Btn_Clicked(_ sender: UIButton) {
        updateDaysColor(for: sender.tag)
    }
    
    @objc func weeks_Btn_Clicked(_ sender: UIButton) {
        updateWeeksColor(for: sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBorder()
        updateHeaders()
        updateDaysStack()
        updateWeeksStack()
        
    }

}

extension SummaryViewController {
    func updateBorder() {
        selectDate_V.layer.cornerRadius = 5
        selectDate_V.layer.borderWidth = 1.0
        selectDate_V.layer.borderColor = UIColor(hex: "#DADADA")?.cgColor
        
        height_V.layer.cornerRadius = 5
        height_V.layer.borderWidth = 1.0
        height_V.layer.borderColor = UIColor(hex: "#DADADA")?.cgColor
        
        weight_V.layer.cornerRadius = 5
        weight_V.layer.borderWidth = 1.0
        weight_V.layer.borderColor = UIColor(hex: "#DADADA")?.cgColor
        
        age_V.layer.cornerRadius = 5
        age_V.layer.borderWidth = 1.0
        age_V.layer.borderColor = UIColor(hex: "#DADADA")?.cgColor
        
        calories_V.layer.cornerRadius = 5
        calories_V.layer.borderWidth = 1.0
        calories_V.layer.borderColor = UIColor(hex: "#DADADA")?.cgColor
        
        bmr_V.layer.cornerRadius = 5
        bmr_V.layer.borderWidth = 1.0
        bmr_V.layer.borderColor = UIColor(hex: "#DADADA")?.cgColor
        
        calorieDeficit_V.layer.cornerRadius = 5
        calorieDeficit_V.layer.borderWidth = 1.0
        calorieDeficit_V.layer.borderColor = UIColor(hex: "#DADADA")?.cgColor
    }
    func updateHeaders() {
        let summary = viewFactory.getLabel(font: .bold)
        summary.text = "SUMMARY"
        summary.frame = CGRect(x: 26, y: 0, width: summary_Lbl.bounds.width, height: summary_Lbl.bounds.height)
        summary_Lbl.addSubview(summary)
    }
    func createInteractiveLabel(with text: String, tag: Int, weeks: Int = 0) -> UIView {
        // Create labelView & update it border
        let labelView = UIView()
        labelView.tag = tag
        labelView.layer.cornerRadius = 5
        labelView.layer.borderWidth = 1.0
        labelView.layer.borderColor = UIColor(hex: "#DADADA")?.cgColor
        // Create a Label & update its value.
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = text
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        labelView.addSubview(label)
        setAnchors(to: label, from: labelView)
        // Create a Button & update its tag & addTarget to it.
        let button = UIButton()
        button.backgroundColor = .clear
        button.tag = tag
        if weeks == 1 {
            button.addTarget(self, action: #selector(weeks_Btn_Clicked(_:)), for: .touchUpInside)
        } else {
            button.addTarget(self, action: #selector(days_Btn_Clicked(_:)), for: .touchUpInside)
        }
        labelView.addSubview(button)
        setAnchors(to: button, from: labelView)
        // Bring button to front.
        labelView.bringSubviewToFront(button)
        // Update background color of the view.
        labelView.backgroundColor = UIColor.white
        // Add widthAnchor to the view
        labelView.widthAnchor.constraint(equalToConstant: 62).isActive = true
        return labelView
    }
    func setAnchors(to view: UIView, from container: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1).isActive = true
        view.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1).isActive = true
    }
}

extension SummaryViewController {
    func updateDaysStack() {
        var labelTag = 100
        for day in numberOfDays {
            let label = createInteractiveLabel(with: day, tag: labelTag)
            days_SV.addArrangedSubview(label)
            label.layoutIfNeeded()
            labelTag += 1
        }
        if days_SV.arrangedSubviews.count > 1 {
            days_SV.arrangedSubviews[0].backgroundColor = UIColor(hex: "#FAA21C")
            if let label = days_SV.arrangedSubviews[0].viewWithTag(0) as? UILabel {
                label.textColor = .white
            }
        }
    }
    func updateDaysColor(for tag: Int) {
        if days_SV.arrangedSubviews.count > 0 {
            for dayView in days_SV.arrangedSubviews {
                if dayView.tag == tag {
                    dayView.backgroundColor = UIColor(hex: "#FAA21C")
                    if let label = dayView.viewWithTag(0) as? UILabel {
                        label.textColor = .white
                    }
                } else {
                    dayView.backgroundColor = UIColor.white
                    if let label = dayView.viewWithTag(0) as? UILabel {
                        label.textColor = .black
                    }
                }
            }
        }
    }
}

extension SummaryViewController {
    func updateWeeksStack() {
        var labelTag = 200
        for week in numberOfWeeks {
            let label = createInteractiveLabel(with: week, tag: labelTag, weeks: 1)
            weeks_SV.addArrangedSubview(label)
            label.layoutIfNeeded()
            labelTag += 1
        }
        if weeks_SV.arrangedSubviews.count > 1 {
            weeks_SV.arrangedSubviews[0].backgroundColor = UIColor(hex: "#FAA21C")
            if let label = weeks_SV.arrangedSubviews[0].viewWithTag(0) as? UILabel {
                label.textColor = .white
            }
        }
    }
    func updateWeeksColor(for tag: Int) {
        if weeks_SV.arrangedSubviews.count > 0 {
            for weekView in weeks_SV.arrangedSubviews {
                if weekView.tag == tag {
                    weekView.backgroundColor = UIColor(hex: "#FAA21C")
                    if let label = weekView.viewWithTag(0) as? UILabel {
                        label.textColor = .white
                    }
                } else {
                    weekView.backgroundColor = UIColor.white
                    if let label = weekView.viewWithTag(0) as? UILabel {
                        label.textColor = .black
                    }
                }
            }
        }
    }
}
