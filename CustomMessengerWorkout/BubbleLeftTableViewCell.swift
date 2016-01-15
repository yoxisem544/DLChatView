//
//  BubbleLeftTableViewCell.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/14.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class BubbleLeftTableViewCell: UITableViewCell {
    
    @IBOutlet weak var incomingtv: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        incomingtv.backgroundColor = UIColor(patternImage: UIImage(named: "11.jpg")!)
//        incomingtv.backgroundColor = UIColor.grayColor()
        incomingtv.layer.cornerRadius = 6.0
        incomingtv.layer.borderColor = UIColor.grayColor().CGColor
        incomingtv.layer.borderWidth = 1.0
        incomingtv.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        print(incomingtv.frame)
        incomingtv.font = UIFont.systemFontOfSize(18.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
