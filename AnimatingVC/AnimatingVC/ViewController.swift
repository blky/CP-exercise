import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        myImage.center = location
        if (sender.state ) == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
        }
    }
    @IBAction func onPinch(sender: UIPinchGestureRecognizer) {
        
        var scale = sender.scale
        myImage.transform = CGAffineTransformMakeScale(scale, scale)
        
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        
        println("you tap")
        
    }
    @IBAction func onGo(sender: AnyObject) {
      
//        var transform = CATransform3DIdentity;
//        transform.m34 = -1/500.0;
//        var t = CATransform3DIdentity
//        myImage.layer.transform = CATransform3DMakeRotation(CGFloat(60 * M_PI) / 180,   0 ,   1,   0 )
//        //myImage.layer.transform = CATransform3DRotate(t, CGFloat(180 * M_PI) / 180,   0 ,   1,   0)
//        
//        
//       UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: nil, animations: { () -> Void in
//            var cgpoint = CGPointMake(self.myImage.center.x, self.myImage.center.y + 275)
//            self.myImage.center = cgpoint
//            self.myImage.transform = CGAffineTransformMakeScale(3, 3)
//            self.myImage.alpha = 1
//         //   self.myImage.backgroundColor = UIColor.purpleColor()
//        }) { ( finished: Bool) -> Void in
//            self.myImage.transform = CGAffineTransformRotate(self.myImage.transform, CGFloat(-10 * M_PI) / 180)
//            
//            self.myImage.image = UIImage(named: "bookmark-256")
//            
//
//            self.myImage.layer.transform = CATransform3DRotate(t,CGFloat( -60 * M_PI) / 180,   0 ,   1,   0 )
//                      UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
//                self.myImage.layer.transform = CATransform3DMakeRotation(CGFloat(120 * M_PI) / 180,   0 ,   1,   0 )
//                }, completion: { ( finished: Bool) -> Void in })
//        }
 
       UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: nil, animations: { () -> Void in
            self.myImage.frame.origin.y += 275
            self.myImage.transform = CGAffineTransformMakeScale(3, 3)
            self.myImage.alpha = 1
            self.myImage.backgroundColor = UIColor.purpleColor()
        }) { ( finished: Bool) -> Void in
            self.myImage.transform = CGAffineTransformRotate(self.myImage.transform, CGFloat(-10 * M_PI) / 180)
            
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
                    self.myImage.transform = CGAffineTransformRotate(self.myImage.transform, CGFloat(20 * M_PI) / 180)
                }, completion: { ( finished: Bool) -> Void in })
        }
    }
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myImage.image = UIImage(named: "bookmark-50.png")
        self.myImage.alpha = 0.2
        
    }

   


}

