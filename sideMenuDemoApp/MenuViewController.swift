//
//  MenuViewController.swift
//  sideMenuDemoApp
//
//  Created by vivek shrivastwa on 21/05/21.
//

import UIKit

protocol MenuViewControllerDelegate:AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController {

    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
        case setting = "Setting"
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .info:
               return "airplane"
            case .appRating:
               return "star"
            case .shareApp:
              return "message"
            case .setting:
                return "gear"
            }
        }
    }
    
    weak var delegate:MenuViewControllerDelegate?
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .gray
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        tableView.delegate = self
        tableView.dataSource = self
        
        //adding tableview subview
        view.addSubview(tableView)
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //frame
        tableView.frame = view.bounds
    }

}
extension MenuViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.imageView!.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.textLabel?.textColor = .white
        cell.contentView.backgroundColor = .gray
        cell.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //select menu option
        tableView.deselectRow(at: indexPath, animated: false)
        //print("menu")
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    
}
