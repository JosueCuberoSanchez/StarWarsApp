//
//  SpecieViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension SpecieViewController {

    // swiftlint:disable:next function_body_length
    override func loadView() {
        super.loadView()

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(scrollView)

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        backgroundImageView.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.clipsToBounds = true
        scrollView.addSubview(backgroundImageView)
        scrollView.sendSubviewToBack(backgroundImageView)

        let specieImageView = UIImageView(image: R.image.detailRebelAlliance())
        specieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(specieImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setTypography(.label)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)

        classificationLabel.translatesAutoresizingMaskIntoConstraints = false
        classificationLabel.setTypography(.label)
        classificationLabel.textAlignment = .center
        contentView.addSubview(classificationLabel)

        averageHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        averageHeightLabel.setTypography(.label)
        averageHeightLabel.textAlignment = .center
        contentView.addSubview(averageHeightLabel)

        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.setTypography(.label)
        languageLabel.textAlignment = .center
        contentView.addSubview(languageLabel)

        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        homeworldLabel.setTypography(.label)
        homeworldLabel.textAlignment = .center
        contentView.addSubview(homeworldLabel)

        specieImageViewTopAnchorConstraint =
            specieImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor)

        updateDynamicViewConstraints()

        NSLayoutConstraint.activate([
            // Scroll view
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // Content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            // Background image view
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            // Detail image view
            specieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            specieImageViewTopAnchorConstraint,
            // Labels
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: specieImageView.bottomAnchor, constant: 50),

            classificationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            classificationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            classificationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),

            averageHeightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            averageHeightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            averageHeightLabel.topAnchor.constraint(equalTo: classificationLabel.bottomAnchor, constant: 32),

            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            languageLabel.topAnchor.constraint(equalTo: averageHeightLabel.bottomAnchor, constant: 32),

            homeworldLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            homeworldLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            homeworldLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 32),
            contentView.bottomAnchor.constraint(equalTo: homeworldLabel.bottomAnchor, constant: 50)
        ])

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateDynamicViewConstraints()
    }

    func updateDynamicViewConstraints() {
        if UIDevice.current.orientation.isLandscape {
            specieImageViewTopAnchorConstraint.constant = 145
        } else {
            specieImageViewTopAnchorConstraint.constant = 30
        }
    }
}
