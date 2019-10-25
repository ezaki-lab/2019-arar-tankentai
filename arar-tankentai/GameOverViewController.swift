//
//  GameOverViewController.swift
//  arar-tankentai
//
//  Created by kaichan on 10/14/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit
import SCLAlertView

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var backHomeKeyButton1: UIButton!
    @IBOutlet weak var backHomeKeyButton2: UIButton!
    @IBOutlet weak var backHomeKeyButton3: UIButton!
    @IBOutlet weak var backHomeKeyButton4: UIButton!
    var backHomeKey: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scoreView.layer.masksToBounds = false
        self.scoreView.layer.cornerRadius = self.scoreView.frame.size.width / 2
        
        self.scoreLabel.text = String(scoreManager.score)
    }
    
    @IBAction func clickedBackHomeKeyButton1(_ sender: Any) {
        if self.backHomeKey == 0 {
            self.backHomeKey = 1
        }
    }
    
    @IBAction func clickedBackHomeKeyButton2(_ sender: Any) {
        if self.backHomeKey == 1 {
            self.backHomeKey = 2
        }
    }
    
    @IBAction func clickedBackHomeKeyButton3(_ sender: Any) {
        if self.backHomeKey == 2 {
            self.backHomeKey = 3
        }
    }
    
    @IBAction func clickedBackHomeKeyButton4(_ sender: Any) {
        if self.backHomeKey == 3 {
            self.backHomeKey = 0
            
            let alert = SCLAlertView()
            let txt = alert.addTextField("Enter password")
            alert.addButton("Done") {
                if txt.text == "hattori" || txt.text == "Hattori" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    }
                }
                else {
                    let eAlert = SCLAlertView()
                    eAlert.showError("エラー", subTitle: "パスワードが間違っています。")
                }
            }
            alert.showEdit("運営アラート", subTitle: "パスワードを入力してください。\nユーザーは「キャンセル」を押してください。", closeButtonTitle: "キャンセル")
        }
    }
    
}
