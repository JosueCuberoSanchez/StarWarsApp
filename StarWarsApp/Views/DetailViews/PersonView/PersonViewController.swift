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

// swiftlint:disable:next line_length
class PersonViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private var apiClient: APIClient!
    private var personViewModel: PersonViewModel!
    private let disposeBag = DisposeBag()

    // Subviews
    var scrollView = UIScrollView()
    var contentView = UIView()
    var personImageView = UIImageView(image: R.image.detailBb8())
    var nameLabel = UILabel()
    var genderLabel = UILabel()
    var heightLabel = UILabel()
    var homeworldLabel = UILabel()
    var backgroundImageView = UIImageView()
    var collectionView: UICollectionView!
    var pagingControl = UIPageControl()

    let backgroundImages = [R.image.backgroundBb8(), R.image.backgroundFalcon(), R.image.backgroundTatooine()]
    let characterImages =
        [R.image.characters(), R.image.darkSide(), R.image.jedis(), R.image.robots(), R.image.resistance()]

    // Dynamic constraints
    var portraitImageViewTopAnchorConstraints: [NSLayoutConstraint]!
    var landscapeImageViewTopAnchorConstraints: [NSLayoutConstraint]!

    init(_ person: Person, _ apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(nibName: nil, bundle: nil)
        personViewModel = PersonViewModel(
            request: { PlanetResource($0).execute(with: self.apiClient, using: JSONDecoder()) },
            person: person
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NS Coder init fatal error.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupBindings()
    }

    /**
     Bind the subviews data.
     */
    private func setupBindings() {
        /// Name
        personViewModel.personName
            .asObservable()
            .map { R.string.localizable.name_format($0) }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)

        /// Gender
        personViewModel.personGender
            .asObservable()
            .map { R.string.localizable.gender_format($0.rawValue) }
            .bind(to: genderLabel.rx.text)
            .disposed(by: disposeBag)

        /// Height
        personViewModel.personHeight
            .asObservable()
            .map { R.string.localizable.height_format($0) }
            .bind(to: heightLabel.rx.text)
            .disposed(by: disposeBag)

        /// Homeworld
        personViewModel.personHomeworld
            .asObservable()
            .map { R.string.localizable.homeworld_format($0) }
            .bind(to: homeworldLabel.rx.text)
            .disposed(by: disposeBag)

        /// Slider scroll
        collectionView.rx.didEndDecelerating
            .subscribe(onNext: { [weak self] in
                if let xAxis = self?.collectionView.contentOffset.x {
                    self?.pagingControl.currentPage = Int(round(xAxis / 320))
                }
            })
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

    // The next functions are for the image slider

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(with: SliderCollectionViewCell.self, for: indexPath),
              let image = characterImages[indexPath.row] else {
            return SliderCollectionViewCell()
        }

        cell.setImage(image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return characterImages.count
    }

    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    private func collectionView(collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
