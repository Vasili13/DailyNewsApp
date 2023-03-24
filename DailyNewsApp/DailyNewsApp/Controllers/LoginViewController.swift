//
//  LoginViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 23.03.23.
//

import UIKit
import SnapKit
import SwiftUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBSegueAction func logInSegue(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: UserProfile())
    }
    
}
