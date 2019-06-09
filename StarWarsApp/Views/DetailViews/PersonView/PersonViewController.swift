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

    var personImageViewTopAnchorConstraint: NSLayoutConstraint!

    init(_ person: Person, _ apiClient: APIClient) {
        self.apiClient = apiClient
        
        super.init(nibName: nil, bundle: nil)
        
        personViewModel = PersonViewModel(
            request: { [weak self] in
                guard let sself = self else { return Driver.empty() }
                return PlanetResource($0).execute(with: sself.apiClient, using: JSONDecoder())
            },
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

    private func setupBindings() {
        personViewModel.personName
            .map { R.string.localizable.name_format($0) }
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        personViewModel.personGender
            .map { R.string.localizable.gender_format($0.rawValue) }
            .drive(genderLabel.rx.text)
            .disposed(by: disposeBag)

        personViewModel.personHeight
            .map { R.string.localizable.height_format($0) }
            .drive(heightLabel.rx.text)
            .disposed(by: disposeBag)

        personViewModel.personHomeworld
            .map { R.string.localizable.homeworld_format($0) }
            .drive(homeworldLabel.rx.text)
            .disposed(by: disposeBag)

        collectionView.rx.didEndDecelerating.asDriver()
            .drive(onNext: { [weak self] in
                if let xAxis = self?.collectionView.contentOffset.x {
                    self?.pagingControl.currentPage = Int(round(xAxis / 320))
                }
            })
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

    // The next functions are for the image slider

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(with: SliderCollectionViewCell.self, for: indexPath),
              let image = characterImages[indexPath.row]
        else {
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
