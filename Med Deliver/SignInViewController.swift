//
//  SignInViewController.swift
//  Med Deliver
//
//  Created by Supath Shrestha on 19/11/2018.
//  Copyright © 2018 Supath Shrestha. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBAction func SignInButtonTapped(_ sender: Any) {
        print ("Sign in Button Tapped")
    }
    
    @IBAction func RegisterButtonTapped(_ sender: Any) {
        print ("Register Button Tapped")
    }
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        print ("Back button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var ForgotPasswordButtonTapped: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
}
