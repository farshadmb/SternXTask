//
//  CollectionView+helpers.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    /**
     Registers a nib file for use in creating new collection view cells.

     - Parameters:
        - type: The type containing the cell class type. it must contain only one top-level object and that object must be of the type UICollectionViewCell.
        - identifier: The reuse identifier to associate with the specified nib file. This parameter must not be `nil` and must not be an empty stringIdentifier
     */
    func registerCell<T: UICollectionViewCell>(type: T.Type, reuseIdentifier identifier: String = String(describing: T.self)) {
        register(type.nib, forCellWithReuseIdentifier: identifier)
    }

    /**
     Registers a class for use in creating new collection view cells.

     - Parameters:
       - className: The class of a cell that you want to use in the collection view.
       - identifier:  The reuse identifier to associate with the specified nib file. This parameter must not be `nil` and must not be an empty string
     */
    func registerCell<T: UICollectionViewCell>(className: T.Type, reuseIdentifier identifier: String = .init(describing: T.self)) {
        register(className, forCellWithReuseIdentifier: identifier)
    }

    /**
     Registers a a class for use in creating supplementary views for the collection view by its type.
     
     - Parameters:
         - classType: the `UICollectionReusableView` subclass type.
         - kind: The kind of supplementary view to create. The layout defines the types of supplementary views it supports.
         The value of this string may correspond to one of the predefined kind strings or to a custom string that the layout added to support a new type of supplementary view. This parameter must not be `nil`.
         - reuseIdentifier: The reuse identifier to associate with the specified nib file. This parameter must not be `nil` and must not be an empty string
     */
    func registerSupplementaryView<T>(classType: T.Type, kind elementKind: String,
                                      reuseIdentifier identifier: String = .init(describing: T.self)) where T: UICollectionReusableView {
        register(classType, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
    }
    
    /**
     Registers a nib file for use in creating supplementary views for the collection view by its type.

     - Parameters:
       - type: the `UICollectionReusableView` subclass type.
       - kind: The kind of supplementary view to create. The layout defines the types of supplementary views it supports.
                      The value of this string may correspond to one of the predefined kind strings or to a custom string that the layout added to support a new type of supplementary view. This parameter must not be `nil`.
       - identifier: The reuse identifier to associate with the specified nib file. This parameter must not be `nil` and must not be an empty string
     */
    func registerSupplementaryView<T>(type: T.Type, kind elementKind: String,
                                   reuseIdentifier identifier: String = .init(describing: T.self)) where T: UICollectionReusableView {
        register(type.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
    }

    /**
     Dequeues a reusable cell object located by its identifier.

     - Parameters:
       - type: the `UICollectionViewCell` subclass type.
       - indexPath: The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
       - identifier: The reuse identifier for the specified cell. This parameter must not be `nil`
     - Returns: The `UICollectionViewCell` subclass type object that given type.
     */
    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath,
                                                      reuseIdentifier identifier: String = String(describing: T.self)) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier,
                                                  for: indexPath) as? T else {
            preconditionFailure("Couldn't find nib file for \(String(describing: T.self))")
        }

        return cell
    }

    /**
     Dequeues a reusable supplementary view located by its identifier and kind.

     - Parameters:
       - type: the `UICollectionReusableView` subclass type.
       - kind: The kind of supplementary view to retrieve. This value is defined by the layout object. This parameter must not be nil
       - indexPath: The index path specifying the location of the supplementary view in the collection view. The data source receives this information when it is asked for the view and should just pass it along. This method uses the information to perform additional configuration based on the view’s position in the collection view.
       - identifier: The reuse identifier for the specified view. This parameter must not be nil.
     - Returns: The `UICollectionReusableView` subclass type object that given type.
     */
    func dequeueReusableSupplementaryView <T: UICollectionReusableView>(type: T.Type,
                                                                        kind: String, forIndexPath indexPath: IndexPath,
                                                                        reuseIdentifier identifier: String = String(describing: T.self)) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? T else {
            preconditionFailure("Couldn't find nib file for \(String(describing: T.self))")
        }

        return view
    }

}
