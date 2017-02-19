//
//  ContactsVC.swift
//  Snap Chat Clone With Firebase
//
//  Created by Gil Aguilar on 2/8/17.
//  Copyright © 2017 Red Eye Dev. All rights reserved.
//

import UIKit
import MobileCoreServices
import FirebaseDatabase
import FirebaseAuth

class ContactsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    private var users = [User]();
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    private var index = -1;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsers();

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let imgData = UIImageJPEGRepresentation(pickedImage, 0.8)!
                as Data
            
            let imgName = "\(NSUUID().uuidString).jpg";
            DBProvider.instance.saveImage(data: imgData, name: imgName);
            
            dismiss(animated: true, completion: nil);
            
        } else if let pickedVideoURL = info [UIImagePickerControllerMediaURL] as? URL {
            
            let videoName = "\(NSUUID().uuidString)\(pickedVideoURL)";
            
            DBProvider.instance.saveVideo(url:pickedVideoURL, name: videoName);
            
            dismiss(animated: true, completion: nil);
        }
    }
    
    private func getUsers() {
        DBProvider.instance.usersRef.observeSingleEvent(of: FIRDataEventType.value) { (snapshot:FIRDataSnapshot) in
            
            if let myUsers = snapshot.value as? Dictionary<String, AnyObject> {
                
                for (key, value) in myUsers {
                    
                    if let userData = value as? Dictionary<String, AnyObject> {
                        
                        if let data = userData["data"] as? Dictionary<String, AnyObject> {
                            
                            if let email = data["email"] as? String {
                                
                                let id = key;
                                let newUser = User(id: id, email: email);
                                self.users.append(newUser);
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
            self.contactsTableView.reloadData();
            
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath);
        
        cell.textLabel?.text = users[indexPath.row].email;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row;
    }
    
    
    @IBAction func logOut(_ sender: Any) {
        if AuthProvider.instance.logOut() {
            dismiss(animated: true, completion: nil);
        } else {
            showAlertMessage(title: "Could Not Log Out", message: "We Have A Problem Connecting To The Database to Log Out, Please Try Again");
        }
    }
    
    @IBAction func openGallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController();
            imagePicker.delegate = self;
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false;
            self.present(imagePicker, animated: true, completion: nil);
        }
    }
    
    @IBAction func sendImageOrVideo(_ sender: Any) {
        
        if index != -1 {
            
            if DBProvider.instance.imageURL != nil {
                
                DBProvider.instance.setMessageAndMEdia(senderID: FIRAuth.auth()!.currentUser!.uid, sendingTo: users[index].id, mediaURL: DBProvider.instance.imageURL!.absoluteString, message: "This is my cool image");
                
                index = -1;
                
            } else if DBProvider.instance.videoURL != nil {
                DBProvider.instance.setMessageAndMEdia(senderID: FIRAuth.auth()!.currentUser!.uid, sendingTo: users[index].id, mediaURL: DBProvider.instance.videoURL!.absoluteString, message: "This is my cool video");
                
                index = -1;
                
            } else {
                showAlertMessage(title: "No Data To Send", message: "Please Select A Video Or An Image To Send");
            }
            
        } else {
            showAlertMessage(title: "Select A User", message: "Please Select A User to Send a Message To");
        }
        
    }
    
    @IBAction func takePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController();
            imagePicker.delegate = self;
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false;
            self.present(imagePicker, animated: true, completion: nil);
        }
        
    }
    
    @IBAction func takeVideo(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController();
            imagePicker.sourceType = .camera;
            imagePicker.mediaTypes = [kUTTypeMovie as String];
            imagePicker.allowsEditing = false;
            imagePicker.delegate = self;
            present(imagePicker, animated: true)
            
        }
        
    }
    
    private func showAlertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
        
    }


} // class























































