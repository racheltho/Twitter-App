//
//  AppDelegate.swift
//  Twitter-App
//
//  Created by Rachel Thomas on 2/17/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var timelineStoryboard = UIStoryboard(name: "Timeline", bundle: nil)
    var loginStoryboard = UIStoryboard(name: "Main", bundle: nil)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
        if User.currentUser != nil {
            println("Current user detected: \(User.currentUser?.name)")
            var vc = timelineStoryboard.instantiateViewControllerWithIdentifier("TimelineNavController") as UINavigationController
            window?.rootViewController = vc
        }
        return true
    }
    
    func userDidLogout(){
        var vc = loginStoryboard.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
        window?.rootViewController = vc
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        TwitterClient.sharedInstance.openURL(url)
        return true
    }

}

