//
//  EpisodesTableViewController+UISearchBarDelegate.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 7/1/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

extension EpisodesTableViewController: UISearchBarDelegate {
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
  
        if searchBar.text == "" {
            searchActive = false
        } else {
        searchActive = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        navigationItem.title = previousHeading
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        

        
        searchFilteredEpisodes = totalEpisodes.filter({ (episode) -> Bool in
            let tmp: Episode = episode
            let name = tmp.show?.name ?? ""
            let network = tmp.show?.network?.name ?? ""
            let nameRange = (name as NSString).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let networkRange = (network as NSString).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return (nameRange.location != NSNotFound || networkRange.location != NSNotFound)
        })
        if searchFilteredEpisodes.count == 0 && searchBar.text != "" {
            searchActive = true
            if let heading = navigationItem.title, heading != searchingMessage {
                previousHeading = heading
                navigationItem.title = searchingMessage
            }
        } else if searchFilteredEpisodes.count == 0 && searchBar.text == "" {
            searchActive = false
            navigationItem.title = previousHeading
        } else {
            searchActive = true
            if let heading = navigationItem.title, heading != searchingMessage {
                previousHeading = heading
                navigationItem.title = searchingMessage
            }
        }
        tableView.reloadData()
    }
}
