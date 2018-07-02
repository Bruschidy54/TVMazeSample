//
//  SetTimeViewController.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 6/30/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

protocol SetTimeDelegate {
    func setTime(date: Date)
}

class SetTimeViewController: UIViewController {
    
    var delegate: SetTimeDelegate?
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.darkBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancelTapped), for: UIControlEvents.touchUpInside)
        return button
    }()

    let setTimeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        button.backgroundColor = .lightRed
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Set Time", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSetTimeTapped), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }
    
    private func setupUI() {
        view.backgroundColor = .lightBlue
        view.alpha = 0.95
        
        view.addSubview(datePicker)
        datePicker.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 275)
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(setTimeButton)
        setTimeButton.anchor(top: nil, left: view.leftAnchor, bottom: datePicker.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 8, paddingRight: 16, width: 0, height: 40)
        setTimeButton.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: datePicker.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 40)
        cancelButton.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        
        
    }
    
    @objc private func handleCancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSetTimeTapped() {
        
        let date = datePicker.date
        delegate?.setTime(date: date)
        self.dismiss(animated: true, completion: nil)
    }


}
