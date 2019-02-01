//
//  LoadingScreenView.swift
//  StarWarsApp
//
//  Created by Josue on 1/9/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit

class LoadingScreenView: UIView {

    var spinner = UIActivityIndicatorView()
    var loadingLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NS Coder init fatal error.")
    }

    /**
     Initialized and sets up all the required subviews.
     */
    private func setupView() {

        self.translatesAutoresizingMaskIntoConstraints = false

        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinner)
        spinner.style = .gray

        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loadingLabel)
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = R.string.localizable.loading_message()

        NSLayoutConstraint.activate([
            spinner.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            spinner.topAnchor.constraint(equalTo: self.topAnchor),
            spinner.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: spinner.trailingAnchor, constant: 5),
            loadingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loadingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            loadingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        showLoadingScreen()
    }

    /**
     Hides the loading screen
     */
    func hideLoadingScreen() {
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }

    /**
     Shows the loading screen
     */
    func showLoadingScreen() {
        spinner.startAnimating()
        spinner.isHidden = false
        loadingLabel.isHidden = false
    }

}
