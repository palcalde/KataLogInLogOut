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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didEndEditing(_ sender: Any) {
        switch sender {
        case loginTextField as UITextField:
            if loginTextField.text != "admin" {
                fatalError("error!")
            }

        case passwordTextField as UITextField:
            if passwordTextField.text != "admin" {
                fatalError("error!")
            }
        default:
            fatalError("unknown sender")
        }
    }

    @IBAction func didTapOnLogIn(_ sender: Any) {
        view.resignFirstResponder()
    }

    
}

