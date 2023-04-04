//
//  RegistrationViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 29.03.23.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createNewAccount(_ sender: Any) {
        
        guard let name = nameTF.text,
              let email = emailTF.text,
              let password = passwordTF.text,
              !email.isEmpty,
              !name.isEmpty,
              !password.isEmpty else { return }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let user = user else { return }
                print(user)
                guard let userVC = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else { return }
                self.navigationController?.pushViewController(userVC, animated: true)
            }
            self.navigationController?.dismiss(animated: true)

        }

    }
}

