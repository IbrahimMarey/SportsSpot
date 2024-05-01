//
//  SceneDelegate.swift
//  SportsSpot
//
//  Created by Khokha on 22/04/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        let homeIcon = UIImage(systemName: "house")
        let fvIcon = UIImage(systemName: "heart.fill")
        
        let tabBarController = UITabBarController()
        let tab1 = MainViewController(nibName: "MainViewController", bundle: nil)
        
        let tab2 = FavoutieViewController(nibName: "FavoutieViewController", bundle: nil)
        
        tab1.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 1)
        tab2.tabBarItem = UITabBarItem(title: "Favourite", image: fvIcon, tag: 2)
        
        let controllers = [tab1, tab2]
        
        tabBarController.viewControllers = controllers
        
        guard let appScene = (scene as? UIWindowScene) else { return }
        window =  UIWindow(windowScene: appScene)
        //let rootView = MainViewController()
        window?.rootViewController = UINavigationController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

