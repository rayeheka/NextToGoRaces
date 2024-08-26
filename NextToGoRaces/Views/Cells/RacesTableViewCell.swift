//
//  RacesTableViewCell.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

class RacesTableViewCell: UITableViewCell {
    //MARK: - Properties
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 6
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var raceNumberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .right
        label.textColor = .red
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupImageViewConstraints()
        setupStackViewConstraints()
        setupTimerLabel()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        raceNumberImageView.image = nil
        iconImageView.image = nil
        timerLabel.text = nil
    }
    
    func fillData(raceSummary: RaceSummaryViewModel) {
        titleLabel.text = raceSummary.meetingName
        raceNumberImageView.image = UIImage(systemName: "\(raceSummary.raceNumber).circle.fill")
        timerLabel.text = "\(Int(raceSummary.advertisedStart)) seconds"
        iconImageView.image = raceSummary.category.image
    }
    
    private func addSubViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titlesStackView)
        titlesStackView.addArrangedSubview(titleLabel)
        titlesStackView.addArrangedSubview(raceNumberImageView)
        contentView.addSubview(timerLabel)
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            titlesStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 4),
            titlesStackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            titlesStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titlesStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16)
        ])
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupTimerLabel() {
        contentView.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
}

