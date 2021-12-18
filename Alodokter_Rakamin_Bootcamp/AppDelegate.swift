//
//  AppDelegate.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 07/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpNavigation()
//        firstInstall()
        
        return true
    }

    func firstInstall(){
        if UserDefaults.standard.value(forKey: "firstInstall") == nil{
            UserDefaults.standard.set(Session.unregistered.rawValue, forKey: "session")
            UserDefaults.standard.set("alreadyInstalled", forKey: "firstInstall")
        }
    }
    
    func setUpNavigation() {
        let navigationBarAppearance = UINavigationBar.appearance()
        var backgroundImage = UIImage(named: "NavbarBG")
        backgroundImage = backgroundImage?.stretchableImage(withLeftCapWidth: 0, topCapHeight: 0)
        navigationBarAppearance.setBackgroundImage(backgroundImage, for: .default)
        navigationBarAppearance.barTintColor = .white
        navigationBarAppearance.tintColor = .white
        
        let newNavigationBarAppearance = UINavigationBarAppearance()
        newNavigationBarAppearance.backgroundImage = backgroundImage
        navigationBarAppearance.standardAppearance = newNavigationBarAppearance
        navigationBarAppearance.scrollEdgeAppearance = navigationBarAppearance.standardAppearance
        newNavigationBarAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        newNavigationBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

