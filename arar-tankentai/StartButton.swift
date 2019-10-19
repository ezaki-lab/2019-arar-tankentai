//
//  CustomButton.swift
//  arar-tankentai
//
//  Created by kaichan on 10/13/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit
import Foundation

class StartButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
    }
}
