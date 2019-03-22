//
//  RegisterNewAccountViewController.swift
//  Med Deliver
//
//  Created by Omar El-Hamzawi on 09/03/2019.
//  Copyright © 2019 Supath Shrestha. All rights reserved.
//

import UIKit

class RegisterNewAccountViewController: UIViewController {
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var DateOfBirthTextField: UITextField!
    
    @IBOutlet weak var LastNameTextFIeld: UITextField!
    
    @IBOutlet weak var GenderTextField: UITextField!
    
    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        print ("Back button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateAccountButtonTapped(_ sender: Any) {
        print ("Create Account button tapped")
        // prepare json data
        let json: [String: Any] = [
            "requestType": "register",
            "username": EmailAddressTextField.text!,
            "password": PasswordTextField.text!,
            "firstName": FirstNameTextField.text!,
            "lastName": LastNameTextFIeld.text!,
            "dob": DateOfBirthTextField.text!,
            "gender": GenderTextField.text!
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "http://localhost:8080")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                let reason = responseJSON["reason"] as? String
                let registered = responseJSON["registered"] as? String
                if(registered == "true") {
                    print("success!!")
                    self.displayMessage(userMessage:"You've Successfully Registered. Please Sign in with your new Credentials.")
                    DispatchQueue.main.async {
                        let homeViewController =
                        self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = homeViewController
                    }
                    
                } else {
                    self.displayMessage(userMessage: reason ?? "Failed to register, please try again.")
                    print("Register Failed!!")
                }
            }
        }
        task.resume()
        
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
