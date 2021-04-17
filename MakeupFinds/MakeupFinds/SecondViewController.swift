//
//  SecondViewController.swift
//  MakeupFinds
//
//  Created by Caitlin Selca
//  Source: Ray Wenderlich
//  Copyright © 2020 Caitlin Selca. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var favsButton: UIButton!
    @IBOutlet weak var favsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pulseButtonPressed(favsButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.favsLabel.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.6) {
                self.favsLabel.transform = CGAffineTransform.identity
            }
        })
    }
    
    @IBAction func pulseButtonPressed(_ sender: UIButton) {
        sender.pulsate(favsButton)
    }

}

