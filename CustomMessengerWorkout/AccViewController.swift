//
//  AccViewController.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/13.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class AccViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var sv: UIScrollView!
    var tf: UITextField!
    var ball: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
        
        sv = UIScrollView(frame: UIScreen.mainScreen().bounds)
        sv.contentSize = UIScreen.mainScreen().bounds.size
        sv.contentSize.height = UIScreen.mainScreen().bounds.size.height * 2
        tf = UITextField(frame: CGRectMake(0,200,150,30))
        tf.backgroundColor = UIColor.yellowColor()
        sv.addSubview(tf)
        sv.keyboardDismissMode = .Interactive
        tf.delegate = self
        view.addSubview(sv)
        
        ball = UIView(frame: CGRectMake(0,0,30,30))
        ball.frame.origin.y = UIScreen.mainScreen().bounds.maxY - 30
        print(ball.frame.origin)
        ball.layer.cornerRadius = ball.bounds.width / 2
        ball.backgroundColor = UIColor.redColor()
        self.view.addSubview(ball)
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
    
    func accV() -> UIView {
        let v = UIView(frame: UIScreen.mainScreen().bounds)
        v.frame.size.height = 50
        v.backgroundColor = UIColor.greenColor()
        
        return v
    }

}


extension AccViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == tf {
            let at = ATrickyView()
            at.delegate = self
            textField.inputAccessoryView = at
        }
    }
}

extension AccViewController : ATrickyViewDelegate {
    func aTrickyViewDelegate(currentKeyboardRect keyboardRect: CGRect?) {
        if let kbRect = keyboardRect {
            print(kbRect)
            ball.frame.origin.y = kbRect.origin.y - 30
        }
    }
}