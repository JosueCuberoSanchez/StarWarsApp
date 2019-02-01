//
//  UITableView+RegisterDequeue.swift
//  StarWarsApp
//
//  Created by Josue on 1/29/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {

    /**
     Register a cell on a collection view
     - Parameter cellType: the custom cell type. Ex: SliderCollectionViewCell
     */
    public func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = String(describing: cellType)
        register(T.self, forCellWithReuseIdentifier: className)
    }

    /**
     Dequeue a cell for the collection view
     - Parameter type: the cell type.
     - Parameter indexPath: the cell index path.
     */
    public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T
    }

}
