//
//  TabbarController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItems()
        // Do any additional setup after loading the view.
    }
    
    func setTabBarItems(){
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "menu-2.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "menu")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.title = ""
        myTabBarItem1.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "plus2.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "plus.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.title = ""
        myTabBarItem2.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "user-2.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "user.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.title = ""
        myTabBarItem3.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
