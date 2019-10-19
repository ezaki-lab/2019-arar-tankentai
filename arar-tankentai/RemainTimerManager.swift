//
//  RemainTimerManager.swift
//  arar-tankentai
//
//  Created by kaichan on 10/13/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import Foundation

protocol RemainTimerManagerDelegate: class {
    func remainTimerManager(_ remainTimerManager: RemainTimerManager, updateTimer remainTime: String)
    func remainTimerMangager(_ remainTimerManager: RemainTimerManager, finishTimer remainTime: String)
}

class RemainTimerManager {
    
    weak var delegate: RemainTimerManagerDelegate!
    
    var startTime: Date!
    var timer: Timer!
    var previousRemain: Int = -1
    
    func load() {
        self.startTime = Date()
    }
    
    func start() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stop() {
        if self.timer.isValid {
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    @objc func updateTimer() {
        
        let remain = self.remainTimeFromStart(start: self.startTime)
        if remain <= 0 {
            self.stop()
            if self.delegate != nil {
                self.delegate.remainTimerMangager(self, finishTimer: "00:00")
            }
        }
        
        if remain != self.previousRemain {
            self.previousRemain = remain
            let remainStr = self.convertTimeToString(remain: remain)
            if self.delegate != nil {
                self.delegate.remainTimerManager(self, updateTimer: remainStr)
            }
        }
    }
    
    func remainTimeFromStart(start: Date) -> Int {
        let elapsed = Date().timeIntervalSince(start)
        let duration = Int(elapsed)
        return GAME_OVER_TIME - duration
    }
    
    func convertTimeToString(remain: Int) -> String {
        let minute = Int(remain / 60)
        let second = Int(remain % 60)
        return "\(String(format: "%02d", minute)):\(String(format: "%02d", second))"
    }
    
}
