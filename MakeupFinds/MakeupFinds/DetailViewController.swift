//
//  DetailViewController.swift
//  Gamerly
//
//  Created by Caitlin Selca
//  Source: Ray Wenderlich
//  Copyright © 2020 Caitlin Selca. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                           action: #selector(close))
        gestureRecognizer.cancelsTouchesInView = false
//        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
          if searchResult != nil {
        updateUI() }

        // Do any additional setup after loading the view.
    }
    
    var searchResult: MakeupElement!
    var downloadTask: URLSessionDownloadTask?
    
    // MARK:- Actions
    @IBAction func close() {
        // Line 1. Create an instance of AVSpeechSynthesizer.
        let speechSynthesizer = AVSpeechSynthesizer()
        // Line 2. Create an instance of AVSpeechUtterance and pass in a String to be spoken.
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "Closing!")
        //Line 3. Specify the speech utterance rate. 1 = speaking extremely the higher the values the slower speech patterns. The default rate, AVSpeechUtteranceDefaultSpeechRate is 0.5
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        // Line 4. Specify the voice. It is explicitly set to English here, but it will use the device default if not specified.
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        // Line 5. Pass in the urrerance to the synthesizer to actually speak.
        speechSynthesizer.speak(speechUtterance)
      dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      modalPresentationStyle = .custom
      transitioningDelegate = self
    }
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
//    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK:- Helper Methods
    func updateUI() {
        nameLabel.text = searchResult.name
        brandLabel.text = searchResult.brand
        descriptionLabel.text = searchResult.makeupDescription
        // Get image
        if let largeURL = URL(string: searchResult.imageLink) {
          downloadTask = artworkImageView.loadImage(url: largeURL)
            priceLabel.text = "$" + (searchResult.price ?? "")
        }

}
    
    deinit {
      print("deinit \(self)")
      downloadTask?.cancel()
    }
}
