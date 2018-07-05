//
//  EpisodesTableViewController+UISearchBarDelegate.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 7/1/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

extension EpisodesTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchInactive = searchBar.text?.isEmpty ?? true
        
        searchFilteredEpisodes = totalEpisodes.filter({ (episode) -> Bool in
            let tmp: Episode = episode
            let name = tmp.show?.name ?? ""
            let network = tmp.show?.network?.name ?? ""
            let nameRange = (name as NSString).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let networkRange = (network as NSString).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return (nameRange.location != NSNotFound || networkRange.location != NSNotFound)
        })
        if searchFilteredEpisodes.count == 0 && !searchInactive {
            if let heading = navigationItem.title, heading != searchingMessage {
                previousHeading = heading
                navigationItem.title = searchingMessage
            }
        } else if searchFilteredEpisodes.count == 0 && searchInactive {
            navigationItem.title = previousHeading
        } else {
            if let heading = navigationItem.title, heading != searchingMessage {
                previousHeading = heading
                navigationItem.title = searchingMessage
            }
        }
        tableView.reloadData()
    }
}
