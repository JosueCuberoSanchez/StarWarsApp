//
//  LoadingScreenView.swift
//  StarWarsApp
//
//  Created by Josue on 1/9/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit

class LoadingScreenView: UIView {

    private let spinner = UIActivityIndicatorView()
    private let loadingLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NS Coder init fatal error.")
    }

    private func setupView() {

        translatesAutoresizingMaskIntoConstraints = false

        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        spinner.style = .gray

        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingLabel)
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = R.string.localizable.loading_message()

        NSLayoutConstraint.activate([
            spinner.leadingAnchor.constraint(equalTo: leadingAnchor),
            spinner.topAnchor.constraint(equalTo: topAnchor),
            spinner.bottomAnchor.constraint(equalTo: bottomAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: spinner.trailingAnchor, constant: 5),
            loadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingLabel.topAnchor.constraint(equalTo: topAnchor),
            loadingLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        showLoadingScreen()
    }

    func hideLoadingScreen() {
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }

    func showLoadingScreen() {
        spinner.startAnimating()
        spinner.isHidden = false
        loadingLabel.isHidden = false
    }

}
