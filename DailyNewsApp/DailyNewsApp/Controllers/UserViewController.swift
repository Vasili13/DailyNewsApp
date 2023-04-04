//
//  UserViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 29.03.23.
//

import UIKit
import SnapKit
import FirebaseAuth

class UserViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserImage()
        
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
        let user = Auth.auth().currentUser
        
        user?.delete()
        navigationController?.popToRootViewController(animated: true)
    }
}
extension UserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func presentPhotoAlert() {
        let alert = UIAlertController(title: "User Image", message: "How would you ike to select a picture", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        alert.addAction(UIAlertAction(title: "Chose Photo", style: .default, handler: { [weak self] _ in
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)

        guard let selectedImage = info[.editedImage] as? UIImage else { return }

        self.userImage.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

