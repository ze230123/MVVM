//
//  CollectionDataSource.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/1.
//

import UIKit
import Base

class CollectionDataSource<Cell, Value>: NSObject, UICollectionViewDataSource where Cell: UICollectionViewCell, Cell: CellConfigurable, Cell.Value == Value {
    private var items: [Value] = [] {
        willSet {
            if newValue.isEmpty {
                indexPaths.removeAll()
            } else {
                let range = items.count..<newValue.count
                indexPaths = range.map { IndexPath(item: $0, section: 0) }
            }
        }

        didSet {
            if indexPaths.isEmpty {
                collectionView?.reloadData()
            } else {
                collectionView?.insertItems(at: indexPaths)
                collectionView?.reloadItems(at: indexPaths)
            }
        }
    }

    private var indexPaths: [IndexPath] = [] {
        didSet {
            print("indexPaths", indexPaths)
        }
    }

    weak var collectionView: UICollectionView?

    deinit {
        debugPrint("CollectionDataSource did deinit")
    }

    init(collectionView: UICollectionView?) {
        self.collectionView = collectionView
        super.init()
        collectionView?.registerCell(Cell.self)
        collectionView?.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as Cell
        cell.configure(items[indexPath.item])
        return cell
    }
}

extension CollectionDataSource {
    var isEmpty: Bool {
        return items.isEmpty
    }

    subscript(_ indexPath: IndexPath) -> Value {
        return items[indexPath.item]
    }

    subscript(_ index: Int) -> Value {
        return items[index]
    }

    func append(_ newElement: Value) {
        items.append(newElement)
    }

    func append<S>(contentsOf newElements: S) where Value == S.Element, S: Sequence {
        items.append(contentsOf: newElements)
    }

    func removeAll() {
        items.removeAll()
    }
}

extension CollectionDataSource: Observer {
    func observer(_ value: [Value]) {
        items.append(contentsOf: value)
    }
}
