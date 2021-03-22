//
//  SDCollectionView+SDReusable.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//

import UIKit

public extension UICollectionView {
    
    final func register<T: UICollectionView>(cellType: T.Type)
    where T: SDReusable & SDNibLoadable {
        self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func register<T: UICollectionViewCell>(cellType: T.Type)
    where T: SDReusable {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
    where T: SDReusable {
        let baseCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
        guard let cell = baseCell as? T else {
            fatalError(
              "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
      where T: SDReusable & SDNibLoadable {
        self.register(
          supplementaryViewType.nib,
          forSupplementaryViewOfKind: elementKind,
          withReuseIdentifier: supplementaryViewType.reuseIdentifier
        )
    }
    
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
      where T: SDReusable {
        self.register(
          supplementaryViewType.self,
          forSupplementaryViewOfKind: elementKind,
          withReuseIdentifier: supplementaryViewType.reuseIdentifier
        )
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
      (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
      where T: SDReusable {
        let view = self.dequeueReusableSupplementaryView(
          ofKind: elementKind,
          withReuseIdentifier: viewType.reuseIdentifier,
          for: indexPath
        )
        guard let typedView = view as? T else {
          fatalError(
            "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
              + "matching type \(viewType.self). "
              + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
              + "and that you registered the supplementary view beforehand"
          )
        }
        return typedView
    }
}
