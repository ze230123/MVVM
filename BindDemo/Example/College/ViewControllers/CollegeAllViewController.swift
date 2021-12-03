//
//  CollegeAllViewController.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/1.
//

import UIKit

class CollegeAllViewController: BaseCollectionViewController {
    let viewModel = CollegeAllViewModel()

//    lazy var dataSource = CollectionDataSource<CollegeListCell, CollegeList.Item>(collectionView: collectionView)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        layout.itemSize = UICollectionViewFlowLayout.automaticSize
//        layout.estimatedItemSize = CGSize(width: Screen.width, height: 100)
//        layout.minimumLineSpacing = 8
//        layout.sectionInset.top = 10
//
//        collectionView.dataSource = dataSource
//
//        viewModel.$list.bind(to: dataSource)
//
//        viewModel.$state.observer { [unowned collectionView, unowned dataSource, unowned self] state in
//            if dataSource.isEmpty {
//                switch state {
//                case .loading:
//                    collectionView?.eg.showLoading()
//                default:
//                    collectionView?.eg.hideLoading()
//                }
//            }
//            switch state {
//            case .success:
//                collectionView?.endRefresh(self.action, isNotData: false)
//            case .failure(let error):
//                collectionView?.endRefresh(self.action, error: error)
//            case .empty:
//                collectionView?.endRefresh(self.action, isNotData: true)
//            case .loading: break
//            }
//        }
//
//        addRefreshHeader()
//        addRefreshFooter()
//
//        loadData()
//    }
//
//    override func request(action: RefreshAction) {
//        viewModel.queryList(for: pageIndex)
//    }
}

//class LoadingAdapter: Observer {
//    func observer(_ value: LoadState) {
//
//    }
//}

//class CollectionViewLoadingAdapter: LoadingAdapter {
//    let collectionView: UICollectionView
//
//    init(collectionView: UICollectionView) {
//        self.collectionView = collectionView
//        super.init()
//    }
//
//    override func observer(_ value: LoadState) {
//        if collectionView.numberOfItems(inSection: 0) == 0 {
//            switch value {
//            case .loading:
//                collectionView.eg.showLoading()
//            default:
//                collectionView.eg.hideLoading()
//            }
//        }
//
//        switch value {
//        case .success:
//            collectionView.endRefresh(<#T##action: RefreshAction##RefreshAction#>, isNotData: <#T##Bool#>)
//        case .failure(let error):
//            <#code#>
//        case .empty:
//            <#code#>
//        }
//    }
//}
