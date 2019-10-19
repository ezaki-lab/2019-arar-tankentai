//
//  ShowableView.swift
//  arar-tankentai
//
//  Created by kaichan on 10/13/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit

class ShowableView: UIView {
    
    var isShowing: Bool!
    var ANIMATION_DURATION: TimeInterval = 0.5
    
    func showFade(delay: TimeInterval = 0.0, isAnimated: Bool = true) {
        if self.isShowing != nil && self.isShowing == true {
            print("This view has already showed")
            return
        }
        self.isShowing = true
        
        if isAnimated {
            self.isHidden = false
            UIView.animate(withDuration: ANIMATION_DURATION, delay: delay, options: [.curveEaseOut], animations: {
                self.alpha = 1.0
            }, completion: nil)
        }
        else {
            self.alpha = 1.0
            self.isHidden = false
        }
    }
    
    func hideFade(delay: TimeInterval = 0.0, isAnimated: Bool = true) {
        if self.isShowing != nil && self.isShowing == false {
            print("This view has already hidden")
            return
        }
        self.isShowing = false
        
        if isAnimated {
            UIView.animate(withDuration: ANIMATION_DURATION, delay: delay, options: [.curveEaseIn], animations: {
                self.alpha = 0.0
            }) { _ in
                self.isHidden = true
            }
        }
        else {
            self.alpha = 0.0
            self.isHidden = true
        }
    }
    
    func showUp(delay: TimeInterval = 0.0, isAnimated: Bool = true) {
        if self.isShowing != nil && self.isShowing == true {
            print("This view has already showed")
            return
        }
        self.isShowing = true
        
        if isAnimated {
            self.isHidden = false
            UIView.animate(withDuration: ANIMATION_DURATION, delay: delay, options: [.curveEaseOut], animations: {
                self.center.y -= self.frame.size.height
            }, completion: nil)
        }
        else {
            self.center.y -= self.frame.size.height
            self.isHidden = false
        }
    }
    
    func hideDown(delay: TimeInterval = 0.0, isAnimated: Bool = true) {
        if self.isShowing != nil && self.isShowing == false {
            print("This view has already hidden")
            return
        }
        self.isShowing = false
        
        if isAnimated {
            UIView.animate(withDuration: ANIMATION_DURATION, delay: delay, options: [.curveEaseIn], animations: {
                self.center.y += self.frame.size.height
            }) { _ in
                self.isHidden = true
            }
        }
        else {
            self.center.y += self.frame.size.height
            self.isHidden = true
        }
    }
    
    func showPop(delay: TimeInterval = 0.0, isAnimated: Bool = true) {
        if self.isShowing != nil && self.isShowing == true {
            print("This view has already showed")
            return
        }
        self.isShowing = true
        
        if isAnimated {
            self.alpha = 0.0
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.isHidden = false
            UIView.animate(withDuration: 0.15, delay: delay, options: [.curveEaseIn, .curveEaseOut], animations: {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.alpha = 1.0
            }) { _ in
                UIView.animate(withDuration: 0.05, delay: 0, options: [.curveEaseIn, .curveEaseOut], animations: {
                    self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
        else {
            self.isHidden = false
        }
    }
    
    func hidePop(delay: TimeInterval = 0.0, isAnimated: Bool = true) {
        if self.isShowing != nil && self.isShowing == false {
            print("This view has already hidden")
            return
        }
        self.isShowing = false
        
        if isAnimated {
            UIView.animate(withDuration: 0.1, delay: delay, options: [.curveEaseIn, .curveEaseOut], animations: {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseIn, .curveEaseOut], animations: {
                    self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    self.alpha = 0.0
                }) { _ in
                    self.isHidden = true
                }
            }
        }
        else {
            self.isHidden = true
        }
    }
}
