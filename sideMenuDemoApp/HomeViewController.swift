//
//  HomeViewController.swift
//  sideMenuDemoApp
//
//  Created by vivek shrivastwa on 21/05/21.
//

import UIKit

protocol HomeViewControllerDelegate:AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {

    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
    }
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }
    
}


