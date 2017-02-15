//
//  ContactsVC.swift
//  Snap Chat Clone With Firebase
//
//  Created by Gil Aguilar on 2/8/17.
//  Copyright © 2017 Red Eye Dev. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var users = [User]();
    
    @IBOutlet weak var contactsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
    @IBAction func logOut(_ sender: Any) {
        if !AuthProvider.instance.logOut() {
            dismiss(animated: true, completion: nil);
        } else {
            showAlertMessage(title: "Could Not Log Out", message: "We Have A Problem Connecting To The Database to Log Out, Please Try Again");
        }
    }
    
    @IBAction func openGallery(_ sender: Any) {
        
    }
    
    @IBAction func sendImageOrVideo(_ sender: Any) {
        
    }
    
    @IBAction func takePicture(_ sender: Any) {
        
        
    }
    
    @IBAction func takeVideo(_ sender: Any) {
        
        
    }
    
    private func showAlertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
        
    }


} // class























































