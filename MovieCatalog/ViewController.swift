//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 03.08.2025.
//

import UIKit

class ViewController: UIViewController {
    let myButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        myButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        myButton.setTitle("Press me", for: .normal)
        myButton.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
        view.addSubview(myButton)
    }

    @objc func buttonTapped() {
        print("Button tapped!")
    }
}
