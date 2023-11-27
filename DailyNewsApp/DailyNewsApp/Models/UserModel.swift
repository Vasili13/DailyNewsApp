//
//  UserModel.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 28.03.23.
//

import Firebase
import Foundation

struct User {
    let uid: String
    let name: String
    var email: String

    init(user: Firebase.User) {
        self.uid = user.uid
        self.name = user.displayName ?? ""
        self.email = user.email ?? ""
    }
}
