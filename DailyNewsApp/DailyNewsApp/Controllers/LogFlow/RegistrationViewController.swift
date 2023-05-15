//
//  RegistrationViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 29.03.23.
//

import Firebase
import FirebaseAuth
import FirebaseStorage
import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
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
                presentAlert(text: error.localizedDescription)
            } else {
                guard let user = user else { return }
                let ref = Database.database().reference().child("users")
                ref.child(user.user.uid).updateChildValues(["name": name, "email": email])

                guard let userVC = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else { return }
                self.navigationController?.pushViewController(userVC, animated: true)
            }
            self.navigationController?.dismiss(animated: true)
        }
    }
    
    private func presentAlert(text: String) {
        let alert = UIAlertController(title: "Somthing went wrong :(", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
