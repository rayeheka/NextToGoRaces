//
//  NextToGoRacesView.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

class NextToGoRacesView: UIView {
    var races: [RaceSummaryViewModel] = []
    
    private lazy var racesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RacesTableViewCell.self)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(racesTableView)
        NSLayoutConstraint.activate([
            racesTableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            racesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            racesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            racesTableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func setRaces(_ races: [RaceSummaryViewModel]) {
        self.races = races
        racesTableView.reloadData()
    }
}

extension NextToGoRacesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return races.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RacesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fillData(raceSummary: races[indexPath.row])
        return cell
    }
}
