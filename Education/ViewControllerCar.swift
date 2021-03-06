//
//  ViewController.swift
//  Lab2
//
//  Created by Valentino Palomba on 04/11/2019.
//  Copyright © 2019 Valentino Palomba. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController5years: UIViewController {
    var collision : UICollisionBehavior!
    var animator : UIDynamicAnimator!
    
    @IBOutlet weak var Fantastic: UIImageView!
    
    @IBOutlet weak var Green: UIButton!      /* DIchiarazioni Principali delle varie immagini e bottoni */
    @IBOutlet weak var LetteraA: UIImageView!
    @IBOutlet weak var LetteraP: UIImageView!
    @IBOutlet weak var Airplane: UIImageView!
    @IBOutlet weak var Piccione: UIImageView!
    @IBOutlet weak var LetteraN: UIImageView!
    
    @IBOutlet weak var LetteraE: UIImageView!
    @IBOutlet weak var Mongolfiera: UIImageView!
    @IBOutlet weak var LetteraL: UIImageView!
    
    @IBOutlet weak var LetteraPSotto: UIImageView!
    @IBOutlet weak var LetteraLSotto: UIImageView!
    var gravity: UIGravityBehavior!
    
    @IBOutlet weak var Back: UIButton!
    @IBOutlet weak var LetteraASotto: UIImageView!
    var motionManager = CMMotionManager()
    
    @IBOutlet weak var LetteraNSotto: UIImageView!
    
    @IBOutlet weak var PopuP: UIImageView!
    @IBOutlet weak var LetteraESotto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PopuP.isHidden = true
        self.LetteraASotto.isHidden = true
        self.LetteraPSotto.isHidden = true
        self.LetteraLSotto.isHidden = true
        self.LetteraNSotto.isHidden = true
        self.LetteraESotto.isHidden = true
        self.Green.isEnabled = false
        self.Green.isHidden = true
        Fantastic.isHidden = true
        
        /* Descrive il comportamento di gravità e collisioni */
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [Airplane])
        gravity.gravityDirection = CGVector(dx: 0, dy: 0)
        animator.addBehavior(gravity)
        
        self.collision = UICollisionBehavior(items: [ self.Airplane])
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.collision.addBoundary(withIdentifier: "Mongolfiera" as NSCopying, for: UIBezierPath(rect: Mongolfiera.frame))
        self.collision.addBoundary(withIdentifier: "Piccione" as NSCopying, for: UIBezierPath(rect: Piccione.frame))
        
        self.animator.addBehavior(self.collision)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /* Funzione che ricava dati dal giroscopio e applica le coordinate alla gravità */
        motionManager.gyroUpdateInterval = 1.0 / 60.0
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            if let _ = data
            {
                
                let x = (data?.rotationRate.x ?? 0.0)
                let y = (data?.rotationRate.y ?? 0.0)
                
                
                self.gravity.gravityDirection = CGVector(dx: y, dy: x)
                
            }
            
            if self.Airplane.frame.intersects(self.LetteraA.frame) == true && self.LetteraA.isHidden == false {
                self.playSound(NameSong: "LetteraA")
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                self.LetteraASotto.isHidden = false
                self.LetteraA.isHidden = true
            }
            
            if self.Airplane.frame.intersects(self.LetteraL.frame) == true && self.LetteraL.isHidden == false {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                self.playSound(NameSong: "LetteraL")
                self.LetteraLSotto.isHidden = false
                self.LetteraL.isHidden = true
            }
            
            if self.Airplane.frame.intersects(self.LetteraP.frame) == true && self.LetteraP.isHidden == false {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                self.playSound(NameSong: "LetteraP")
                self.LetteraPSotto.isHidden = false
                self.LetteraP.isHidden = true
            }
            if self.Airplane.frame.intersects(self.LetteraN.frame) == true && self.LetteraN.isHidden == false {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                self.playSound(NameSong: "LetteraN")
                self.LetteraNSotto.isHidden = false
                self.LetteraN.isHidden = true
            }
            
            if self.Airplane.frame.intersects(self.LetteraE.frame) == true && self.LetteraE.isHidden == false{
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                self.LetteraESotto.isHidden = false
                self.LetteraE.isHidden = true
                
            }
            
            if (self.LetteraA.isHidden == true && self.LetteraP.isHidden == true && self.LetteraN.isHidden == true && self.LetteraL.isHidden == true && self.LetteraE.isHidden)
            {
                self.PopuP.isHidden = false
                self.Green.isEnabled = true
                self.Green.isHidden = false
                self.Fantastic.isHidden = false
                
            }
            
            
        }
        
        
    }
    var player: AVAudioPlayer?
    
    func playSound(NameSong : String) {
        guard let url = Bundle.main.url(forResource: NameSong, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    
}

