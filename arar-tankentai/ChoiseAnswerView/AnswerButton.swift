//
//  AnswerButton.swift
//  arar-tankentai
//
//  Created by kaichan on 10/13/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit

class AnswerButton: UIButton {
    
    var answer: String = "" {
        didSet {
            self.setTitle(self.answer, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(white: 0, alpha: 0.8)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
}
