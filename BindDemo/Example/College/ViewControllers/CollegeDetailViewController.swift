//
//  CollegeDetailViewController.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/8.
//

import UIKit

class CollegeDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!

    private let name: String

    init(name: String) {
        self.name = name
        super.init(nibName: "CollegeDetailViewController", bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
    }
}
