//
//  RegisterNewAccountViewController.swift
//  Med Deliver
//
//  Created by Omar El-Hamzawi on 09/03/2019.
//  Copyright © 2019 Supath Shrestha. All rights reserved.
//

import UIKit

class RegisterNewAccountViewController: UIViewController {
    
    @IBOutlet weak var FullNameTextField: UITextField!
    
    @IBOutlet weak var DateOfBirthTextField: UITextField!
    
    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        print ("Back button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateAccountButtonTapped(_ sender: Any) {
        print ("Create Account button tapped")
        
        //Validate Required fields are not Empty
        if (FullNameTextField.text?.isEmpty)! ||
        (DateOfBirthTextField.text?.isEmpty)! ||
        (EmailAddressTextField.text?.isEmpty)! ||
        (PasswordTextField.text?.isEmpty)!
        {
            //Display Alert Message and Return
            displayMessage(userMessage: "All fields are required to be filled in")
            return
        }
        //Validate Password
        if((PasswordTextField.text?.elementsEqual(ConfirmPasswordTextField.text!))! != true)
            
        {
            //Display Alert Message and Return
            displayMessage(userMessage: "Make sure your passwords match")
                return
        }
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        // Call stopAnimating() when need to stop activity indicator
        //myActivityIndicator.stopAnimating()
        
        
        view.addSubview(myActivityIndicator)
    }
    
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
            let alertController =   UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
            let OkAction = UIAlertAction(title: "OK", style: .default)
            { (action:UIAlertAction!) in
                //Code in this block will trigger OK when tapped
                print("OK Button Tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
    }
    alertController.addAction(OkAction)
    self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
        print ("Login Button Tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
