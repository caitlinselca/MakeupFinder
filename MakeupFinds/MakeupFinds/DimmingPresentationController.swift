//
//  DimmingPresentationController.swift
//  MakeupFinds
//
//  Created by Caitlin Selca
//  Source: Ray Wenderlich
//  Copyright © 2020 Caitlin Selca. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
  override var shouldRemovePresentersView: Bool {
return false
} }

extension DetailViewController:
          UIViewControllerTransitioningDelegate {
  func presentationController(
     forPresented presented: UIViewController,
     presenting: UIViewController?, source: UIViewController) ->
     UIPresentationController? {
    return DimmingPresentationController(
             presentedViewController: presented, presenting: presenting)
} }
