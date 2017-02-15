//
//  Users.swift
//  Snap Chat Clone With Firebase
//
//  Created by Gil Aguilar on 2/8/17.
//  Copyright © 2017 Red Eye Dev. All rights reserved.
//

import Foundation

struct User {
    
    private var _email = String();
    private var _id = String() ;
    
    init(id: String, email: String) {
        _id = id;
        _email = email;
    }
    
    var id: String {
        return _id;
    }
    
    var email: String {
        get {
            return _email;
        }
    }
}






































