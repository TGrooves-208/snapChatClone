//
//  ShowMessageVC.swift
//  Snap Chat Clone With Firebase
//
//  Created by Gil Aguilar on 2/19/17.
//  Copyright © 2017 Red Eye Dev. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ShowMessageVC: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    private let avPlayerVC = AVPlayerViewController();
    var avPlayer: AVPlayer?;
    
    
    var mediaURL = "";

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage();

    }
    
    private func loadImage() {
        
        if let url = URL(string: mediaURL) {
            
            let request = NSMutableURLRequest(url: url);
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, err) in
                
                if err != nil {
     // This needs to be refactored 
                    
                } else {
                    
                    if data != nil {
                        
                        if let img = UIImage(data: data!) {
                            self.myImageView.image = img;
                        } else {
                            self.avPlayer = AVPlayer(url: url);
                            self.avPlayerVC.player = self.avPlayer;
                            self.present(self.avPlayerVC, animated: true, completion: nil);
                        }
                    }
                }
                
            })
            
            task.resume();
        }
    }

    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }

} // class








































