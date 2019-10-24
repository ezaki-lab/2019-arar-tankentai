//
//  ChoiseAnswerView.swift
//  arar-tankentai
//
//  Created by kaichan on 10/13/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit

protocol ChoiseAnswerViewDelegate: class {
    func choiseAnswerView(_ choiseAnswerView: ChoiseAnswerView, didSelectAnswerAt index: Int)
}

class ChoiseAnswerView: ShowableView {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton1: AnswerButton!
    @IBOutlet weak var answerButton2: AnswerButton!
    @IBOutlet weak var answerButton3: AnswerButton!
    @IBOutlet weak var answerButton4: AnswerButton!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    
    var delegate: ChoiseAnswerViewDelegate!
    
    var question: String = "Q." {
        didSet {
            self.questionLabel.text = "Q. \(self.question)"
        }
    }
    
    var answer1: String = "" {
        didSet {
            self.answerButton1.answer = self.answer1
        }
    }
    var answer2: String = "" {
        didSet {
            self.answerButton2.answer = self.answer2
        }
    }
    var answer3: String = "" {
        didSet {
            self.answerButton3.answer = self.answer3
        }
    }
    var answer4: String = "" {
        didSet {
            self.answerButton4.answer = self.answer4
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.loadNib()
    }
    
    private func loadNib(){
        let view = Bundle.main.loadNibNamed("ChoiseAnswerView", owner: self, options: nil)?.first as! UIView
        self.addSubview(view)
        view.autoLayout(to: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.bottomHeight.constant = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    @IBAction func clickedAnswer1(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.choiseAnswerView(self, didSelectAnswerAt: 0)
        }
    }
    
    @IBAction func clickedAnswer2(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.choiseAnswerView(self, didSelectAnswerAt: 1)
        }
    }
    
    @IBAction func clickedAnswer3(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.choiseAnswerView(self, didSelectAnswerAt: 2)
        }
    }
    
    @IBAction func clickedAnswer4(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.choiseAnswerView(self, didSelectAnswerAt: 3)
        }
    }
    
}
