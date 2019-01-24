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
    }

    @IBAction func didTapOnLogIn(_ sender: Any) {
        if loginTextField.text != "admin" {
            fatalError("error!")
        }

        if passwordTextField.text != "admin" {
            fatalError("error!")
        }

        view.resignFirstResponder()
    }

    
}

