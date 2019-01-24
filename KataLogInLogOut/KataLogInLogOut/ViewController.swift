//
//  ViewController.swift
//  KataLogInLogOut
//
//  Created by Pablo A on 24/01/2019.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class LoginTimeProvider: TimeProvider {
    var seconds: Int {
        return Int(Date.timeIntervalBetween1970AndReferenceDate)
    }
}

protocol ViewControllerActions {
    func didTapOnLogIn(user: String?, pass: String?)
    func didTapOnLogOut()
}

class ViewController: UIViewController, LoginView {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!

    var presenter: ViewControllerPresenter!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        presenter = ViewControllerPresenter(view: self, timeProvider: LoginTimeProvider())
    }

    private var loggedIn = false {
        didSet {
            loginTextField.isHidden = loggedIn
            passwordTextField.isHidden = loggedIn

            if loggedIn {
                logInButton.setTitle("Log Out", for: UIControl.State.normal)
            } else {
                logInButton.setTitle("Log In", for: UIControl.State.normal)
            }
            view.resignFirstResponder()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didEndEditing(_ sender: Any) {
    }

    @IBAction func didTapOnLogIn(_ sender: Any) {
        if loggedIn {
            presenter.didTapOnLogOut()
        } else {
            presenter.didTapOnLogIn(user: loginTextField.text, pass: passwordTextField.text)
        }
    }

    func showLogIn() {
        loggedIn = false
    }

    func showLogOut() {
        loggedIn = true
    }
}

