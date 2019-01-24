//
//  ViewController.swift
//  KataLogInLogOut
//
//  Created by Pablo A on 24/01/2019.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!

    private var loggedIn = false {
        didSet {
            loginTextField.isHidden = loggedIn
            passwordTextField.isHidden = loggedIn

            if loggedIn {
                logInButton.setTitle("Log Out", for: UIControl.State.normal)
            } else {
                logInButton.setTitle("Log In", for: UIControl.State.normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didEndEditing(_ sender: Any) {
    }

    @IBAction func didTapOnLogIn(_ sender: Any) {
        loggedIn ? logOut() : logIn()
    }

    private func logIn() {
        if loginTextField.text != "admin" {
            fatalError("error!")
        }

        if passwordTextField.text != "admin" {
            fatalError("error!")
        }

        loggedIn = true

        view.resignFirstResponder()
    }

    private func logOut() {
        loggedIn = !(Int(Date.timeIntervalSinceReferenceDate) % 2 == 0)
    }

    
}

