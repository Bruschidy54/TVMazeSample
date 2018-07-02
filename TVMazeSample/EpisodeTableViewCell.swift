//
//  EpisodeTableViewCell.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 6/27/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    
    @IBOutlet var episodeImageView: CustomImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var networkLabel: UILabel!
    
    @IBOutlet var airtimeLabel: UILabel!
    @IBOutlet var catagoryLabel: UILabel!
    
    var episode: Episode? {
        didSet {
            
            guard let episode = episode else { return }
            
            displayInformation(for: episode)
            
            
        }
        
        
    }
    
    
    private func displayInformation(for episode: Episode) {
        
        let showName = episode.show?.name ?? ""
        let episodeName = episode.name ?? ""
        let attributedTitle = NSMutableAttributedString(string: "\(showName): ", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 17)])
        
        attributedTitle.append(NSAttributedString(string: "\(episodeName)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]))
        
        nameLabel.attributedText = attributedTitle
        
//        if let episodeImage = episode.image?.medium {
//            episodeImageView.loadImage(urlString: episodeImage)
//        } else
            if let showImage = episode.show?.image?.medium {
            episodeImageView.loadImage(urlString: showImage)
        }
        
        if let airInterval = episode.airInterval {
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "h:mma"
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
            
            let startTimeString = dateFormatter.string(from: airInterval.start)
            let endTimeString = dateFormatter.string(from: airInterval.end)
            
            
            airtimeLabel.text = "\(startTimeString) - \(endTimeString)"
        }
        
        let networkName = episode.show?.network?.name ?? ""
        networkLabel.text = networkName
        
        let genres = episode.show?.genres.joined(separator: ", ") ?? ""
        catagoryLabel.text = genres
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .lightBlue
        episodeImageView.contentMode = .scaleAspectFill
        episodeImageView.clipsToBounds = true
        episodeImageView.layer.cornerRadius = 7
    }

  

}
