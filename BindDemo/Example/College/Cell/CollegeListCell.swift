//
//  CollegeListCell.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/1.
//

import UIKit
import Base

class CollegeListCell: UICollectionViewCell, CellConfigurable {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var provinceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: Screen.width)
        ])
    }

    static var nib: UINib? {
        return UINib(nibName: identifier, bundle: nil)
    }

    func configure(_ item: CollegeList.Item) {
        imageView.downloader.setImage(with: item.logoUrl, placeholder: "icon_school", cornerRadius: 17)
        nameLabel.text = item.cnName
        descLabel.text = item.categories.joined(separator: " ")
        provinceLabel.text = item.provinceName
    }
}
