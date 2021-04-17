//
//  UIButtonExtension.swift
//  MakeupFinds
//
//  Created by Caitlin Selca
//  Source: Ray Wenderlich
//  Copyright © 2020 Caitlin Selca. All rights reserved.
//
//

import UIKit

extension UIButton {
    func pulsate(_:UIButton) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.88
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.7
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
