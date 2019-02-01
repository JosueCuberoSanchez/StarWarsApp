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

    // Subviews
    var scrollView = UIScrollView()
    var contentView = UIView()
    var starshipImageView = UIImageView(image: R.image.detailDeathStar())
    var nameLabel = UILabel()
    var manufacturerLabel = UILabel()
    var lengthLabel = UILabel()
    var passengersLabel = UILabel()
    var classLabel = UILabel()
    var backgroundImageView = UIImageView()

    let backgroundImages = [R.image.backgroundBb8(), R.image.backgroundFalcon(), R.image.backgroundTatooine()]

    // Dynamic constraints
    var portraitImageViewTopAnchorConstraints: [NSLayoutConstraint]!
    var landscapeImageViewTopAnchorConstraints: [NSLayoutConstraint]!

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

    /**
     Bind the subviews data to the viewModel's behaviour relays.
     */
    private func setupBindings() {
        /// Name
        starshipViewModel.starshipName
            .asObservable()
            .map { R.string.localizable.name_format($0) }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)

        /// Manufacturer
        starshipViewModel.starshipManufacturer
            .asObservable()
            .map { R.string.localizable.manufacturer_format($0) }
            .bind(to: manufacturerLabel.rx.text)
            .disposed(by: disposeBag)

        /// Length
        starshipViewModel.starshipLength
            .asObservable()
            .map { R.string.localizable.length_format($0) }
            .bind(to: lengthLabel.rx.text)
            .disposed(by: disposeBag)

        /// Passengers
        starshipViewModel.starshipPassengers
            .asObservable()
            .map { R.string.localizable.passengers_format($0) }
            .bind(to: passengersLabel.rx.text)
            .disposed(by: disposeBag)

        /// Class
        starshipViewModel.starshipClass
            .asObservable()
            .map { R.string.localizable.class_format($0) }
            .bind(to: classLabel.rx.text)
            .disposed(by: disposeBag)

        /// Background image
        Observable.timer(0, period: 5.0, scheduler: MainScheduler.instance)
            .map { self.backgroundImages[$0 % self.backgroundImages.count] }
            .subscribe(onNext: { [weak self] in
                if let nextBackgroundImage = $0 {
                    self?.backgroundImageView.setImageWithDissolveAnimation(nextBackgroundImage)
                }
            })
            .disposed(by: disposeBag)
    }

}
