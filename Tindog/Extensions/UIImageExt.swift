//
//  UIImageExt.swift
//  Tindog
//
//  Created by Victor Aliaga on 2/7/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView{
    func round(){
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
    }
}
