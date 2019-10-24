//
//  QuestManager.swift
//  arar-tankentai
//
//  Created by kaichan on 10/14/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import Foundation

let questManager = QuestManager()

class Quest {
    var location: String = ""           // ポスターの場所
    var question: String = ""           // 問題
    var answer: String = ""             // 答え
    var answerCandidates: [String] = [] // 選択肢
    var answerDescription: String = ""  // 正解の説明
    var fileName: String = ""           // ファイルの名前
    
    init(location: String, question: String, answer: String, answerCandidates: [String], answerDescription: String, fileName: String) {
        self.location = location
        self.question = question
        self.answer = answer
        self.answerCandidates = answerCandidates
        self.answerDescription = answerDescription
        self.fileName = fileName
    }
}

class QuestManager {
    
    var questList: [Quest] = []
    var pastQuestIndexList: [Int] = []
    var startTime: Date!
    
    init() {
        self.loadJson(fileName: "quests")
    }
    
    func loadJson(fileName: String) {
        do {
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let _ = json as? [String: Any] {
                    // json is a dictionary
                } else if let quests = json as? [Any] {
                    // json is an array
                    
                    for quest in quests {
                        guard let q = quest as? [String: Any] else {
                            return
                        }
                        
                        let location = q["location"] as? String ?? ""
                        let question = q["question"] as? String ?? ""
                        let answer = q["answer"] as? String ?? ""
                        let answerCandidates = q["answerCandidates"] as? [String] ?? []
                        let answerDescription = q["answerDescription"] as? String ?? ""
                        let fileName = q["fileName"] as? String ?? ""
                        
                        self.questList.append(Quest(
                            location: location,
                            question: question,
                            answer: answer,
                            answerCandidates: answerCandidates,
                            answerDescription: answerDescription,
                            fileName: fileName
                        ))
                    }
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func generate() -> Quest? {
        if self.questList.count == self.pastQuestIndexList.count {
            self.pastQuestIndexList = []
            print("pastQuestIndexList was reset")
        }
        
        var randIndex = 0
        repeat {
            randIndex = Int.random(in: 0 ... (self.questList.count - 1))
        } while self.pastQuestIndexList.contains(randIndex)
        self.pastQuestIndexList.append(randIndex)
        return self.questList[randIndex]
    }
    
    
    func startAsking() {
        self.startTime = Date()
    }
    
    func endAsking() -> Int {
        if self.startTime == nil {
            return 100000
        }
        
        let elapsed = Date().timeIntervalSince(self.startTime)
        self.startTime = nil
        let duration = Int(elapsed)
        return duration
    }
}
