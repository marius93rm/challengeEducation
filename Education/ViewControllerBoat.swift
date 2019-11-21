//
//  Scene3.swift
//  Lab2
//
//  Created by Valentino Palomba on 07/11/2019.
//  Copyright © 2019 Valentino Palomba. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController3: UIViewController {
    var collision : UICollisionBehavior!
    var animator : UIDynamicAnimator!
    @IBOutlet weak var LetteraR: UIImageView!
    
    @IBOutlet weak var Finish: UIImageView!
    @IBOutlet weak var PopUP: UIImageView!
    @IBOutlet weak var Blur: UIImageView!
    @IBOutlet weak var LetteraA: UIImageView!
    @IBOutlet weak var LetteraC: UIImageView!
    @IBOutlet weak var Barrier1: UIImageView!
    
    @IBOutlet weak var Green: UIButton!
    @IBOutlet weak var Barrier2: UIImageView!
    var gravity: UIGravityBehavior!
    @IBOutlet weak var LetteraCSotto: UIImageView!
    
    @IBOutlet weak var Barrier4: UIImageView!
    @IBOutlet weak var Barrier3: UIImageView!
    var motionManager = CMMotionManager()
    
    @IBOutlet weak var Back: UIButton!
    @IBOutlet weak var LetteraASotto: UIImageView!
    @IBOutlet weak var Barrier5: UIImageView!
    
    @IBOutlet weak var Barrier6: UIImageView!
    
    
    @IBOutlet weak var LetteraRSotto: UIImageView!
    @IBOutlet weak var Barrier8: UIImageView!
    @IBOutlet weak var Barrier7: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LetteraASotto.isHidden = true
        LetteraRSotto.isHidden = true
        LetteraCSotto.isHidden = true
        Blur.isHidden = true
        Green.isHidden = true
        Green.isEnabled = false
        PopUP.isHidden = true
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [Palla])
        gravity.gravityDirection = CGVector(dx: 0, dy: 0)
        animator.addBehavior(gravity)
        
        self.collision = UICollisionBehavior(items: [ self.Palla])
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.collision.addBoundary(withIdentifier: "BArrier1" as NSCopying, for: UIBezierPath(rect: Barrier1.frame))
        self.collision.addBoundary(withIdentifier: "Barrier2" as NSCopying, for: UIBezierPath(rect: Barrier2.frame))
        self.collision.addBoundary(withIdentifier: "Barrier3" as NSCopying, for: UIBezierPath(rect: Barrier3.frame))
        self.collision.addBoundary(withIdentifier: "Barrier4" as NSCopying, for: UIBezierPath(rect: Barrier4.frame))
        self.collision.addBoundary(withIdentifier: "Barrier5" as NSCopying, for: UIBezierPath(rect: Barrier5.frame))
        self.collision.addBoundary(withIdentifier: "Barrier6" as NSCopying, for: UIBezierPath(rect: Barrier6.frame))
        self.collision.addBoundary(withIdentifier: "Barrier7" as NSCopying, for: UIBezierPath(rect: Barrier7.frame))
        self.collision.addBoundary(withIdentifier: "Barrier8" as NSCopying, for: UIBezierPath(rect: Barrier8.frame))
        
        self.animator.addBehavior(self.collision)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        motionManager.gyroUpdateInterval = 1.0 / 60.0
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data
            {
                let x = (data?.rotationRate.x ?? 0.0) * 2.0
                let y = (data?.rotationRate.y ?? 0.0)
                
                
                self.gravity.gravityDirection = CGVector(dx: y, dy: x)
                
            }
            
            
            if self.Palla.frame.intersects(self.LetteraC.frame) == true {
                self.playSound(NameSong: "LetteraC")
                self.LetteraCSotto.isHidden = false
                self.LetteraC.isHidden = true
            }
            
            if self.Palla.frame.intersects(self.LetteraA.frame) == true {
                self.playSound(NameSong: "LetteraA")
                self.LetteraASotto.isHidden = false
                self.LetteraA.isHidden = true
            }
            if self.Palla.frame.intersects(self.LetteraR.frame) == true {
                self.playSound(NameSong: "LetteraR")
                self.LetteraRSotto.isHidden = false
                self.LetteraR.isHidden = true
            }
            if self.Palla.frame.intersects(self.Finish.frame) == true {
                self.Blur.isHidden = false
                self.PopUP.isHidden = false
                self.Green.isEnabled = true
                self.Green.isHidden = false
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
    
    
    
    
    
    
    @IBOutlet weak var Palla: UIImageView!
    
    
    
}


