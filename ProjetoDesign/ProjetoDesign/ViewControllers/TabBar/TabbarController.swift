//
//  TabbarController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class TabbarController: UITabBarController {

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarItems()
        // Do any additional setup after loading the view.
    }

    // MARK: - Methods 
    func setTabBarItems(){
        self.tabBar.tintColor = UIColor.systemIndigo
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        let feed = (self.tabBar.items?[0])! as UITabBarItem
        feed.image = UIImage(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        //feed.selectedImage = UIImage(named: "homefill")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        feed.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)

        let upload = (self.tabBar.items?[2])! as UITabBarItem
        upload.image = UIImage(named: "mais")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        //upload.selectedImage = UIImage(named: "mais-fill")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        upload.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)

        let notifications = (self.tabBar.items?[3])! as UITabBarItem
        notifications.image = UIImage(named: "heart-2")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
       // notifications.selectedImage = UIImage(named: "heart-fill")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        notifications.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)

        let profile = (self.tabBar.items?[4])! as UITabBarItem
        profile.image = UIImage(named: "usuario")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
       // profile.selectedImage = UIImage(named: "usuario-fill")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        profile.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
    }

}
