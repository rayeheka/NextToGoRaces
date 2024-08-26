//
//  NextToGoRacesView.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

protocol NextToGoRacesViewDelegate: AnyObject {
    func filterSelected(category: RaceCategory, isSelected: Bool)
}

class NextToGoRacesView: UIView {
    //MARK: - Properties
    var races: [RaceSummaryViewModel] = []
    
    weak var delegate: NextToGoRacesViewDelegate?
    
    private lazy var filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: 70)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FilterCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
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
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    //MARK: - Methods
    func setRaces(_ races: [RaceSummaryViewModel]) {
        self.races = races
        racesTableView.reloadData()
    }
    
    private func setupSubviews() {
        backgroundColor = .white
        setupCollectionView()
        setupTableView()
    }
    
    private func setupCollectionView() {
        addSubview(filterCollectionView)
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupTableView() {
        addSubview(racesTableView)
        NSLayoutConstraint.activate([
            racesTableView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 16),
            racesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            racesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            racesTableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDelegate and UITableViewDataSource
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

//MARK: - UICollectionViewDelegate and UICollectionViewDataSource
extension NextToGoRacesView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RaceCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let category = RaceCategory.allCases[indexPath.row]
        cell.fillData(category: category)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterSelected(category: RaceCategory.allCases[indexPath.row], isSelected: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegate?.filterSelected(category: RaceCategory.allCases[indexPath.row], isSelected: false)
    }
}

