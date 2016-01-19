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
    
    var sendMessageButton: UIButton!
    var messageTextView: UITextView!
    let messageTextViewPlaceholder: String = "來點訊息吧..."
    var currentMessageTextViewContentHeight: CGFloat! = 38.0 {
        didSet {
            if currentMessageTextViewContentHeight <= maxMessgeBarHeight {
                currentMessageBarHeight = currentMessageTextViewContentHeight + 8
                // update the view
                updateAlign()
                // tell the delegate that i am updating
                delegate?.textInputView(didUpdateFrame: self)
            }
            print("current message bar h")
            print(currentMessageBarHeight)
        }
    }
    let initialMessageTextViewHeight: CGFloat = 38.0
    var currentMessageBarHeight: CGFloat = 44.0
    let initialBarHeight: CGFloat = 44.0
    var maxMessgeBarHeight: CGFloat = 120.0
    var minMessageBarHeight: CGFloat = 44.0
    
    var delegate: TextInputViewDelegate?
    
    convenience init() {
        self.init(frame: CGRectZero)
        self.frame = UIScreen.mainScreen().bounds
        self.frame.size.height = 44
        self.backgroundColor = UIColor.whiteColor()
        
        sendMessageButton = UIButton(type: UIButtonType.System)
        sendMessageButton.frame = CGRectMake(0, 0, 30, 30)
        sendMessageButton.setTitle("HI", forState: UIControlState.Normal)
        sendMessageButton.titleLabel?.font = UIFont.systemFontOfSize(18)
//        sendMessageButton.backgroundColor = UIColor.grayColor()
        sendMessageButton.addTarget(self, action: "sendMessageButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(sendMessageButton)
        
        messageTextView = UITextView(frame: self.frame)
        let leftInset: CGFloat = 8
        messageTextView.frame.size.width -= leftInset
        messageTextView.frame.origin.x += leftInset
        messageTextView.frame.size.width -= 30
        messageTextView.frame.size.height = 38
        messageTextView.center.y = self.bounds.midY
        messageTextView.textAlignment = .Natural
        messageTextView.bounces = false
        print(messageTextView.contentSize)
        print(messageTextView.frame)
        messageTextView.backgroundColor = UIColor.clearColor()
//        messageTextView.layer.borderWidth = 2.0
//        messageTextView.layer.borderColor = UIColor.blackColor().CGColor
        messageTextView.font = UIFont.systemFontOfSize(16)
        messageTextView.delegate = self
        print(messageTextView.contentSize)
        messageTextView.textColor = UIColor.lightGrayColor()
        messageTextView.text = messageTextViewPlaceholder
//        messageTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
//        messageTextView.layer.borderWidth = 1.0
        self.addSubview(messageTextView)
        
        sendMessageButton.frame.origin.x = messageTextView.bounds.maxX
        sendMessageButton.center.y = messageTextView.center.y
        
        let a = ATrickyView()
        a.delegate = self
        messageTextView.inputAccessoryView = a
        messageTextView.sendSubviewToBack(a)
        
        // make self view has a orange bar on top of it
        let orangeBarView = UIView(frame: UIScreen.mainScreen().bounds)
        orangeBarView.frame.size.height = 1
        orangeBarView.backgroundColor = UIColor.orangeColor()
        self.addSubview(orangeBarView)
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
            let offset = self.frame.size.height - (self.currentMessageTextViewContentHeight + 8)
            // expand the size of the frame
            self.frame.size.height = self.currentMessageTextViewContentHeight + 8
            // move frame position
            self.frame.origin.y += offset
            // move the sendMessageButton y postion
            self.sendMessageButton.center.y = self.frame.height - self.initialBarHeight / 2
            // expand the messageTextview size
            self.messageTextView.frame.size.height = self.currentMessageTextViewContentHeight
            // move it
            self.messageTextView.center.y = self.bounds.midY
        }
        
        if let a = messageTextView.inputAccessoryView as? ATrickyView {
            // tell keyboard that this bar height has changed
            a.barHeight = self.currentMessageBarHeight
        }
    }
    
    func sendMessageButtonClicked() {
        delegate?.textInputView(didClickedSendMessageButton: self.messageTextView.text)
        self.messageTextView.text = ""
        self.currentMessageTextViewContentHeight = initialMessageTextViewHeight
    }
    
    func hideSendMessageButton() {
        
        let t1 = CGAffineTransformMakeScale(0.1, 1)
        let t2 = CGAffineTransformMakeTranslation(self.sendMessageButton.bounds.midX, 0)
        let trans = CGAffineTransformConcat(t1, t2)

        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
            self.sendMessageButton.transform = trans
            self.messageTextView.frame.size.width = UIScreen.mainScreen().bounds.width
            }) { (finished) -> Void in
                if finished {
                    self.sendMessageButton.hidden = true
                    
                }
        }
    }
    
    func showSendMessageButton() {
        self.sendMessageButton.hidden = false
        UIView.animateWithDuration(0.15, delay: 0, options: [], animations: { () -> Void in
//            self.sendMessageButton.transform = CGAffineTransformMakeScale(1, 1)
            self.sendMessageButton.transform = CGAffineTransformIdentity
            self.messageTextView.frame.size.width = UIScreen.mainScreen().bounds.width - self.sendMessageButton.frame.width
            }, completion: nil)
    }
}

extension TextInputView : UITextViewDelegate {
    func textViewDidChange(messageTextView: UITextView) {
        if messageTextView.contentSize.height >= self.currentMessageTextViewContentHeight {
            self.currentMessageTextViewContentHeight = messageTextView.contentSize.height
        } else {
            // smaller size
            self.currentMessageTextViewContentHeight = messageTextView.contentSize.height
        }
        // detect text change
        if messageTextView.text.isEmpty {
            hideSendMessageButton()
        } else {
            showSendMessageButton()
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.textColor = UIColor.blackColor()
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = messageTextViewPlaceholder
            textView.textColor = UIColor.lightGrayColor()
        }
    }
}

protocol TextInputViewDelegate {
    func textInputView(didUpdateKeyboardFrame kbRect: CGRect?, textInputView :TextInputView)
    func textInputView(didUpdateFrame textInputView: TextInputView)
    func textInputView(didClickedSendMessageButton message: String?)
}

extension TextInputView : ATrickyViewDelegate {
    func aTrickyViewDelegate(currentKeyboardRect keyboardRect: CGRect?) {
        delegate?.textInputView(didUpdateKeyboardFrame: keyboardRect, textInputView: self)
    }
}
