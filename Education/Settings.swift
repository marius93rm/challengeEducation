//
//  Settings.swift
//  Education
//
//  Created by Valentino Palomba on 21/11/2019.
//  Copyright © 2019 Marius Minia. All rights reserved.
//

import Foundation
import UIKit

class Settings : UIViewController{
    
    @IBOutlet weak var twoyears: UIButton!
    
    @IBOutlet weak var fouryears: UIButton!
    @IBOutlet weak var threeyears: UIButton!
    @IBOutlet weak var Scritta: UIImageView!
    
    @IBAction func settingsButton(_ sender: Any) {
        
        let alertController = UIAlertController (title: "Activate Guided Access", message: "To prevent your child from exiting the app please, go to Settings -> Accesibilty -> Guided Access", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIView.animate(withDuration: 2, animations: {
            self.Scritta.transform = CGAffineTransform(translationX: 0, y: 130)
        }, completion: { _ in
            
            self.threeyears.isHidden = false
            self.fouryears.isHidden = false
            self.twoyears.isHidden = false
            self.Scritta.isHighlighted = true
            UIView.animate(withDuration: 2, animations: {
              
                self.twoyears.transform = CGAffineTransform(translationX: 320, y: 0)
                 self.threeyears.transform = CGAffineTransform(translationX: -320, y: 0)
                 self.fouryears.transform = CGAffineTransform(translationX: 320, y: 0)
            })
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
}








