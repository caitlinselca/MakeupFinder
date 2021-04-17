//
//  SearchResultCell.swift
//  Gamerly
//
//  Created by Caitlin Selca
//  Source: Ray Wenderlich
//  Copyright © 2020 Caitlin Selca. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // New code below
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 220/255, green: 80/255, blue: 140/255, alpha: 1)
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      downloadTask?.cancel()
      downloadTask = nil
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    var downloadTask: URLSessionDownloadTask?
    
    func configure(for result: MakeupElement) {
        nameLabel.text = result.name
        artistNameLabel.text = result.brand
        artworkImageView.image = UIImage(named: "makeup.jpg")
        if let smallURL = URL(string: result.imageLink) {
          downloadTask = artworkImageView.loadImage(url: smallURL)
        }
    }

}
