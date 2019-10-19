//
//  StatusView.swift
//  arar-tankentai
//
//  Created by kaichan on 10/13/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit

class StatusView: UIView {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            self.statusLabel.font = UIFont.monospacedDigitSystemFont(ofSize: self.statusLabel.font.pointSize, weight: UIFont.Weight.regular)
        }
    }
    
    var title: String = "Title" {
        didSet {
            self.titleLabel.text = self.title
        }
    }
    
    var status: String = "" {
        didSet {
            self.statusLabel.text = self.status
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
        let view = Bundle.main.loadNibNamed("StatusView", owner: self, options: nil)?.first as! UIView
        self.addSubview(view)
        view.autoLayout(to: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.mainView.layer.masksToBounds = false
        self.mainView.layer.cornerRadius = 15
        self.mainView.layer.borderWidth = 1.0
        self.mainView.layer.borderColor = UIColor.darkGray.cgColor
    }
}
