//
//  ScoreManager.swift
//  arar-tankentai
//
//  Created by kaichan on 10/15/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import Foundation

let scoreManager = ScoreManager()

class ScoreManager {
    
    var score: Int = 0
    
    func add(askingTime time: Int) {
        self.score += 1
    }
}
