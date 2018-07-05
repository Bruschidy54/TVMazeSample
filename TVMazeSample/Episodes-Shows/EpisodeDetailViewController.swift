//
//  ShowDetailViewController.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 7/1/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet var containerStackView: UIStackView!
    @IBOutlet var showView: UIView!
    @IBOutlet var showImageView: CustomImageView!
    @IBOutlet var showNameRatingLabel: UILabel!
    @IBOutlet var showNetworkLabel: UILabel!
    @IBOutlet var showGenresLabel: UILabel!
    @IBOutlet var showLanguageLabel: UILabel!
    @IBOutlet var showURLButton: UIButton!
    @IBOutlet var showDescriptionView: UITextView!
    
    @IBOutlet var episodeView: UIView!
    @IBOutlet var episodeImageView: CustomImageView!
    @IBOutlet var episodeAirtimeLabel: UILabel!
    @IBOutlet var episodeNameLabel: UILabel!
    @IBOutlet var episodeURLButton: UIButton!
    @IBOutlet var episodeDescriptionView: UITextView!
    @IBOutlet var episodeDescriptionHeightConstraint: NSLayoutConstraint!
    
    
    var episode: Episode?
    
    
    @IBAction func onShowURLButtonTapped(_ sender: Any) {
        guard let urlString = episode?.show?.url else { return }
        guard let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func onEpisodeURLButtonTapped(_ sender: Any) {
        
        guard let urlString = episode?.url else { return }
        guard let url = URL(string: urlString) else { return }
        
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        displayInformationForEpisode()
        
    }
    
    private func displayInformationForEpisode() {
        
        displayShowInformation()
        
        displayEpisodeInformation()
     
        containerStackView.layoutIfNeeded()
        }
    
    private func displayShowInformation() {
        guard let episode = episode else { return }
        
        navigationItem.title = episode.show?.name ?? ""
        
        if let showImage = episode.show?.image?.medium {
            showImageView.loadImage(urlString: showImage)
        }
        
        let showName = episode.show?.name ?? ""
        
        let attributedShowNameRating = NSMutableAttributedString(string: "\(showName)", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 17)])
        
        if let rating = episode.show?.rating?.average {
            attributedShowNameRating.append(NSAttributedString(string: " - \(rating)/10", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.strokeColor: UIColor.gray]))
        }
        
        showNameRatingLabel.attributedText = attributedShowNameRating
        
        let network = episode.show?.network?.name ?? ""
        showNetworkLabel.text = network
        
        let genres = episode.show?.genres.joined(separator: ", ") ?? ""
        showGenresLabel.text = genres
        
        if let language = episode.show?.language {
            showLanguageLabel.text = "Language: \(language)"
        } else {
            showLanguageLabel.isHidden = true
        }
        
        let url = episode.show?.url ?? ""
        showURLButton.setTitle(url, for: .normal)
        
        let showDescription = episode.show?.summary ?? ""
        showDescriptionView.text = showDescription
        
        showDescriptionView.sizeToFit()
    }
    
    private func displayEpisodeInformation() {
        guard let episode = episode else { return }
        if let episodeImage = episode.image?.medium {
            episodeImageView.loadImage(urlString: episodeImage)
        }
        
        let episodeName = episode.name ?? ""
        let episodeNameLabelString = NSMutableAttributedString(string: "", attributes: nil)
        
        if let seasonNumber = episode.season {
            episodeNameLabelString.append(NSAttributedString(string: "Season \(seasonNumber) ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)]))
        }
        
        if let episodeNumber = episode.number {
            episodeNameLabelString.append(NSAttributedString(string: "Episode \(episodeNumber): ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)]))
        }
        
        episodeNameLabelString.append(NSAttributedString(string: "\(episodeName)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.strokeColor: UIColor.gray]))
        
        episodeNameLabel.attributedText = episodeNameLabelString
        
        if let airInterval = episode.airInterval {
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "h:mma"
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
            
            let startTimeString = dateFormatter.string(from: airInterval.start)
            let endTimeString = dateFormatter.string(from: airInterval.end)
            
            
            episodeAirtimeLabel.text = "\(startTimeString) - \(endTimeString)"
        }
        
        let url = episode.url ?? ""
        episodeURLButton.setTitle(url, for: .normal)
        
        let episodeDescription = episode.summary ?? ""
        episodeDescriptionView.text = episodeDescription
        
        episodeDescriptionView.sizeToFit()

        if episodeDescription.isEmpty {
            episodeDescriptionHeightConstraint.constant = 0
        }
        
    }
    
    private func setupUI() {
        view.backgroundColor = .darkBlue
        showView.backgroundColor = .lightBlue
        episodeView.backgroundColor = .lightBlue
        showDescriptionView.backgroundColor = .lightBlue
        episodeDescriptionView.backgroundColor = .lightBlue
        
        showImageView.contentMode = .scaleAspectFill
        showImageView.clipsToBounds = true
        showImageView.layer.cornerRadius = 7
        
        episodeImageView.contentMode = .scaleAspectFill
        episodeImageView.clipsToBounds = true
        episodeImageView.layer.cornerRadius = 7
    }


}
