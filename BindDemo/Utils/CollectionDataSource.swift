//
//  CollectionDataSource.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/1.
//

import UIKit
import EGKit

class CollectionDataSource<C, M>: NSObject, UICollectionViewDataSource where C: UICollectionViewCell, C: CellConfigurable, C.T == M {
    var items: [M] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    weak var collectionView: UICollectionView?

    deinit {
        debugPrint("CollectionDataSource did deinit")
    }

    init(collectionView: UICollectionView?) {
        self.collectionView = collectionView
        super.init()
        collectionView?.registerCell(C.self)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as C
        cell.configure(items[indexPath.item])
        return cell
    }
}

extension CollectionDataSource {
    var isEmpty: Bool {
        return items.isEmpty
    }

    subscript(_ indexPath: IndexPath) -> M {
        return items[indexPath.item]
    }

    subscript(_ index: Int) -> M {
        return items[index]
    }

    func append(_ newElement: M) {
        items.append(newElement)
    }

    func append<S>(contentsOf newElements: S) where M == S.Element, S: Sequence {
        items.append(contentsOf: newElements)
    }

    func removeAll() {
        items.removeAll()
    }
}

extension CollectionDataSource: Observer {
    func observer(_ value: [M]) {
        items.append(contentsOf: value)
    }
}
