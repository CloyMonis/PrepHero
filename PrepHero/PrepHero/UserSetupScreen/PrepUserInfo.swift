//
//  UserInfo.swift
//  PrepHero
//
//  Created by Cloy Monis on 13/03/23.
//

import Foundation

struct PrepUserInfo {
    var firstName: String?
    var lastName: String?
    var email: String?
    var dob: String?
    var gender: String?
}

extension PrepUserInfo: CustomStringConvertible {
    var description: String {
        return "firstName:\(firstName) firstName\(lastName) email\(email) dob\(dob) gender\(gender)"
    }
}
