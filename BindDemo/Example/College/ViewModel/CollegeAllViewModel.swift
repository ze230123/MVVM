//
//  CollegeAllViewModel.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/1.
//

import Foundation
import Alamofire
import CoreText

/// 加载状态
public enum LoadState {
    /// 加载
    case loading
    /// 成功
    case success
    /// 失败
    case failure(Error)
    /// 空数据
    case empty
}

public enum ListLoadState {
    case loading
    case refresh
    case success
    case failure(Error)
    case empty
}

class CollegeAllViewModel {
    @LiveData private(set) var list: [CollegeList.Item] = []
    @LiveState private(set) var state: ListLoadState = .loading

    var parameter = CollegeListParameter()

    var task: DataRequest?

    deinit {
        task?.cancel()
    }

    func queryList(for index: Int = 1) {
        print("请求数据", index)

        if list.isEmpty {
            state = .loading
        } else {
            state = .refresh
        }

        let url = "http://qa-apigateway.youzy.cn/youzy.dms.basiclib.api.college.query"

        parameter.pageIndex = index

        task = AF.request(
            url,
            method: .post,
            parameters: parameter,
            encoder: JSONParameterEncoder.default
        ).responseDecodable(of: RootResult<CollegeList>.self) { [weak self] response in
            switch response.result {
            case .success(let root):
                print("请求成功", index)
                self?.list = root.result.items
                if root.result.items.isEmpty {
                    self?.state = .empty
                } else {
                    self?.state = .success
                }
            case .failure(let error):
                print("AF Error", error.localizedDescription)
                self?.state = .failure(error)
            }
        }
    }
}

