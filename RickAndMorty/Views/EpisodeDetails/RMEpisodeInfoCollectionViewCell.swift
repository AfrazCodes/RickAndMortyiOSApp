//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/27/22.
//

import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setUpLayer()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(with viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
        
    }
}
