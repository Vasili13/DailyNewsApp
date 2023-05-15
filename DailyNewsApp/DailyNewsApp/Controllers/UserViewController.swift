//
//  UserViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 29.03.23.
//

import Firebase
import FirebaseAuth
import FirebaseStorage
import SnapKit
import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    private var user: User!
    private let storageRef = Storage.storage().reference()
    private let dataRef = Database.database().reference(withPath: "users")
    private var ref: DatabaseReference!
    var dataHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserImage()
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString),
              let currentUser = Auth.auth().currentUser else { return }

        user = User(user: currentUser)
        
        ref = Database.database().reference()
        
        dataHandle = dataRef.child(currentUser.uid).observe(.value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            self.nameLabel.text = username
            self.emailLabel.text = email
        })
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.userImage.image = image
            }
        }.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString),
              let currentUser = Auth.auth().currentUser else { return }
        
        dataHandle = dataRef.child(currentUser.uid).observe(.value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            self.nameLabel.text = username
            self.emailLabel.text = email
        })
    }
    
    private func updateUserImage() {
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.layer.borderWidth = 2
        userImage.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @IBAction func addNewUserImage(_ sender: Any) {
        presentPhotoAlert()
    }
    
    @IBAction func logOut(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "Log out of your account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            do {
                try Auth.auth().signOut()
            } catch {
                print(error.localizedDescription)
            }
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default))
        present(alert, animated: true)
    }
    
    
    @IBAction func deleteAccount(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure?", message: "Delete account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            let user = Auth.auth().currentUser
            user?.delete()
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default))
        present(alert, animated: true)
    }
}

//-MARK: ImagePicker

extension UserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func presentPhotoAlert() {
        let alert = UIAlertController(title: "User Image", message: "How would you ike to select a picture", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentImagePicker()
        }))
        
        present(alert, animated: true)
    }
    
    private func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    private func presentImagePicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    //Get image from camera and library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        guard let selectedImage = info[.editedImage] as? UIImage,
              let imageData = selectedImage.pngData(),
              let currentUser = Auth.auth().currentUser else { return }

        storageRef.child(currentUser.uid).child("images/file.png").putData(imageData) { _, error in
            guard error == nil else { return }

            self.storageRef.child(currentUser.uid).child("images/file.png").downloadURL { [weak self] url, error in
                guard let url = url, error == nil, let self = self else { return }

                let urlString = url.absoluteString

                DispatchQueue.main.async {
                    self.userImage.image = selectedImage
                }
                UserDefaults.standard.set(urlString, forKey: "url")
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
