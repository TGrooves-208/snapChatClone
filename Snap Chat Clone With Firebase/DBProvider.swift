//
//  DBProvider.swift
//  Snap Chat Clone With Firebase
//
//  Created by Gil Aguilar on 2/12/17.
//  Copyright © 2017 Red Eye Dev. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider {
    private static let _instance = DBProvider();
    
    private let USERS = "users";
    private let EMAIL = "email";
    private let PASSWORD = "password";
    private let DATA = "data";
    
    static var instance: DBProvider {
        return _instance;
    }
    
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference();
    }
    
    var usersRef: FIRDatabaseReference {
        return dbRef.child(USERS);
    }
    
    func saveUser(withID: String, email: String, password: String) {
        let data: Dictionary<String, String> = [EMAIL: email, PASSWORD: password];
        
        usersRef.child(withID).child(DATA).setValue(data);
        
    }
    
}


































