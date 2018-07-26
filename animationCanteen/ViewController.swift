//
//  ViewController.swift
//  animationCanteen
//
//  Created by Rayo Roderik on 25/07/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var satu: UIView!
    @IBOutlet weak var satuPuzzle: UIView!
    
    var viewSatuPos: CGPoint!
    @IBOutlet weak var dua: UIView!
    var viewDuaPos: CGPoint!
    @IBOutlet weak var tiga: UIView!
    var viewTigaPos: CGPoint!
    @IBOutlet weak var empat: UIView!
    @IBOutlet weak var lima: UIView!
    @IBOutlet weak var enam: UIView!
    @IBOutlet weak var tujuh: UIView!
    @IBOutlet weak var delapan: UIView!
    @IBOutlet weak var sembilan: UIView!
    
    @IBOutlet weak var gambarSatu: UIImageView!
    @IBOutlet weak var gambarDua: UIImageView!
    @IBOutlet weak var gambarTiga: UIImageView!
    
    @IBOutlet weak var gambarGede: UIView!
    var animator: UIDynamicAnimator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewSatuPos = satu.frame.origin
        viewDuaPos = dua.frame.origin
        viewTigaPos = tiga.frame.origin
        
        addPanGesture(view: gambarSatu)
        addPanGesture(view: gambarDua)
        view.bringSubview(toFront: gambarSatu)
        view.bringSubview(toFront: gambarDua)
        
        print(satuPuzzle.frame)
        
        
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        dropObject()
    }
    
    // pan gestures
    func addPanGesture(view: UIImageView){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
        
    }
    
    func dropObject(){
        animator = UIDynamicAnimator(referenceView: self.view)
        //gravity
        //Add gravity to the squares
        let gravity = UIGravityBehavior(items: [gambarSatu, gambarDua, gambarTiga])
        let direction = CGVector(dx: 0.0, dy: 0.5)
        gravity.gravityDirection = direction
        
        //Collision
        let boundaries = UICollisionBehavior(items: [gambarSatu, gambarDua, gambarTiga])
        boundaries.translatesReferenceBoundsIntoBoundary = true
        
        //Elasticity
        let bounce = UIDynamicItemBehavior(items: [gambarSatu, gambarDua, gambarTiga])
        bounce.elasticity = 0.3
        
        animator?.addBehavior(gravity)
        animator?.addBehavior(boundaries)
        animator?.addBehavior(bounce)
    }
    
    // puzzle mix match
    @objc func handlePan(sender: UIPanGestureRecognizer){
        
        let pieceView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            pieceView.center = CGPoint(x: pieceView.center.x + translation.x, y: pieceView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended:
            
            if pieceView.frame.intersects(satuPuzzle.frame){
                UIView.animate(withDuration: 0.5) {
                    sender.view!.frame.origin = self.viewSatuPos
                    print(self.gambarSatu.frame.origin)
                    print(self.satu.frame.origin)
                    
                    self.zoomEverything()
                }
            }
            else if pieceView.frame.intersects(dua.frame){
                UIView.animate(withDuration: 0.5) {
                    sender.view!.frame.origin = self.viewDuaPos
                    print(self.gambarDua.frame.origin)
                    print(self.dua.frame.origin)
                }
            }
        default:
            break
        }
    }
    
    //zoom
    func zoomEverything(){
        if gambarSatu.frame.origin == satu.frame.origin{
            print("ayam")
            UIView.animate(withDuration: 5, animations: {
                self.gambarGede.alpha = 1
                self.gambarGede.transform = CGAffineTransform(scaleX: 2, y: 2)
            }) { (true) in
                self.gambarGede.alpha = 0
                self.gambarGede.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
            
            
        }
    }
    
    
}

