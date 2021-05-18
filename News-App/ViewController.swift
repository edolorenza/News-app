//
//  ViewController.swift
//  News-App
//
//  Created by Edo Lorenza on 18/05/21.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.getTopNews { result in
            switch result{
            case .success(let response):
                break
            case . failure(let error):
                print(error)
            }
        }
    }

}

