//
//  AutoLayout.swift
//  arar-tankentai
//
//  Created by kaichan on 10/13/19.
//  Copyright © 2019 Kaito Hattori. All rights reserved.
//

import UIKit

extension UIView {
    
    func autoLayout(to toView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: toView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: toView.rightAnchor).isActive = true
    }
}

func screenHeight() -> CGFloat {
    let screenSize = UIScreen.main.bounds
    return screenSize.height
}

func screenWidth() -> CGFloat {
    let screenSize = UIScreen.main.bounds
    return screenSize.width
}
