//
//  NetworkImage.swift
//  YouShengYa
//
//  Created by youzy01 on 2021/8/24.
//

import UIKit
import Kingfisher

/// UIImageView下载网络图片封装
struct NetworkImage<Base> {
    let base: Base
    init(base: Base) {
        self.base = base
    }
}

protocol NetworkImageDownloadable: AnyObject {
}

extension NetworkImageDownloadable {
    var downloader: NetworkImage<Self> {
        get { return NetworkImage(base: self) }
        set // swiftlint:disable:this unused_setter_value
        {
        }
    }
}

extension UIImageView: NetworkImageDownloadable {
}

extension UIButton: NetworkImageDownloadable {
}

extension NetworkImage where Base: UIImageView {
    var indicatorType: IndicatorType {
        get {
            return base.kf.indicatorType
        }
        set {
            base.kf.indicatorType = newValue
        }
    }

    func setImage(with url: String, placeholder: String, cornerRadius: CGFloat = 0) {
        let processor = DownsamplingImageProcessor(size: base.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: cornerRadius)

        base.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: placeholder),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}

extension NetworkImage where Base: UIButton {
    func setImage(with url: String, placeholder: String, cornerRadius: CGFloat = 0) {
        let processor = DownsamplingImageProcessor(size: base.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: cornerRadius)

        base.kf.setImage(
            with: URL(string: url),
            for: .normal,
            placeholder: UIImage(named: placeholder),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}

class NetworkImagePrefetcher {
    static func start(urls: [URL], complation: @escaping () -> Void) {
        let prefetcher = ImagePrefetcher(urls: urls) { _, _, completedResources in
            complation()
            print("These resources are prefetched: \(completedResources)")
        }
        prefetcher.start()
    }
}
