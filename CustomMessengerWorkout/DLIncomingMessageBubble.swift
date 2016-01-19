//
//  DLIncomingMessageBubble.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/19.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class DLIncomingMessageBubble: UITableViewCell {
    
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textlabel.layer.cornerRadius = 6.0
        textlabel.layer.borderColor = UIColor.grayColor().CGColor
        textlabel.layer.borderWidth = 1.0
//        textlabel.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        print(textlabel.frame)
        textlabel.font = UIFont.systemFontOfSize(18.0)
        
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2
        userImageView.clipsToBounds = true
        userImageView.contentMode = .ScaleAspectFill
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
