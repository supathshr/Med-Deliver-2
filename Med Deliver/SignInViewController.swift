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
        // prepare json data
        let json: [String: Any] = [
            "requestType": "authentication",
            "username": EmailAddressTextField.text!,
            "password": PasswordTextField.text!
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
                let registered = responseJSON["authenticated"] as? String
                if(registered == "true") {
                    print("logged in!!")
                    
                    let authKey = responseJSON["authKey"] as? String
                    
                    //show the main view
                    DispatchQueue.main.async {
                        let homeViewController =
                            self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = homeViewController
                    }
                    
                } else {
                    self.displayMessage(userMessage: "Invalid username/password")
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
