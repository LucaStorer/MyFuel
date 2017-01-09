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

    
    @IBOutlet var LblDate: WKInterfaceDate!
    
    @IBOutlet var LblKmTot: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if let text = context as? String {
            
              print(text)
            
            if text != ""{
          
                print("DATA: \(text)")
                
               
                
               
                
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
  
    
    @IBAction func CmdDate(_ sender: Any) {
        
        self.presentController(withName: "DateView", context: "")
        
    }
    
}
