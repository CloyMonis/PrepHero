//
//  UserSetupHeaders.swift
//  PrepHero
//
//  Created by Cloy Vserv on 18/02/23.
//

import Foundation

enum PageHeadings: String {
    case welcome = "Welcome"
    case otp = "OTP Code Verification"
    case createAccount = "Create New Account"
    case confirmDetails = "Confirm Your Details"
    case lifeStyleGoal = "What is your lifestyle goal ?"
    case weight = "What is your current weight ?"
    case height = "What is your current height ?"
    case ingredient = "Any ingredient allergen?"
    case diet = "Do you follow any of these diets?"
    case activityLevel = "What is your activity level?"
    case location = "Where would you like to recieve your meal plan?"
}

enum PageSubHeading: String {
    case otp = "Code has been send to "
    case welcome = "Please enter your mobile number to get started"
    case lifeStyleGoal = "You can choose more than one. Don’t worry, you can always change it later"
    case weight = "For accurate results use your most recent weight"
    case height = "For accurate results use your most recent height"
    case ingredient = "To offer you the best tailored diet experience we need to know more information about you"
    case diet = "To offer you the best tailored diet experience we need to know more information about your diet"
    case activityLevel = "This will help our nutrition AI choose the best meal plan for you"
}

