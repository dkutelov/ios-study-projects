//
//  TabBarViewController.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 26.12.21.
//

import UIKit

class TabBarViewController: UITabBarController {
    var homeViewController: UIViewController?
    var exploreViewController: UIViewController?
    var cameraViewController: UIViewController?
    var activityViewController: UIViewController?
    var profileViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTabBar()
    }
    
    private func updateTabBar() {
        guard let email = UserDefaults.standard.string(forKey: "email"),
              let username = UserDefaults.standard.string(forKey: "username")
        else { return }
        
        let currentUser = User(
            username: username,
            email: email
        )
        
        let home = HomeViewController()
        let explore = ExploreViewController()
        let camera = CameraViewController()
        let activity = NotificationsViewController()
        let profile = ProfileViewController(user: currentUser)
        
        homeViewController = UINavigationController(rootViewController: home)
        exploreViewController = UINavigationController(rootViewController: explore)
        cameraViewController = UINavigationController(rootViewController: camera)
        activityViewController = UINavigationController(rootViewController: activity)
        profileViewController = UINavigationController(rootViewController: profile)
        
        if let homeViewController = homeViewController,
            let exploreViewController = exploreViewController,
            let cameraViewController = cameraViewController,
            let activityViewController = activityViewController,
            let profileViewController = profileViewController {
            
            setTabBarItems(homeViewController, exploreViewController, cameraViewController, activityViewController, profileViewController)
            
            self.setViewControllers([homeViewController,
                                     exploreViewController,
                                     cameraViewController,
                                     activityViewController,
                                     profileViewController], animated: false)
        }
    }
    
    private func setTabBarItems(_ homeViewController: UIViewController,
                                _ exploreViewController: UIViewController,
                                _ cameraViewController: UIViewController,
                                _ activityViewController: UIViewController,
                                _ profileViewController: UIViewController) {
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home",
                                    image: UIImage(systemName: "house"),
                                    tag: 1)
        exploreViewController.tabBarItem = UITabBarItem(title: "Explore",
                                    image: UIImage(systemName: "safari"),
                                    tag: 2)
        cameraViewController.tabBarItem = UITabBarItem(title: "Camera",
                                    image: UIImage(systemName: "camera"),
                                    tag: 3)
        activityViewController.tabBarItem = UITabBarItem(title: "Notifications",
                                    image: UIImage(systemName: "bell"),
                                    tag: 4)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile",
                                    image: UIImage(systemName: "person.circle"),
                                    tag: 5)
    }
}
