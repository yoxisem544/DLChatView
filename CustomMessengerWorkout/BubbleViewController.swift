//
//  BubbleViewController.swift
//  CustomMessengerWorkout
//
//  Created by David on 2016/1/14.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class BubbleViewController: UIViewController {
    
    @IBOutlet weak var bubbleTableView: UITableView!
    var x: TextInputView!
    var kbHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bubbleTableView.delegate = self
        bubbleTableView.dataSource = self
        
        bubbleTableView.estimatedRowHeight = 197
        bubbleTableView.rowHeight = UITableViewAutomaticDimension
        
        bubbleTableView.keyboardDismissMode = .Interactive
        
        x = TextInputView()
        x.frame.origin.y = 100
        x.delegate = self
        self.view.addSubview(x)
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

extension BubbleViewController : TextInputViewDelegate {
    func textInputView(didUpdateKeyboardFrame kbRect: CGRect?, textInputView: TextInputView) {
        if let kbRect = kbRect {
            print(kbRect)
            x.frame.origin.y = kbRect.origin.y - textInputView.frame.height
            kbHeight =  UIScreen.mainScreen().bounds.height - kbRect.origin.y
            // need to check status bar height
            if UIApplication.sharedApplication().statusBarFrame.height == 40 {
//                x.frame.origin.y -= 20
            }
            print("=====uiscreen diff======")
            print(UIScreen.mainScreen().bounds)
        }
    }
    func textInputView(didUpdateFrame textInputView: TextInputView) {
        
    }
}

extension BubbleViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rid", forIndexPath: indexPath) as! BubbleLeftTableViewCell
        
        let s = ["BBC專訪11位候選人費文侯：僅4位水準之上其他都很爛 ...www.ettoday.net › 政治2014年11月20日 - 近日BBC針對這次九合一大選的11位候選人進行了專訪，其中朱立倫與陳菊並未受訪，BBC列出了5個問題請他們回答，而作家費文侯聽完他們的 ...BBC專訪6都候選人作家費文侯 - 自由時報電子報news.ltn.com.tw/news/politics/breakingnews/11615432014年11月19日 - BBC中文網針對6都市長民調前2名的候選人，台北市另外多加了馮光遠，做出一系列的專訪，總共有5個題目，時間限定2分鐘，作家費文侯聽完訪問 ...費文侯– 新公民議會newcongress.tw/?author=40費文侯作品精選. 要蔡英文解決問題，先給她夠多立委(2016-01-08) 團結老中青，教訓撕裂世代的國民黨(2016-01-04) 從王如玄的同理心，想想洪慈庸的 ...費文| Facebookhttps://zh-tw.facebook.com/Li.Ying.Nuan費文已經註冊了Facebook。加入Facebook 來聯絡費文及更多你可能認識的朋友。Facebook 讓人們盡情分享，將這個世界變得更開闊、聯繫更", "jaksjkas", "a"]
        cell.incomingtv.text = s[random()%3]
        
        return cell
    }
}
