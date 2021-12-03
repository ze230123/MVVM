//
//  CollegeApi.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/1.
//

import Moya
import Foundation

enum CollegeApi {
    case all(CollegeListParameter)
}

extension CollegeApi: TargetType {
    var task: Task {
        switch self {
        case let .all(parameter):
            return .requestParameters(parameters: parameter.parameters, encoding: JSONEncoding.default)
        }
    }

    var path: String {
        switch self {
        case .all:
            return "/youzy.dms.basiclib.api.college.query"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var baseURL: URL {
        switch self {
        default:
            return URL(string: "http://qa-apigateway.youzy.cn")!
        }
    }

    var headers: [String : String]? {
        return nil
    }
}

struct CollegeListParameter: Encodable {
    /// 关键词
    var keyword: String = ""
    /// 省份
    var provinceNames: [String] = []
    /// 办学性质 public：公办 private：民办 aw_ga：中外/港澳 other：其他
    var natureTypes: [String] = []
    /// 学历层次 ben：本科 zhuan：专科
    var eduLevel: String = ""
    /// 学校类别，如：综合，理工
    var categories: [String] = []
    /// 办学特色，如：985，211，双一流
    var features: [String] = []
    /// **未知作用**
    var entranceType: [String] = []
    /// 排序
    var sort: Sort = .timeDescending
    /// 当前开始页
    var pageIndex: Int = 1
    /// 每页数量，暂时没有用到，接口固定返回20条数据
    var pageSize: Int = 20
}

extension CollegeListParameter {
    var parameters: [String: Any] {
        return [
            "keyword": keyword,
            "provinceNames": provinceNames,
            "natureTypes": natureTypes,
            "eduLevel": eduLevel,
            "categories": categories,
            "features": features,
            "entranceType": entranceType,
            "sort": sort.rawValue,
            "pageIndex": pageIndex
          ]
    }
}

extension CollegeListParameter {
    enum Sort: Int, Encodable {
        /// 0：最后编辑时间降序(默认)
        case timeDescending
        /// 1：院校Code升序
        case codeAscending
        /// 2：院校Code降序
        case codeDescending
        /// 3：院校名称升序
        case nameAscending
        /// 4：院校名称降序
        case nameDescending
        /// 5：武书连
        case wuLianShu
        /// 6：软科
        case ruanKe
        /// 7：校友会
        case xiaoYouHui
        /// 8：QS
        case qs
        /// 9：USNews
        case usNews
    }
}
