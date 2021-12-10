//
//  LoadingView.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/2.
//

import UIKit

class LoadingView: UIView {
    lazy var indicator: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .medium)
        } else {
            return UIActivityIndicatorView(style: .gray)
        }
    }()

    deinit {
        print("LoadingView did Deinit")
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 100),
            indicator.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView {
    func show(in view: UIView) {
        frame = view.bounds
        autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        view.addSubview(self)
    }

    func hide() {
        removeFromSuperview()
    }
}
