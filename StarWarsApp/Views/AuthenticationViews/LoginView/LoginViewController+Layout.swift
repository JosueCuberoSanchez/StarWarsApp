//
//  LoginViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/25/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {

    // swiftlint:disable:next function_body_length
    override func loadView() {
        super.loadView()

        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = R.image.darkSide()
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.alpha = 0.7
        view.addSubview(blurEffectView)

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16.0
        view.addSubview(stackView)

        let logoView = UIImageView(image: R.image.starWarsLogo())
        stackView.addArrangedSubview(logoView)

        let emailView = UIView()
        emailView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(emailView)
        
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.setTypography(.label)
        emailLabel.text = "Email"
        emailLabel.textAlignment = .left
        emailView.addSubview(emailLabel)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Enter email"
        emailTextField.autocapitalizationType = .none
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        emailTextField.borderStyle = .roundedRect
        emailView.addSubview(emailTextField)

        let passwordView = UIView()
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(passwordView)
        
        let passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.setTypography(.label)
        passwordLabel.text = "Password"
        passwordLabel.textAlignment = .left
        passwordView.addSubview(passwordLabel)

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        passwordTextField.borderStyle = .roundedRect
        passwordView.addSubview(passwordTextField)

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Log in", for: .normal)
        loginButton.titleLabel?.setTypography(.label)
        loginButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 10)
        loginButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        stackView.addArrangedSubview(loginButton)

        NSLayoutConstraint.activate([
            // Background image
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            // Blur effect
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            // Stack view
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Logo view
            logoView.leadingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: -100),
            logoView.trailingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: 100),
            logoView.heightAnchor.constraint(equalToConstant: 100),
            // Email view
            emailView.leadingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: -150),
            emailView.trailingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: 150),
            emailView.heightAnchor.constraint(equalToConstant: 70),
            emailTextField.widthAnchor.constraint(equalTo: emailView.widthAnchor),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            // Password view
            passwordView.leadingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: -150),
            passwordView.trailingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: 150),
            passwordView.heightAnchor.constraint(equalToConstant: 70),
            passwordTextField.widthAnchor.constraint(equalTo: passwordView.widthAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5)
        ])

    }

    func setErrorBordersForInputFields() {
        emailTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        passwordTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }

}
