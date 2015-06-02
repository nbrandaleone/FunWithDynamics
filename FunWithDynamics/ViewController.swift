//
//  ViewController.swift
//  FunWithDynamics
//
//  Created by Nick Brandaleone on 6/2/15.
//  Copyright (c) 2015 Nick Brandaleone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var square: UIView!
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create a square view
        var square = UIView(frame: CGRectMake(0, 0, 60, 60))
        square.backgroundColor = UIColor(red: 0.311, green: 0.101, blue: 0.311, alpha: 1.0)
        square.center = self.view.center
        square.layer.shadowColor = UIColor.blackColor().CGColor
        square.layer.shadowOffset = CGSizeMake(1, 1)
        square.layer.shadowOpacity = 0.5
        square.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 4.1))
        self.square = square
        self.view.addSubview(square)
        
        // Add a rigid barrier
        var barrier: UIView = UIView(frame: CGRectMake(0, 200, 130, 10))
        barrier.backgroundColor = UIColor.redColor()
        self.view.addSubview(barrier)
        
        // Add physics engine
        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        self.gravity = UIGravityBehavior(items: [square])
        
        self.collision = UICollisionBehavior(items: [square])
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.collision.addBoundaryWithIdentifier("barrier",
            forPath: UIBezierPath(rect: barrier.frame))
        
        let behavior: UIDynamicItemBehavior = UIDynamicItemBehavior(items: [square])
        behavior.elasticity = 0.8
        behavior.friction = 0.1
        behavior.angularResistance = 0.1
        
        // Turn on dynamic behaviors: gravity, collisions, elasticity or bounce
        self.animator.addBehavior(self.gravity)
        self.animator.addBehavior(self.collision)
        self.animator.addBehavior(behavior)
        
        // Add bump behavior
        bump()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: Selector("bump"))
        self.view.addGestureRecognizer(tap)
    }
    
    func bump() {
        var bump: UIDynamicItemBehavior = UIDynamicItemBehavior(items: [self.square])
        bump.addLinearVelocity(CGPointMake(600, -1200), forItem: self.square)
        self.animator.addBehavior(bump)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

