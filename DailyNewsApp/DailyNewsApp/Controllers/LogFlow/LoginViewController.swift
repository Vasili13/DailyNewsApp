//
//  LoginViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 23.03.23.
//

import FirebaseAuth
import FirebaseDatabase
import SnapKit
import SwiftUI
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                presentAlert(text: error.localizedDescription)
            } else if let user = user {
                guard let userVC = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else { return }
                self.navigationController?.pushViewController(userVC, animated: true)
            }
            
        }
    }

    @IBAction func logUp(_ sender: Any) {
        guard let regVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController else { return }
        navigationController?.pushViewController(regVC, animated: true)
    }
    
    private func presentAlert(text: String) {
        let alert = UIAlertController(title: "Something went wrong :(", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
