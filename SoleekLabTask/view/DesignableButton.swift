//
//  DesignableButton.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 5/24/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import UIKit


class DesignableButton: UIButton {
    
    @IBInspectable var radius: CGFloat = 0{
        didSet{
            layer.cornerRadius = radius
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTitleColor(UIColor.white, for: .application)
    }

}
