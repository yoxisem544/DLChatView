//
//  TextInputView.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/14.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class TextInputView: UIView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    var btn: UIButton!
    var textView: UITextView!
    var currentTextViewContentHeight: CGFloat! = 38.0 {
        didSet {
            if currentTextViewContentHeight <= maxMessgeBarHeight {
                currentMessageBarHeight = currentTextViewContentHeight + 8
                // update the view
                updateAlign()
                // tell the delegate that i am updating
                delegate?.textInputView(didUpdateFrame: self)
            }
            print("current message bar h")
            print(currentMessageBarHeight)
        }
    }
    var currentMessageBarHeight: CGFloat = 44.0
    let initialBarHeight: CGFloat = 44.0
    var maxMessgeBarHeight: CGFloat = 120.0
    var minMessageBarHeight: CGFloat = 44.0
    
    var delegate: TextInputViewDelegate?
    
    convenience init() {
        self.init(frame: CGRectZero)
        self.frame = UIScreen.mainScreen().bounds
        self.frame.size.height = 44
        self.backgroundColor = UIColor.yellowColor()
        
        btn = UIButton(type: UIButtonType.System)
        btn.frame = CGRectMake(0, 0, 30, 30)
        btn.setTitle("HI", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(18)
        btn.backgroundColor = UIColor.grayColor()
        self.addSubview(btn)
        
        textView = UITextView(frame: self.frame)
        textView.frame.size.width -= 30
        textView.frame.size.height = 38
        textView.center.y = self.bounds.midY
        textView.textAlignment = .Natural
        textView.bounces = false
        print(textView.contentSize)
        print(textView.frame)
        textView.backgroundColor = UIColor.clearColor()
        textView.layer.borderWidth = 2.0
        textView.layer.borderColor = UIColor.blackColor().CGColor
        textView.font = UIFont.systemFontOfSize(16)
        textView.delegate = self
        print(textView.contentSize)
        self.addSubview(textView)
        
        btn.frame.origin.x = textView.bounds.maxX
        btn.center.y = textView.center.y
        
        let a = ATrickyView()
        a.delegate = self
        textView.inputAccessoryView = a
        textView.sendSubviewToBack(a)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAlign() {
        
        UIView.animateWithDuration(0.2) { () -> Void in
            // first, get the offset that you are going to animate
            // this is the change of the self.frame.height size
            let offset = self.frame.size.height - (self.currentTextViewContentHeight + 8)
            // expand the size of the frame
            self.frame.size.height = self.currentTextViewContentHeight + 8
            // move frame position
            self.frame.origin.y += offset
            // move the btn y postion
            self.btn.center.y = self.frame.height - self.initialBarHeight / 2
            // expand the textview size
            self.textView.frame.size.height = self.currentTextViewContentHeight
            // move it
            self.textView.center.y = self.bounds.midY
        }
        
        if let a = textView.inputAccessoryView as? ATrickyView {
            // tell keyboard that this bar height has changed
            a.barHeight = self.currentMessageBarHeight
        }
    }
    
}

extension TextInputView : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        if textView.contentSize.height >= self.currentTextViewContentHeight {
            self.currentTextViewContentHeight = textView.contentSize.height
        } else {
            // smaller size
            self.currentTextViewContentHeight = textView.contentSize.height
        }
    }
}

protocol TextInputViewDelegate {
    func textInputView(didUpdateKeyboardFrame kbRect: CGRect?, textInputView :TextInputView)
    func textInputView(didUpdateFrame textInputView: TextInputView)
}

extension TextInputView : ATrickyViewDelegate {
    func aTrickyViewDelegate(currentKeyboardRect keyboardRect: CGRect?) {
        delegate?.textInputView(didUpdateKeyboardFrame: keyboardRect, textInputView: self)
    }
}
