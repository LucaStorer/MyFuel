//
//  AppDelegate.swift
//  MyFuel
//
//  Created by Luca Storer on 26/09/16.
//  Copyright © 2016 Luca Storer. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?

    var MySQL : MySql = MySql()
    
    var historyTable: [(String, Date,String,String,String,String,String,String,String,String)] = []
    var StatTable: [(String,String,String,String,String,String,String)] = []


    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        var replyValues = Dictionary<String, AnyObject>()
        
     //   let viewController = self.window!.rootViewController as! ViewController
        
        switch message["command"] as! String {
            
        case "JSON" :
            
            
            MySQL.GetAllData()
            self.historyTable = MySQL.historyTable
            
            let StringData: String = GetStringData()
            
            replyValues["status"] = StringData as AnyObject?
            
        case "JSON-STAT" :
            
                MySQL.GetStatData()
                
                self.StatTable = MySQL.v_StatTable
            
             let StringDataStat: String = GetStringDataStat()
            
                replyValues["status"] = StringDataStat as AnyObject?

        default:
            break
        }
        
        replyHandler(replyValues)
    
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if (WCSession.isSupported()) {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
            
            if session.isPaired != true {
                print("Apple Watch is not paired")
            }
            
            if session.isWatchAppInstalled != true {
                print("WatchKit app is not installed")
            }
        } else {
            print("WatchConnectivity is not supported on this device")
        }
        return true
    }

    //Crea un'unica stringa che viene passata per poi essere nuovamente processata
    private func GetStringData() -> String{
        
        var StringData: String = ""
        
        for row: (String, Date,String,String,String,String,String,String,String,String) in self.historyTable{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeStyle = DateFormatter.Style.none
            
            let DataString :String = dateFormatter.string(from: row.1)
            
            StringData = StringData + "\(row.0)|\(DataString)|\(row.2)|\(row.3)|\(row.4)|\(row.5)|\(row.6)|\(row.7)|\(row.8)|\(row.9)#"
            
        }
        
        return StringData
        
    }
    
    //Crea un'unica stringa che viene passata per poi essere nuovamente processata
    private func GetStringDataStat() -> String{
        
        var StringDataStat: String = ""
        
        for row: (String,String,String,String,String,String,String) in self.StatTable{
            
            StringDataStat = StringDataStat + "\(row.0)|\(row.1)|\(row.2)|\(row.3)|\(row.4)|\(row.5)|\(row.6)#"
            
        }
        
        return StringDataStat
        
    }

    

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

