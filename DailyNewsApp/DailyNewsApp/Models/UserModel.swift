//
//  UserModel.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 28.03.23.
//

import Foundation
import Firebase

 struct User {
     let uid: String
     var email: String

     init(user: Firebase.User) {
         self.uid = user.uid
         self.email = user.email ?? ""
     }
 }
