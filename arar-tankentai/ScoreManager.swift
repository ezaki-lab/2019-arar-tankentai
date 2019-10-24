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
        let sa = Double(AVERAGE_ASKING_TIME - time) / 2.0
        var score = 0
        if sa > 0 {
            let sa_percent = sa / 10
            score = Int(DEFAULT_SCORE + DEFAULT_SCORE * sa_percent)
            if score > MAX_SCORE {
                score = MAX_SCORE
            }
        }
        else {
            let abs_sa = fabs(sa)
            let sa_percent = abs_sa / 10
            score = Int(DEFAULT_SCORE - DEFAULT_SCORE * sa_percent)
            if score < MIN_SCORE {
                score = MIN_SCORE
            }
        }
        self.score += score
    }
}
