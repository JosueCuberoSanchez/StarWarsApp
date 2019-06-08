//
//  SpecieViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SpecieViewController: UIViewController, UIScrollViewDelegate {

    private var apiClient: APIClient!
    private var specieViewModel: SpecieViewModel!
    private let disposeBag = DisposeBag()

    // Subviews
    var scrollView = UIScrollView()
    var contentView = UIView()
    var specieImageView = UIImageView(image: R.image.detailRebelAlliance())
    var nameLabel = UILabel()
    var classificationLabel = UILabel()
    var averageHeightLabel = UILabel()
    var languageLabel = UILabel()
    var homeworldLabel = UILabel()
    var backgroundImageView = UIImageView()

    let backgroundImages = [R.image.backgroundBb8(), R.image.backgroundFalcon(), R.image.backgroundTatooine()]

    // Dynamic constraints
    var portraitImageViewTopAnchorConstraints: [NSLayoutConstraint]!
    var landscapeImageViewTopAnchorConstraints: [NSLayoutConstraint]!

    init(_ specie: Specie, _ apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(nibName: nil, bundle: nil)
        specieViewModel = SpecieViewModel(
            request: { [weak self] in
                guard let sself = self else { return Driver.empty() }
                return PlanetResource($0).execute(with: sself.apiClient, using: JSONDecoder())
            },
            specie: specie
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NS Coder init fatal error.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    /**
     Bind the subviews data to the viewModel's drivers.
     */
    private func setupBindings() {
        /// Name
        specieViewModel.specieName
            .asObservable()
            .map { R.string.localizable.name_format($0) }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)

        /// Classification
        specieViewModel.specieClassification
            .asObservable()
            .map { R.string.localizable.classification_format($0) }
            .bind(to: classificationLabel.rx.text)
            .disposed(by: disposeBag)

        /// Average height
        specieViewModel.specieAverageHeight
            .asObservable()
            .map { R.string.localizable.average_height_format($0) }
            .bind(to: averageHeightLabel.rx.text)
            .disposed(by: disposeBag)

        /// Average height
        specieViewModel.specieLanguage
            .asObservable()
            .map { R.string.localizable.language_format($0) }
            .bind(to: languageLabel.rx.text)
            .disposed(by: disposeBag)

        /// Homeworld
        specieViewModel.specieHomeworld
            .asObservable()
            .map { R.string.localizable.homeworld_format($0) }
            .bind(to: homeworldLabel.rx.text)
            .disposed(by: disposeBag)

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
