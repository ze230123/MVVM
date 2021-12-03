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
enum LoadState {
    /// 加载
    case loading
    /// 成功
    case success
    /// 失败
    case failure(Error)
    /// 空数据
    case empty
}

class CollegeAllViewModel {
    @LiveData private(set) var list: [CollegeList.Item] = []
    @LiveData private(set) var state: LoadState = .loading

    var parameter = CollegeListParameter()

    var task: DataRequest?

    deinit {
        task?.cancel()
    }

    func queryList(for index: Int) {
        state = .loading

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
                if root.result.items.isEmpty {
                    self?.state = .empty
                } else {
                    self?.state = .success
                }
                self?.list = root.result.items
            case .failure(let error):
                print("AF Error", error.localizedDescription)
                self?.state = .failure(error)
            }
        }
    }
}

