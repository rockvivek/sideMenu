//
//  ViewController.swift
//  sideMenuDemoApp
//
//  Created by vivek shrivastwa on 21/05/21.
//

import UIKit

class ContainerViewController: UIViewController {

    let homeVC = HomeViewController()
    let menuVC = MenuViewController()
    
    let infoVC = InfoViewController()
    let settingVC = SettingViewController()
    let shareAppVC = ShareAppViewController()
    let AppRatingVC = AppRatingViewController()
    
    var navVC:UINavigationController?
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addChileVC()
    }

    private func addChileVC() {
        //menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //home
        homeVC.delegate = self
        menuVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(complition: nil)
    }
    func toggleMenu(complition: (() -> Void)?){
        //animate
        switch menuState {
        case .closed:
            //open menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.navVC!.view.frame.origin.x = self.homeVC.view.frame.size.width - 150
                            self.navVC!.view.frame.origin.y = 150
                            self.navVC?.view.frame.size.height = self.homeVC.view.frame.size.height - 300
                            self.navVC?.view.layer.cornerRadius = 25
                           },
                           completion: {[weak self] done in
                            if done {
                                self?.menuState = .opened
                                
                            }
                           })
        case .opened:
            //close menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.navVC!.view.frame.origin.x = 0
                            self.navVC!.view.frame.origin.y = 0
                            self.navVC?.view.frame.size.height = self.homeVC.view.frame.size.height + 300
                           },
                           completion: { [weak self] done in
                            if done {
                                self?.menuState = .closed
                                DispatchQueue.main.async {
                                    complition?()
                                }
                            }
                           })
            
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        
        toggleMenu { [weak self] in
            switch menuItem {
            case .home:
                //self!.addHome()
                break
            case .info:
                self!.addInfo()
                break
            case .appRating:
                //self!.addAppRating()
                break
            case .shareApp:
                //self!.addShareApp()
                break
            case .setting:
                //self!.addSetting()
                break
            }
        }
    }
    func addInfo() {
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
}
