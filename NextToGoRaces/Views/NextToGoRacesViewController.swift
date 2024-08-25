//
//  NextToGoRacesViewController.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit
import Combine

class NextToGoRacesViewController: UIViewController {
    weak var coordinator: CoordinatorProtocol?
       
    private let nextToGoRacesViewModel: NextToGoRacesViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private var nextToGoRacesView: NextToGoRacesView {
        return view as! NextToGoRacesView
    }
    
    init(nextToGoRacesViewModel: NextToGoRacesViewModel) {
        self.nextToGoRacesViewModel = nextToGoRacesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = NextToGoRacesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.title = "Next To Go Races"
        
        nextToGoRacesView.delegate = self
        
        bindViewModel()
        
        Task {
            await nextToGoRacesViewModel.getRaces()
        }
    }
    
    private func bindViewModel() {
        nextToGoRacesViewModel.$filteredRaces
            .receive(on: DispatchQueue.main)
            .sink { [weak self] races in
                self?.nextToGoRacesView.setRaces(races)
            }
            .store(in: &cancellables)
    }
}

extension NextToGoRacesViewController: NextToGoRacesViewDelegate {
    func filterSelected(category: RaceCategory, isSelected: Bool) {
        nextToGoRacesViewModel.filter(basedOn: category, isSelected: isSelected)
    }
}
