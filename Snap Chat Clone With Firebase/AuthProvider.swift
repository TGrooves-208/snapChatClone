//
//  AuthProvider.swift
//  Snap Chat Clone With Firebase
//
//  Created by Gil Aguilar on 2/8/17.
//  Copyright © 2017 Red Eye Dev. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias LoginHandler = (_ errMSG: String?) -> Void;

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid Email Address, Please provide a valid email adress.";
    static let WRONG_PASSWORD = "Wrong Password";
    static let PROBLEM_CONNECTING = "Problem Connecting to Database, Please Try Again later";
    static let USER_NOT_FOUND = "User Not Found, Please Register";
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use, Please Use Another Email";
    static let WEAK_PASSWORD = "Password Should Be At Least 6 Characters Long";

}

class AuthProvider {
    
    private static let _instance = AuthProvider();
    
    static var instance: AuthProvider {
        return _instance;
    }
    
    func isLoggedIn() -> Bool {
        if FIRAuth.auth()?.currentUser != nil {
            return true;
        }
        
        return false;
    }
    
    func logOut() -> Bool {
        
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut();
                return true;
            } catch {
                return false;
            }
        }
        return true;
    }
    
    func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
        FIRAuth.auth()?.signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            
            if error != nil {
                // user not signed in so an error will be thrown
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
                
            } else {
                // user is signed in
                loginHandler?(nil);
            }
            
        });
    }
    
    func signUp(withEmail: String, password: String, loginHandler: LoginHandler?) {
        
        FIRAuth.auth()?.createUser(withEmail: withEmail, password: password, completion: { (user, error) in
            
            if error != nil {
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
            } else {
                
                if user?.uid != nil {
                    
                    // save to database
                    DBProvider.instance.saveUser(withID: user!.uid, email: withEmail, password: password);
                    
                    
                    // sign in the user because they are created
                    FIRAuth.auth()?.signIn(withEmail: withEmail, password: password, completion: { (user, error) in
                        
                        if error != nil {
                            self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
                        } else {
                            loginHandler?(nil);
                            
                        }
                        
                        
                        
                    });
                    
                    
                }
                
            }
            
        });
        
    }
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?) {
        
        if let errCode = FIRAuthErrorCode(rawValue: err.code) {
            
            switch errCode {
                
            case .errorCodeWrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD);
                break;
                
            case .errorCodeInvalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL);
                break;
                
            case .errorCodeUserNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND);
                break;
                
            case .errorCodeEmailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE);
                break;
                
            case .errorCodeWeakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD);
                break;
                
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING);
                break;
                
            }
            
        }
        
    }
    
    
}

























































