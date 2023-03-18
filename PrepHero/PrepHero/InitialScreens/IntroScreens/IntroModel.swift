//
//  IntroModel.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import Foundation
import UIKit

struct IntroModel {
    let heading: String
    let subHeading: String
    let leftImage: UIImage?
    let rightImage: UIImage?
    let leftImageIsSmall: Bool
    let stepCount: Int
}

extension IntroModel {
    init(count: Int){
        self.stepCount = count
        switch count {
        case 1:
            self.heading = "Welcome to PrepHero"
            self.subHeading = "Just relax and don’t overthink what to eat. This is in our side with our personalized meal plans just prepared and adapted to your needs"
            self.leftImage = UIImage(named: "Slider_1_1")
            self.rightImage = UIImage(named: "Slider_1_2")
            self.leftImageIsSmall = false
        case 2:
            self.heading = "Manage your plan with ease"
            self.subHeading = "Take full control of your meal plan, view and make changes to your upcoming menu with the easy of a click."
            self.leftImage = UIImage(named: "Slider_2_1")
            self.rightImage = UIImage(named: "Slider_2_2")
            self.leftImageIsSmall = true
        case 3:
            self.heading = "Manage your deliveries"
            self.subHeading = "View, reschedule, change address or skip your upcoming deliveries. Adjust your meal plan according to your convienence"
            self.leftImage = UIImage(named: "Slider_3_1")
            self.rightImage = UIImage(named: "Slider_3_2")
            self.leftImageIsSmall = true
        case 4:
            self.heading = "Track your healthy lifestlye"
            self.subHeading = "Track your calorie intake, macro intake, calorie deficit and much more. One app to control your healthy lifestyle!"
            self.leftImage = UIImage(named: "Slider_4_1")
            self.rightImage = UIImage(named: "Slider_4_2")
            self.leftImageIsSmall = true
        default:
            self.heading = ""
            self.subHeading = ""
            self.leftImage = nil
            self.rightImage = nil
            self.leftImageIsSmall = false
        }
    }
}
