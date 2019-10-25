//
//  StartViewController.swift
//  arar-tankentai
//
//  Created by kaichan on 10/25/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var createrImageView: UIImageView!
    
    let createrImageList: [UIImage] = [
        UIImage(named: "creater-arisa")!,
        UIImage(named: "creater-hide")!,
        UIImage(named: "creater-kaito")!,
        UIImage(named: "creater-saeki")!,
        UIImage(named: "creater-ogino")!,
        UIImage(named: "creater-tsuyoshi")!
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        self.versionLabel.text = "  version: \(version)   build: \(build)  "
        
        self.createrImageView.layer.shadowColor = UIColor.black.cgColor
        self.createrImageView.layer.shadowOffset = .zero
        self.createrImageView.layer.shadowOpacity = 0.6
        self.createrImageView.layer.shadowRadius = 10
        
        self.createrImageView.alpha = 0
        self.createrImageView.image = self.randomCreaterImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.createrImageView.alpha = 1.0
        }, completion: nil)
    }
    
    func randomCreaterImage() -> UIImage {
        let randIndex = Int.random(in: 0 ... (self.createrImageList.count - 1))
        return self.createrImageList[randIndex]
    }
}
