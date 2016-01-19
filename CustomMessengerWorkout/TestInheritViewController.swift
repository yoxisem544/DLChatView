//
//  TestInheritViewController.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/19.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class TestInheritViewController: DLMessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
