//
//  LogoAllGroups.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 22/08/21.
//

import UIKit

class LogoAllGroups: UIView {

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
