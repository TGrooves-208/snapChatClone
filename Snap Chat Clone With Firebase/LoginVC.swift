//
//  ViewController.swift
//  Snap Chat Clone With Firebase
//
//  Created by Gil Aguilar on 2/7/17.
//  Copyright © 2017 Red Eye Dev. All rights reserved.
//  Changed the name of the View Controller to LoginVC


import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    private let CONTACTS_SEGUE_ID = "ContactsVC";
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if AuthProvider.instance.isLoggedIn() {
            performSegue(withIdentifier: CONTACTS_SEGUE_ID, sender: nil);
        }
    }
    
    @IBAction func logIn(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            AuthProvider.instance.login(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.showAlertMessage(title: "Problem with Authentication", message: message!);
                    
                } else if message == nil {
                    self.emailTextField.text = "";
                    self.passwordTextField.text = "";
                    self.performSegue(withIdentifier: self.CONTACTS_SEGUE_ID, sender: nil);
                }
                
            });
            
        } else {
            showAlertMessage(title: "Email Ane Password Are Required", message: "Please enter email and password in the text fields");
            
        }
        
    }

    @IBAction func signUpUser(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            AuthProvider.instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.showAlertMessage(title: "Problem With Signing Up", message: message!);
                    
                } else {
                    self.emailTextField.text = "";
                    self.passwordTextField.text = "";
                    self.performSegue(withIdentifier: self.CONTACTS_SEGUE_ID, sender: nil);
                }
                
            });
            
        } else {
            showAlertMessage(title: "Email Ane Password Are Required", message: "Please enter email and password in the text fields");
        }
        
    }
    
    private func showAlertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
        
    }
   
} // class

































