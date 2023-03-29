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
    
    var ref: DatabaseReference!
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle!

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
        
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let _ = user else {
                return
            }
            self?.navigationController?.pushViewController(UIHostingController(rootView: UserProfile()), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passwordTF.text = ""
    }

//    @IBSegueAction func logInSegue(_ coder: NSCoder) -> UIViewController? {
//        return UIHostingController(coder: coder, rootView: UserProfile())
//    }
//
    @IBAction func logIn(_ sender: Any) {
        guard let email = emailTF.text,
              let password = passwordTF.text,
              email != "",
              password != "" else { return }

        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error {
                print(error.localizedDescription)
            } else if let _ = user {
                print(email)
                print("user exist")
                self.navigationController?.pushViewController(UIHostingController(rootView: UserProfile()), animated: true)
            }
        }
        
    }

    @IBAction func logUp(_ sender: Any) {
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            return
        }

        // createUser
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let user = user else { return }
                let userRef = self?.ref.child(user.user.uid)
                userRef?.setValue(["email": user.user.email])
                self?.navigationController?.pushViewController(UIHostingController(rootView: UserProfile()), animated: true)
            }
        }
    }
}
