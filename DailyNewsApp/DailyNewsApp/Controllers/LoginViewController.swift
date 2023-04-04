//
//  LoginViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 23.03.23.
//

import UIKit
import SnapKit
import SwiftUI
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    
//    var ref: DatabaseReference!
//    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle!

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ref = Database.database().reference(withPath: "users")
//
//        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
//            guard let _ = user else {
//                return
//            }
//
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passwordTF.text = ""
    }
    
    @IBAction func logIn(_ sender: Any) {
        guard let email = emailTF.text,
              let password = passwordTF.text,
              !email.isEmpty,
              !password.isEmpty else { return }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let self = self else { return }
            if let error {
                print(error.localizedDescription)
            } else if let _ = user {
                print(email)
                print("user exist")
                self.navigationController?.dismiss(animated: true)
            }
            
        }
    }

    @IBAction func logUp(_ sender: Any) {
        guard let regVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController else { return }
        navigationController?.pushViewController(regVC, animated: true)
    }
}
