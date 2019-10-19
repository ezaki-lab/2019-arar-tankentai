//
//  GameOverViewController.swift
//  arar-tankentai
//
//  Created by kaichan on 10/14/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scoreView.layer.masksToBounds = false
        self.scoreView.layer.cornerRadius = self.scoreView.frame.size.width / 2
        
        self.scoreLabel.text = String(scoreManager.score)
    }
    
}
