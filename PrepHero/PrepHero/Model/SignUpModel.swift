//
//  SignUpModel.swift
//  PrepHero
//
//  Created by Admin_Vserv on 08/04/23.
//

import Foundation

struct SignUpOptions: Codable {
    let options: Options
    enum CodingKeys: String, CodingKey {
        case options = "Options"
    }
}

struct Options: Codable {
    let goals: [OptionList]
    let diets: [OptionList]
    let allergens: [OptionList]
    enum CodingKeys: String, CodingKey {
        case goals = "Goals"
        case diets = "Diets"
        case allergens = "Allergens"
    }
}

struct OptionList: Codable {
    let id: Int
    let option: String
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case option = "Option"
    }
}

struct SignUpResult: Codable {
    var FirstName: String?
    var LastName: String?
    var Phone: String?
    var Email: String?
    var Gender: String?
    var DOB: String?
    var Height: Int?
    var Weight: Int?
    var LifeStyle: String?
    var Allergies: String?
    var Diets: String?
    var GoalID: Int?
    var Lat: String?
    var Lng: String?
    var AddrNickname: String?
    var FlatVilla: String?
    var Building: String?
    var Street: String?
    var Area: String?
    var City: String?
    var DelivInst: String?
}

struct PrepareResult: Codable {
    var Result: PrepareResultData?
}

struct PrepareResultData: Codable {
    var ClientID: Int?
    var PlanID: Int?
    var Plan: String?
    var Macros: PrepareMacros?
    var SampleMenu: [PrepareSampleMenu]?
    var PlanList: [PreparePlanList]?
}

struct PrepareMacros: Codable {
    var Calories: Double?
    var Carbs: Double?
    var Fat: Double?
    var Protein: Double?
}

struct PrepareSampleMenu: Codable {
    var MenuId: Int?
    var MealOrder: Int?
    var MealDate: String?
    var MealName: String?
    var MenuName: String?
    var Kcal: Double?
    var Fat: Double?
    var Carbs: Double?
    var Protein: Double?
    var RecipeImage: String?
}

struct PreparePlanList: Codable {
    var PlanID: Int?
    var PlanSubID: Int?
    var PlanName: String?
    var CalRange: String?
    var Image: String?
    var PlanText: [PreparePlanText]?
}

struct PreparePlanText: Codable {
    var Text: String?
}

enum PrepareMeal: String {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case amSnack = "Morning Snack"
    case pmSnack = "Afternoon Snack"
}
