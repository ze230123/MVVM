//
//  Screen.swift
//  YouShengYa
//
//  Created by youzy01 on 2020/12/22.
//

import UIKit

/// 屏幕相关常量
enum Screen {
}

extension Screen {
    /// 宽度
    static let width = UIScreen.main.bounds.width
    /// 高度
    static let height = UIScreen.main.bounds.height

    static let scale = UIScreen.main.scale
    /// 状态栏高度
    static let status = UIApplication.shared.statusBarFrame.height
    /// 导航栏高度
    static let navBar = status + 44
}

func scaleW(_ x: CGFloat) -> CGFloat {
    return Screen.width / 375 * x
}
