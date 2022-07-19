//
//  ViewController.swift
//  TestAppShedule(No internet)
//
//  Created by Игорь Островский on 04.07.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
    }
    func setupTabBar(){
        let scheduleViewController = createNavController(vc: ScheduleViewController(), itemName: "Schedule", ItameImage: "calendar.badge.clock")
        let tasksViewController = createNavController(vc: TasksViewController(), itemName: "Tasks", ItameImage: "text.badge.checkmark")
        let contactsViewController = createNavController(vc: ContactsViewController(), itemName: "Contacts", ItameImage: "rectangle.stack.person.crop")
        viewControllers = [scheduleViewController,tasksViewController,contactsViewController]
    }
    
    func createNavController(vc:UIViewController, itemName:String, ItameImage:String) -> UINavigationController{
        
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: ItameImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navController = UINavigationController(rootViewController: vc)
        
        navController.tabBarItem = item
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        return navController
    }


}

