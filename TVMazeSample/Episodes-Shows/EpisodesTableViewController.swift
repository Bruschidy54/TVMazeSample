//
//  ShowsTableViewController.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 6/26/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

class EpisodesTableViewController: UITableViewController, SetTimeDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var totalEpisodes: [Episode] = []
    var timeFilteredEpisodes: [Episode] = []
    var searchFilteredEpisodes: [Episode] = []
    var searchActive = false
    var previousHeading = ""
    
    let searchingMessage = "Searching Shows"
    let cellId = "episodeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        
        queryEpisodes()
        
        tableView.reloadData()
        
    }
    
    func setTime(date: Date) {
        timeFilteredEpisodes = totalEpisodes.filter { $0.airInterval?.contains(date) == true }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let dateString = dateFormatter.string(from: date)
        
        navigationItem.title = "Playing at \(dateString)"
        
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableView.reloadData()
        
    }
    
    
    
    private func setupUI() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        navigationController?.navigationBar.addGestureRecognizer(tap)
        
        searchBar.barTintColor = .darkBlue
        searchBar.placeholder = "Search for a show or channel"
        
        view.backgroundColor = .darkBlue
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160
        tableView.separatorColor = .darkBlue
        
        navigationItem.title = "Now Playing"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Set Time", style: .plain, target: self, action: #selector(handleSetTimeTapped))
    }
    
    
    @objc private func handleSetTimeTapped() {
        searchBar.endEditing(true)
        searchBar.text = ""
        searchActive = false
        navigationItem.title = previousHeading
        tableView.reloadData()
        let setTimeViewController = SetTimeViewController()
        setTimeViewController.delegate = self
        setTimeViewController.modalPresentationStyle = .overCurrentContext
        present(setTimeViewController, animated: true, completion: nil)
    }
    
    
    
    private func queryEpisodes() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: Date())
        
        guard let url = URL(string: "http://api.tvmaze.com/schedule?country=US&date=\(dateString)") else { return }
        
        let session = URLSession(configuration: .default)
        let apiClient = APIClient(session: session)
        
        apiClient.get(url: url) { (data, error) in
            if let err = error {
                print("Error retrieving shows from TVMaze", err)
                let alertController = UIAlertController(title: "Error retrieving shows. Please try again later.", message: err.localizedDescription, preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true)
                return
            }
            
            guard let jsonData = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.totalEpisodes = try decoder.decode([Episode].self, from: jsonData)
                self.timeFilteredEpisodes = self.totalEpisodes.filter { $0.airInterval?.contains(Date()) == true }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let err {
                print("Error decoding episodes from JSON", err)
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let label = UILabel()
        if searchBar.text?.isEmpty == false {
            label.text = "No matching shows or channels..."
        } else {
            label.text = "No shows playing at this time..."
        }
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (timeFilteredEpisodes.count == 0 && !searchActive) || (searchFilteredEpisodes.count == 0 && searchActive) ? 150 : 0
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text?.isEmpty == false {
            return searchFilteredEpisodes.count
        } else {
            return timeFilteredEpisodes.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeTableViewCell
        
        if searchBar.text?.isEmpty == false {
            let episode = searchFilteredEpisodes[indexPath.row]
            cell.episode = episode
        } else {
            let episode = timeFilteredEpisodes[indexPath.row]
            cell.episode = episode
        }
        cell.selectionStyle = .none
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraints()
        cell.layoutIfNeeded()
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EpisodeTableViewCell
        performSegue(withIdentifier: "ShowDetailSegue", sender: cell)
    }
    
    
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            let showDetailController = segue.destination as! ShowDetailViewController
            if let episode = (sender as! EpisodeTableViewCell).episode {
                showDetailController.episode = episode
            }
            
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem 
        }
    }
    
}
