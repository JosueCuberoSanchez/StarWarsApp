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

    var nameLabel = UILabel()
    var classificationLabel = UILabel()
    var averageHeightLabel = UILabel()
    var languageLabel = UILabel()
    var homeworldLabel = UILabel()
    var backgroundImageView = UIImageView()

    private let backgroundImages = [R.image.backgroundBb8(), R.image.backgroundFalcon(), R.image.backgroundTatooine()]

    var specieImageViewTopAnchorConstraint: NSLayoutConstraint!

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

    private func setupBindings() {
        specieViewModel.specieName
            .map { R.string.localizable.name_format($0) }
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        specieViewModel.specieClassification
            .map { R.string.localizable.classification_format($0) }
            .drive(classificationLabel.rx.text)
            .disposed(by: disposeBag)

        specieViewModel.specieAverageHeight
            .map { R.string.localizable.average_height_format($0) }
            .drive(averageHeightLabel.rx.text)
            .disposed(by: disposeBag)

        specieViewModel.specieLanguage
            .map { R.string.localizable.language_format($0) }
            .drive(languageLabel.rx.text)
            .disposed(by: disposeBag)

        specieViewModel.specieHomeworld
            .map { R.string.localizable.homeworld_format($0) }
            .drive(homeworldLabel.rx.text)
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
