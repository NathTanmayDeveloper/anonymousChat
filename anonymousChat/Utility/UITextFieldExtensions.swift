//
//  UITextFieldExtensions.swift
//  anonymousChat
//
//  Created by Tanmay Chandra Nath on 06/12/23.
//

import Foundation
import UIKit

extension UITextField {
    func addShakingAnimation(duration: Double, displacement: Int) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        animation.values = [displacement,-displacement,displacement,-displacement,displacement,0]
        animation.duration = duration
        animation.isAdditive = true
        
        self.layer.add(animation, forKey: "shakeAnimation")
    }
}
