//
//  DLMessagesViewController.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/14.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class DLMessagesViewController: UIViewController {
    
    var bubbleTableView: UITableView!
    var keyboardTextInputView: TextInputView!
    var kbHeight: CGFloat!
    
    struct Identifier {
        static let DLIncomingMessageBubbleIdentifier = "DLIncomingMessageBubble"
        static let DLOutgoingMessageBubbleIdentifier = "DLOutgoingMessageBubble"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        bubbleTableView = UITableView(frame: UIScreen.mainScreen().bounds)
        self.view.addSubview(bubbleTableView)
        bubbleTableView.registerNib(UINib(nibName: Identifier.DLIncomingMessageBubbleIdentifier, bundle: nil), forCellReuseIdentifier: Identifier.DLIncomingMessageBubbleIdentifier)
        bubbleTableView.registerNib(UINib(nibName: Identifier.DLOutgoingMessageBubbleIdentifier, bundle: nil), forCellReuseIdentifier: Identifier.DLOutgoingMessageBubbleIdentifier)
        
        bubbleTableView.delegate = self
        bubbleTableView.dataSource = self
        
        bubbleTableView.estimatedRowHeight = 197
        bubbleTableView.rowHeight = UITableViewAutomaticDimension
        
        bubbleTableView.keyboardDismissMode = .Interactive
        
        keyboardTextInputView = TextInputView()
        keyboardTextInputView.frame.origin.y = UIScreen.mainScreen().bounds.maxY - keyboardTextInputView.bounds.height
        keyboardTextInputView.delegate = self
        self.view.addSubview(keyboardTextInputView)
    }
}

extension DLMessagesViewController : TextInputViewDelegate {
    func textInputView(didUpdateKeyboardFrame kbRect: CGRect?, textInputView: TextInputView) {
        if let kbRect = kbRect {
            keyboardTextInputView.frame.origin.y = kbRect.origin.y - textInputView.frame.height
            kbHeight =  UIScreen.mainScreen().bounds.height - kbRect.origin.y
        }
    }
    func textInputView(didUpdateFrame textInputView: TextInputView) {
        
    }
    func textInputView(didClickedSendMessageButton message: String?) {
        print("message sent!")
        print(message)
    }
}

extension DLMessagesViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Identifier.DLIncomingMessageBubbleIdentifier, forIndexPath: indexPath) as! DLIncomingMessageBubble
//        let cell = tableView.dequeueReusableCellWithIdentifier(Identifier.DLOutgoingMessageBubbleIdentifier, forIndexPath: indexPath) as! DLOutgoingMessageBubble
        
        let s = ["BBC專訪11位候選", "jaksjkas", "a"]
        cell.textlabel.text = s[random()%3]
        let img = ["11.jpg", "60.jpg", "1.jpg"]
        cell.userImageView.image = UIImage(named: img[random()%3])
        
        return cell
    }
}
