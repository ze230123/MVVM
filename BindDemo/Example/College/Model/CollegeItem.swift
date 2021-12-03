//
//  CollegeItem.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/1.
//

import Foundation

/// 学历层次
enum EduLevel: String, Codable {
    /// 本科
    case ben
    /// 专科
    case zhuan

    var name: String {
        switch self {
        case .ben:
            return "本科"
        case .zhuan:
            return "专科"
        }
    }
}

extension EduLevel: CustomStringConvertible {
    var description: String {
        return "学历层次: \(name)"
    }
}

/// 办学性质
enum NatureType: String, Codable {
    /// 公办
    case `public`
    /// 民办
    case `private`
    /// 中外/港澳
    case awGa
    /// 其他
    case other

    var name: String {
        switch self {
        case .public:
            return "公办"
        case .private:
            return "民办"
        case .awGa:
            return "中外/港澳"
        case .other:
            return "其他"
        }
    }
}

extension NatureType: CustomStringConvertible {
    var description: String {
        return "办学性质： \(name)"
    }
}

/// 院校列表模型
struct CollegeList: Codable {
    var items: [Item]
    var totalCount: Int
}

extension CollegeList {
    struct Item: Codable {
        var id: String

        /// 学历层次 ben：本科 zhuan：专科
        var eduLevel: EduLevel
        /// 所在省份名称
        var provinceName: String
        /// 国标代码
        var gbCode: String
        /// 办学特色，如：985，211，双一流
        var features: [String]
        /// 办学性质 public：公办 private：民办 aw_ga：中外/港澳 other：其他
        var natureType: NatureType
        /// 主管部门，如：教育部，省教育厅
        var belong: String
        /// 院校代码
        var code: String
        /// 院校中文名称
        var cnName: String
        /// 院校排名-软科
        var rankingOfRK: Int
        /// 原院校NumId
        var numId: Int
        /// 学校类别，如：综合，理工
        var categories: [String]
        /// 所在省份Code
        var provinceCode: String
        /// 所在城市名称
        var cityName: String
        /// 校徽
        var logoUrl: String

        /// 默认排名
        var ranking: Int
        /// 院校排名-校友会
        var rankingOfXYH: Int
        /// 院校排名-武书连
        var rankingOfWSL: Int
        /// 院校排名-QS
        var rankingOfQS: Int
        /// 院校排名-USNews
        var rankingOfUSNews: Int
    }
}

//{
//  "result": ,
//  "code": "string",
//  "message": "string",
//  "fullMessage": "string",
//  "timestamp": "2021-12-01T07:36:05.194Z",
//  "isSuccess": true
//}

struct RootResult<Result: Codable>: Codable {
    var result: Result
    var code: String
    var message: String
    var fullMessage: String
    var isSuccess: Bool
}
