//
//  ShowDetailViewController.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 7/1/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {
    
    var episode: Episode? {
        didSet {
            
            guard let episode = episode else { return }
            
            displayInformation(for: episode)
            
            
        }
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem?.title = "Back"
        view.backgroundColor = .darkBlue
        
    }
    
    private func displayInformation(for episode: Episode) {
        navigationItem.title = episode.show?.name ?? ""
    }


}
