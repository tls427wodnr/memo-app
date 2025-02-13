//
//  MainView.swift
//  memo-app
//
//  Created by tlswo on 2/13/25.
//

import UIKit

class MainView: UIView {
    
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func updateBackgroundView(isEmpty: Bool) {
        if isEmpty {
            let textLabel = UILabel()
            textLabel.text = "No memo..."
            textLabel.textAlignment = .center
            textLabel.sizeToFit()
            tableView.backgroundView = textLabel
        } else {
            tableView.backgroundView = nil
        }
    }

}
