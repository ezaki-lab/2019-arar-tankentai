//
//  AlertView.swift
//  arar-tankentai
//
//  Created by kaichan on 10/16/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit

class AlertView: ShowableView {
    
    @IBOutlet weak var mainView: ShowableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var containButtonView: ShowableView!
    
    var title: String = "" {
        didSet {
            self.titleLabel.text = self.title
        }
    }
    
    var message: String = "" {
        didSet {
            self.descriptionLabel.text = self.message
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
        let view = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)?.first as! UIView
        self.addSubview(view)
        view.autoLayout(to: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.mainView.layer.masksToBounds = false
        self.mainView.layer.cornerRadius = 10
        self.mainView.layer.borderWidth = 1.0
        self.mainView.layer.borderColor = UIColor.white.cgColor
        self.mainView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0)
        self.descriptionLabel.layer.masksToBounds = false
        self.descriptionLabel.layer.cornerRadius = 10
        self.descriptionLabel.layer.borderWidth = 1.0
        self.descriptionLabel.layer.borderColor = UIColor.white.cgColor
        self.okButton.layer.masksToBounds = false
        self.okButton.layer.cornerRadius = 10
        self.okButton.layer.borderWidth = 1.0
        self.okButton.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func show(title: String, message: String) {
        self.title = title
        self.message = message
        self.showFade(isAnimated: false)
        self.mainView.showPop()
        self.containButtonView.showPop(delay: 0.1)
    }
    
    func hide(isAnimated: Bool = true) {
        self.mainView.hidePop(isAnimated: isAnimated)
        self.containButtonView.hidePop(delay: 0.1, isAnimated: isAnimated)
        self.hideFade(delay: 1.0, isAnimated: true)
    }
    
    @IBAction func clickedOk(_ sender: Any) {
        self.hide(isAnimated: true)
    }
}
