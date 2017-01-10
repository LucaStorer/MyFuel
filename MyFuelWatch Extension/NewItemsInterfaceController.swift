//
//  NewItemsInterfaceController.swift
//  MyFuel
//
//  Created by Luca Storer on 09/01/17.
//  Copyright © 2017 Luca Storer. All rights reserved.
//

import WatchKit
import Foundation


class NewItemsInterfaceController: WKInterfaceController {

    
    @IBOutlet var LblData: WKInterfaceLabel!
        @IBOutlet var LblKmTot: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if let text = context as? String {
            
              print(text)
            
            if text != ""{
          
                print("DATA: \(text)")
            
                LblData.setText(text)
            }else{
                
                let date = NSDate()
                let calendar = NSCalendar.current
                
                let daynow = calendar.component(.day, from: date as Date)
                let monthnow = calendar.component(.month, from: date as Date)
                let yearnow = calendar.component(.year, from: date as Date)
                
             let   DateString = "\(String(format: "%02d",daynow))/\(String(format: "%02d",monthnow))/\(yearnow)"

                 LblData.setText(DateString)
                
            }
            
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

  
    @IBAction func CmdKmTot(_ sender: Any) {
        
        presentTextInputController(withSuggestions: nil,allowedInputMode: WKTextInputMode.plain,completion: {(results) -> Void in
            if results != nil && results!.count > 0 { //selection made
                let aResult = results?[0] as! String
                self.LblKmTot.setText("\(aResult) Km")
                
                for res in results!{
                    
                    
                    print(res)
                    
                }
            }
        })
    }
  
    @IBAction func CmdData(_ sender: Any) {
        
        self.presentController(withName: "DateView", context: "")
            
            
        
        
        
        
    }
    
     func contextForSegueWithIdentifier(segueIdentifier: String) ->
        AnyObject? {
            if segueIdentifier == "add" {
         //       return ["segue": "hierarchical",
          //      "data":"Passed through hierarchical navigation"]
                print("add")
        
            } else {
            //    return ["segue": "", "data: "]
            }
              return "" as AnyObject?
    }


    @IBAction func CmdSave() {
        
        
        
    }
}
