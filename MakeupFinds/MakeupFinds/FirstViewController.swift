//
//  FirstViewController.swift
//  MakeupFinds
//
//  Created by Caitlin Selca
//  Source: Ray Wenderlich
//  Copyright © 2020 Caitlin Selca. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var GetStartedLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pulseButtonPressed(myButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.GetStartedLabel.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.6) {
                self.GetStartedLabel.transform = CGAffineTransform.identity
            }
        })
    }

    @IBAction func pulseButtonPressed(_ sender: UIButton) {
        sender.pulsate(myButton)
    }
    
}
