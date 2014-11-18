//
//  CardsViewController.swift
//  TinderLIke
//
//  Created by Cindy Zheng on 11/18/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning  {
    
    
    var cardInitialCenter: CGPoint!
    var isPresenting: Bool = true
    
     @IBOutlet var myPanGuesture: UIPanGestureRecognizer!
    @IBOutlet weak var myImageView: UIImageView!
    
    //controller delegate 
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    
    
    //MARK - uiviewcontrolleranimatedtransiting protocol 
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval{
        
    
            return 0.4
    }
    
     func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  }

    @IBAction func onPan(sender: UIPanGestureRecognizer) {
         self.performSegueWithIdentifier("toProfile", sender: nil)

    }
//    @IBAction func onTap(sender: UITapGestureRecognizer) {
//        self.performSegueWithIdentifier("toProfile", sender: nil)
//    
//    }
    
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toProfile" {
            let vc = segue.destinationViewController as ProfileViewController
                vc.modalPresentationStyle = UIModalPresentationStyle.Custom
                vc.transitioningDelegate = self
             vc.image = self.myImageView.image
        }
    }
   
}
