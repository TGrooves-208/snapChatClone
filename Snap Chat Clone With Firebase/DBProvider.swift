//
//  DBProvider.swift
//  Snap Chat Clone With Firebase
//
//  Created by Gil Aguilar on 2/12/17.
//  Copyright © 2017 Red Eye Dev. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DBProvider {
    private static let _instance = DBProvider();
    
    private let USERS = "users";
    private let CHILD_MESSAGE = "message";
    private let EMAIL = "email";
    private let PASSWORD = "password";
    private let DATA = "data";
    private let IMAGE_STORAGE = "images";
    private let VIDEO_STORAGE = "videos";
    
    let SENDER_ID = "senderID";
    let RECEIVER = "receiver";
    let MEDIA_URL = "mediaURL";
    let MESSAGE = "message";
    
    var imageURL: URL?;
    var videoURL: URL?;
    
    static var instance: DBProvider {
        return _instance;
    }
    
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference();
    }
    
    var usersRef: FIRDatabaseReference {
        return dbRef.child(USERS);
    }
    
    var messageRef: FIRDatabaseReference {
        return dbRef.child(CHILD_MESSAGE);
    }
    
    // Reference to our Firebase URL located in the storage section in the Firebase console
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: "gs://myawesomechat-cd051.appspot.com");
    }
    
    // Images
    var imagesStorage: FIRStorageReference {
        return storageRef.child(IMAGE_STORAGE);
    }
    
    // Videos
    var videoStorage: FIRStorageReference {
        return storageRef.child(VIDEO_STORAGE);
    }
    
    // Saving the image as data
    func saveImage(data: Data, name: String) {
        let ref = imagesStorage.child(name);
        
        ref.put(data, metadata: nil) { (metadata:FIRStorageMetadata?, err: Error?) in
            
            if err != nil {
                print("Problem uploading image");
            } else {
                self.imageURL = metadata!.downloadURL();
            }
        }
    }
    
    func saveVideo(url: URL, name: String) {
        let ref = videoStorage.child(name);
        
        ref.putFile(url, metadata: nil) { (metadata:FIRStorageMetadata?,error:Error?) in
            
            if error != nil {
                print("Inform the user with handlers that we have a problem uploading video");
            } else {
                self.videoURL = metadata!.downloadURL();
            }
        }
        
    }
    
    // This is going to create a message and send it to the user
    func setMessageAndMEdia(senderID: String, sendingTo: String, mediaURL: String, message: String) {
        
        
        let msg: Dictionary<String, String> = [self.SENDER_ID: senderID, self.RECEIVER: sendingTo, self.MEDIA_URL: mediaURL, self.MESSAGE: message]
        
        dbRef.child(CHILD_MESSAGE).childByAutoId().setValue(msg);
        
    }
    
    func saveUser(withID: String, email: String, password: String) {
        let data: Dictionary<String, String> = [EMAIL: email, PASSWORD: password];
        
        usersRef.child(withID).child(DATA).setValue(data);
        
    }
    
}


































