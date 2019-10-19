//
//  GuideWayView.swift
//  arar-tankentai
//
//  Created by kaichan on 10/13/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit

class GuideWayView: ShowableView {
    
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    
    var guide: String = "" {
        didSet {
            self.guideLabel.text = self.guide
        }
    }
    
    var location: String = "" {
        didSet {
            self.guideLabel.text = "次は\(self.location)の近くにありそうだ..."
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
        let view = Bundle.main.loadNibNamed("GuideWayView", owner: self, options: nil)?.first as! UIView
        self.addSubview(view)
        view.autoLayout(to: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.bottomHeight.constant = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
}
