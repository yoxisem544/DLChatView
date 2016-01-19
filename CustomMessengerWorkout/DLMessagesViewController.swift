//
//  DLMessagesViewController.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/14.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

struct DLMessageControllerIdentifier {
    static let DLIncomingMessageBubbleIdentifier = "DLIncomingMessageBubble"
    static let DLOutgoingMessageBubbleIdentifier = "DLOutgoingMessageBubble"
}

protocol DLMessagesViewControllerDelegate {
    func DLMessagesViewControllerDidClickedMessageButton(withReturnMessage message: String?)
}

class DLMessagesViewController: UIViewController {
    
    var bubbleTableView: UITableView!
    var keyboardTextInputView: TextInputView!
    var kbHeight: CGFloat! = 0.0
    
    var delegate: DLMessagesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        bubbleTableView = UITableView(frame: UIScreen.mainScreen().bounds)
        self.view.addSubview(bubbleTableView)
        bubbleTableView.registerNib(UINib(nibName: DLMessageControllerIdentifier.DLIncomingMessageBubbleIdentifier, bundle: nil), forCellReuseIdentifier: DLMessageControllerIdentifier.DLIncomingMessageBubbleIdentifier)
        bubbleTableView.registerNib(UINib(nibName: DLMessageControllerIdentifier.DLOutgoingMessageBubbleIdentifier, bundle: nil), forCellReuseIdentifier: DLMessageControllerIdentifier.DLOutgoingMessageBubbleIdentifier)
        
        bubbleTableView.delegate = self
        bubbleTableView.dataSource = self
        
        bubbleTableView.estimatedRowHeight = 197
        bubbleTableView.rowHeight = UITableViewAutomaticDimension
        
        bubbleTableView.keyboardDismissMode = .Interactive
        
        bubbleTableView.separatorStyle = .None
        
        keyboardTextInputView = TextInputView()
        keyboardTextInputView.frame.origin.y = UIScreen.mainScreen().bounds.maxY - keyboardTextInputView.bounds.height
        keyboardTextInputView.delegate = self
        self.view.addSubview(keyboardTextInputView)
    }
    
    func scrollToButtom(animated animated: Bool) {
        let numbers = bubbleTableView.numberOfRowsInSection(0)
        let indexPath = NSIndexPath(forRow: numbers - 1, inSection: 0)
        bubbleTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
        print(bubbleTableView.contentSize.height)
        logContentSize()
    }
    
    func finishSentMessage() {
        let number = bubbleTableView.numberOfRowsInSection(0) - 1
        let indexPath = NSIndexPath(forRow: number, inSection: 0)
//        print(bubbleTableView.contentSize.height)
//        print(bubbleTableView.contentSize)
        bubbleTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func logContentSize() {
        print("======fuck=======")
        print(bubbleTableView.contentSize)
        print("======fuck=======")
    }
    func actualContentSize() -> CGSize {
        bubbleTableView.layoutIfNeeded()
        return bubbleTableView.contentSize
    }
}

extension DLMessagesViewController : TextInputViewDelegate {
    func textInputView(didUpdateKeyboardFrame kbRect: CGRect?, textInputView: TextInputView) {
        if let kbRect = kbRect {
            keyboardTextInputView.frame.origin.y = kbRect.origin.y - textInputView.frame.height
            kbHeight =  UIScreen.mainScreen().bounds.height - kbRect.origin.y
            // adjust inset
            let bottomInset = UIScreen.mainScreen().bounds.height - keyboardTextInputView.frame.origin.y
            bubbleTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
            scrollToButtom(animated: false)
        }
    }
    func textInputView(didUpdateFrame textInputView: TextInputView) {
        
    }
    func textInputView(didClickedSendMessageButton message: String?) {
        delegate?.DLMessagesViewControllerDidClickedMessageButton(withReturnMessage: message)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(DLMessageControllerIdentifier.DLIncomingMessageBubbleIdentifier, forIndexPath: indexPath) as! DLIncomingMessageBubble
        //        let cell = tableView.dequeueReusableCellWithIdentifier(DLMessageControllerIdentifier.DLOutgoingMessageBubbleIdentifier, forIndexPath: indexPath) as! DLOutgoingMessageBubble
        
        //        let s = ["幹你媽的回去當心北市長啦", "不要擔心他1/16就回來當了","選後新民意既已讓民進黨全面執政，可提早進場一展執政抱負卻一再牽拖，民進黨真的做好執政準備了嗎？", "jaksjkas", "a"]
        //        cell.textlabel.text = s[random()%3]
        //        let img = ["11.jpg", "60.jpg", "1.jpg"]
        //        cell.userImageView.image = UIImage(named: img[random()%3])
        
        return cell
    }
    

}
