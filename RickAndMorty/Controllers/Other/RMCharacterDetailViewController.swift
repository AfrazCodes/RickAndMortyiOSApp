//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/24/22.
//

import UIKit

/// Controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {
    private let viewModel: RMCharacterDetailViewViewModel

    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

}
