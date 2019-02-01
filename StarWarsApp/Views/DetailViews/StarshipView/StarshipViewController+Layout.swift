//
//  PersonViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension StarshipViewController {

    // swiftlint:disable:next function_body_length
    override func loadView() {
        super.loadView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        backgroundImageView.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.clipsToBounds = true
        scrollView.addSubview(backgroundImageView)
        scrollView.sendSubviewToBack(backgroundImageView)

        starshipImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(starshipImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setTypography(.label)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)

        manufacturerLabel.translatesAutoresizingMaskIntoConstraints = false
        manufacturerLabel.setTypography(.label)
        manufacturerLabel.textAlignment = .center
        manufacturerLabel.numberOfLines = 2
        contentView.addSubview(manufacturerLabel)

        lengthLabel.translatesAutoresizingMaskIntoConstraints = false
        lengthLabel.setTypography(.label)
        lengthLabel.textAlignment = .center
        contentView.addSubview(lengthLabel)

        passengersLabel.translatesAutoresizingMaskIntoConstraints = false
        passengersLabel.setTypography(.label)
        passengersLabel.textAlignment = .center
        contentView.addSubview(passengersLabel)

        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.setTypography(.label)
        classLabel.textAlignment = .center
        classLabel.numberOfLines = 2
        contentView.addSubview(classLabel)

        portraitImageViewTopAnchorConstraints = [
            starshipImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 145)
        ]
        landscapeImageViewTopAnchorConstraints = [
            starshipImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 50)
        ]

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
            // Background image
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            // Detail image
            starshipImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            // Labels
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: starshipImageView.bottomAnchor, constant: 50),

            manufacturerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            manufacturerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            manufacturerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),

            lengthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lengthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lengthLabel.topAnchor.constraint(equalTo: manufacturerLabel.bottomAnchor, constant: 32),

            passengersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passengersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            passengersLabel.topAnchor.constraint(equalTo: lengthLabel.bottomAnchor, constant: 32),

            classLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            classLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            classLabel.topAnchor.constraint(equalTo: passengersLabel.bottomAnchor, constant: 32),
            contentView.bottomAnchor.constraint(equalTo: classLabel.bottomAnchor, constant: 50)
        ])

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateDynamicViewConstraints()
    }

    /**
     Updates the dynamic views according to the current orientation.
     */
    func updateDynamicViewConstraints() {

        if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.activate(landscapeImageViewTopAnchorConstraints)
            NSLayoutConstraint.deactivate(portraitImageViewTopAnchorConstraints)
        } else {
            NSLayoutConstraint.activate(portraitImageViewTopAnchorConstraints)
            NSLayoutConstraint.deactivate(landscapeImageViewTopAnchorConstraints)
        }

    }
}
