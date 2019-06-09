//
//  PersonViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StarshipViewController: UIViewController, UIScrollViewDelegate {

    private var apiClient: APIClient!
    private var starshipViewModel: StarshipViewModel!
    private let disposeBag = DisposeBag()

    let nameLabel = UILabel()
    let manufacturerLabel = UILabel()
    let lengthLabel = UILabel()
    let passengersLabel = UILabel()
    let classLabel = UILabel()
    let backgroundImageView = UIImageView()

    private let backgroundImages = [R.image.backgroundBb8(), R.image.backgroundFalcon(), R.image.backgroundTatooine()]

    var starshipImageViewTopAnchorConstraint: NSLayoutConstraint!

    init(_ starship: Starship, _ apiClient: APIClient) {
        self.apiClient = apiClient
        
        super.init(nibName: nil, bundle: nil)
        
        starshipViewModel = StarshipViewModel(starship: starship)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NS Coder init fatal error.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }

    private func setupBindings() {
        starshipViewModel.starshipName
            .map { R.string.localizable.name_format($0) }
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        starshipViewModel.starshipManufacturer
            .map { R.string.localizable.manufacturer_format($0) }
            .drive(manufacturerLabel.rx.text)
            .disposed(by: disposeBag)

        starshipViewModel.starshipLength
            .map { R.string.localizable.length_format($0) }
            .drive(lengthLabel.rx.text)
            .disposed(by: disposeBag)

        starshipViewModel.starshipPassengers
            .map { R.string.localizable.passengers_format($0) }
            .drive(passengersLabel.rx.text)
            .disposed(by: disposeBag)

        starshipViewModel.starshipClass
            .map { R.string.localizable.class_format($0) }
            .drive(classLabel.rx.text)
            .disposed(by: disposeBag)

        let backgroundImages = self.backgroundImages
        Driver.timer(0, period: 5.0)
            .map { backgroundImages[$0 % backgroundImages.count] }
            .drive(onNext: { [weak self] in
                if let nextBackgroundImage = $0 {
                    self?.backgroundImageView.setImageWithDissolveAnimation(nextBackgroundImage)
                }
            })
            .disposed(by: disposeBag)
    }

}
