//
//  ViewController.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/13.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableV: UITableView!
    var ball: UIView!
    var keyboardSize: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableV.keyboardDismissMode = .Interactive
        tableV.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        
        ball = UIView(frame: CGRectMake(0,0,30,30))
        ball.frame.origin.y = UIScreen.mainScreen().bounds.maxY - 30
        print(ball.frame.origin)
        ball.layer.cornerRadius = ball.bounds.width / 2
        ball.backgroundColor = UIColor.greenColor()
        self.view.addSubview(ball)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey])?.CGRectValue {
//            print(keyboardSize)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        print(notification.userInfo)
        if let keyboardSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey])?.CGRectValue {
            self.keyboardSize = keyboardSize
            if let duration = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey])?.floatValue {
                print(duration)
                if let curve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey])?.intValue {
                    let uc = UInt(curve)
                    print(curve)
                    // animate up
                    UIView.animateKeyframesWithDuration(duration.DoubleValue, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: uc), animations: { () -> Void in
                        self.ball.transform = CGAffineTransformMakeTranslation(0, 0)
                        }, completion: nil)
                }
            }
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")

        if let keyboardSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey])?.CGRectValue {
            self.keyboardSize = keyboardSize
            if let duration = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey])?.floatValue {
                print(duration)
                if let curve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey])?.intValue {
                    let uc = UInt(curve)
                    print(curve)
                    // animate up
                    UIView.animateKeyframesWithDuration(duration.DoubleValue, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: uc), animations: { () -> Void in
                        self.ball.transform = CGAffineTransformMakeTranslation(0, -keyboardSize.height)
                        }, completion: nil)
                }
            }
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        print("keyboardDidShow")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension Float {
    var DoubleValue : Double {
        return Double(self)
    }
}

extension ViewController : UITableViewDelegate {
    
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let position = scrollView.panGestureRecognizer.locationInView(view)
        if self.keyboardSize != nil {
            if position.y > self.keyboardSize!.origin.y {
                print("on drag")
                let offset = UIScreen.mainScreen().bounds.height - position.y
                ball.transform = CGAffineTransformMakeTranslation(0, -offset)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        if self.keyboardSize != nil {
            let offset = UIScreen.mainScreen().bounds.height - self.keyboardSize!.origin.y
            ball.transform = CGAffineTransformMakeTranslation(0, -offset)
        }
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
        if self.keyboardSize != nil {
            let offset = UIScreen.mainScreen().bounds.height - self.keyboardSize!.origin.y
            ball.transform = CGAffineTransformMakeTranslation(0, -offset)
        }
    }
}

