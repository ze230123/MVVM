//
//  CollegeAllViewController.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/1.
//

import UIKit
import Base

class CollegeAllViewController: BaseCollectionViewController {
    let viewModel = CollegeAllViewModel()

    lazy var adapter = AllCollegeListAdapter(view: collectionView)

    override func viewDidLoad() {
        super.viewDidLoad()

        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: Screen.width, height: 75)
        layout.minimumLineSpacing = 8
        layout.sectionInset.top = 10

        viewModel.$list.bind(to: adapter)
        viewModel.$state.bind(to: adapter)

        adapter.addRefresh(style: [.header, .footer]) { [weak viewModel] index in
            viewModel?.queryList(for: index)
        }

        viewModel.queryList()
    }
}

extension CollegeAllViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = adapter.dataSource[indexPath]
        let vc = CollegeDetailViewController(name: item.cnName)
        navigationController?.pushViewController(vc, animated: true)
    }
}

import Refresh

/// 适配器基类
class BaseAdapter<View> where View: UIView {
    let view: View

    let loadView = LoadingView()

    deinit {
        print("\(self) deinit")
    }

    init(view: View) {
        self.view = view
    }

    func startLoadAnimating() {
        loadView.show(in: view)
    }

    func stopLoadAnimating() {
        loadView.hide()
    }
}

/// CollectionView适配器基类
class BaseCollectionAdapter: BaseAdapter<UICollectionView> {
}

/// 带Refresh的CollectionView适配器
class CollectionRefreshAdapter: BaseCollectionAdapter {
    @RefreshEvent var action: RefreshAction = .load

    func addRefresh(style: RefreshStyle, complation: @escaping (Int) -> Void) {
        if style.contains(.header) {
            let headerView = RefreshHeaderView()
            view.rf.header = RefreshHeader(view: headerView) { [unowned self] in
                action = .load
                print("下拉刷新", $action)
                complation($action)
            }
        }

        if style.contains(.footer) {
            let footerView = RefreshFooterView { [unowned self] in
                print("重新请求", $action)
                complation($action)
            }

            view.rf.footer = RefreshFooter(view: footerView) { [unowned self] in
                action = .more
                print("上拉加载", $action)
                complation($action)
            }
        }
    }

    func endRefresh(isNotData: Bool = false) {
        switch action {
        case .load:
            view.rf.header?.endRefresh()
            view.rf.footer?.resetRefresh()
            view.rf.footer?.isHidden = isNotData
        case .more:
            if isNotData {
                view.rf.footer?.endRefreshNoMoreData()
            } else {
                view.rf.footer?.endRefresh()
            }
        }
    }

    func endRefresh(error: Error) {
        switch action {
        case .load:
            view.rf.header?.endRefresh(error: error)
        case .more:
            view.rf.footer?.endRefresh(error: error)
        }
    }
}

extension CollectionRefreshAdapter {
    /// 刷新控件样式
    struct RefreshStyle: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        /// 下拉刷新
        static let header = RefreshStyle(rawValue: 1)
        /// 上拉加载
        static let footer = RefreshStyle(rawValue: 2)
    }

    /// 刷新动作
    enum RefreshAction {
        /// 下拉刷新
        case load
        /// 上拉加载
        case more
    }

    /// 刷新动作属性包装器
    ///
    /// 自动计算pageIndex，默认从1开始
    @propertyWrapper
    struct RefreshEvent {
        var pageIndex: Int = 1

        public var wrappedValue: RefreshAction {
            didSet {
                switch wrappedValue {
                case .load:
                    pageIndex = 1
                case .more:
                    pageIndex += 1
                }
            }
        }

        public var projectedValue: Int {
            return pageIndex
        }

        public init(wrappedValue: RefreshAction) {
            self.wrappedValue = wrappedValue
        }
    }
}

typealias AllCollegeListDataSource = CollectionDataSource<CollegeListCell, CollegeList.Item>

/// 全部院校列表适配器
class AllCollegeListAdapter: CollectionRefreshAdapter {
    let dataSource: AllCollegeListDataSource
    var cache: [IndexPath: CGFloat] = [:]

    override init(view: UICollectionView) {
        dataSource = AllCollegeListDataSource(collectionView: view)
        super.init(view: view)
    }
}

extension AllCollegeListAdapter: Observer {
    func observer(_ value: [CollegeList.Item]) {
        print("添加数据", value.count)
        if action == .load {
            dataSource.removeAll()
        }
        dataSource.append(contentsOf: value)
    }
}

extension AllCollegeListAdapter: StateObserver {
    func onChanged(value: ListLoadState) {
        switch value {
        case .loading:
            print("开始刷新")
//            startLoadAnimating()
        case .refresh: break
        case .success:
            print("结束刷新动画")
            stopLoadAnimating()
            endRefresh()
        case .failure(let error):
            print("结束刷新动画")
            endRefresh(error: error)
            stopLoadAnimating()
        case .empty:
            print("结束刷新动画")
            endRefresh(isNotData: true)
            stopLoadAnimating()
        }
    }
}
