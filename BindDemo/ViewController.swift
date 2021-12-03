//
//  ViewController.swift
//  BindDemo
//
//  Created by youzy01 on 2021/11/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!

    @LiveData var name: [String] = []

    deinit {
        print("\(self) did is deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        $name.observer { [weak label] value in
            label?.text = value.joined(separator: "*")
        }
    }

    @IBAction func valueChanged(_ sender: UITextField) {
        name.append(sender.text ?? "nil")
    }

    @IBAction func resetAction() {
//        name = ["reset"]
        let vc = CollegeAllViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

