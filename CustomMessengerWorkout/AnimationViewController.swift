//
//  AnimationViewController.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/14.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var r: UIView!
    var g: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        r = UIView(frame: UIScreen.mainScreen().bounds)
        r.frame.size = CGSize(width: 90, height: 30)
        r.frame.origin.y = UIScreen.mainScreen().bounds.maxY - r.frame.size.height
        view.addSubview(r)
        r.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "grow"))
        r.backgroundColor = UIColor.redColor()
        
        g = UIView(frame: r.frame)
        g.frame.size.width = 30
        g.center.y = r.bounds.midY
        g.center.x = r.center.x
        g.backgroundColor = UIColor.greenColor()
        r.addSubview(g)
    }
    
    func grow() {
        let offset: CGFloat = 30
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.r.frame.size.height += 30
            self.g.frame.origin.y += 30
            print(self.r.frame.size.height)
            self.r.frame.origin.y = UIScreen.mainScreen().bounds.maxY - self.r.frame.size.height
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
