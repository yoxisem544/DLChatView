//
//  TestInheritViewController.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/19.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class TestInheritViewController: DLMessagesViewController {
    
    var messages: [DLMessageData]?
    var thisUserId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self

        // Do any additional setup after loading the view.
        messages = []
        for _ in 1...3 {
            let userId = random()%2
//            print(userId)
            let userImage = userId == 1 ? UIImage(named: "1.jpg") : nil
            let m = DLMessageData(userId: "\(userId)", userImage: userImage, message: "吃唧唧")
            messages?.append(m)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        scrollToButtom(animated: false)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages != nil {
            return messages!.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if messages![indexPath.row].userId == "\(thisUserId)" {
            let cell = tableView.dequeueReusableCellWithIdentifier(DLMessageControllerIdentifier.DLOutgoingMessageBubbleIdentifier) as! DLOutgoingMessageBubble
            cell.textlabel.text = messages![indexPath.row].message
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(DLMessageControllerIdentifier.DLIncomingMessageBubbleIdentifier) as! DLIncomingMessageBubble
            cell.textlabel.text = messages![indexPath.row].message
            cell.userImageView.image = messages![indexPath.row].userImage
            return cell
        }
    }
}

extension TestInheritViewController : DLMessagesViewControllerDelegate {
    func DLMessagesViewControllerDidClickedMessageButton(withReturnMessage message: String?) {
        print("message \(message) sent!")
        print("bubbleTableView.contentSize.height \(bubbleTableView.contentSize.height)")
        let userId = random()%2
        let img = userId == 1 ? UIImage(named: "1.jpg") : nil
        let message = DLMessageData(userId: "\(userId)", userImage: img, message: message)
        messages?.append(message)
        let indexPath = NSIndexPath(forRow: messages!.count - 1, inSection: 0)
        
        insertAndUpdateMessageView(atIndexPath: indexPath)
    }
}
