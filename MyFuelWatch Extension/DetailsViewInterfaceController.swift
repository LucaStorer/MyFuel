//
//  DetailsViewInterfaceController.swift
//  WatchConnectApp
//
//  Created by Luca Storer on 22/12/16.
//  Copyright © 2016 eBookFrenzy. All rights reserved.
//

import WatchKit
import Foundation


class DetailsViewInterfaceController: WKInterfaceController {
    
    @IBOutlet var LblDate: WKInterfaceLabel!
    @IBOutlet var LblKmTot: WKInterfaceLabel!
    @IBOutlet var LblKm: WKInterfaceLabel!
    @IBOutlet var Lbleurolitro: WKInterfaceLabel!
    @IBOutlet var Lbleuro: WKInterfaceLabel!
    @IBOutlet var LblLitri: WKInterfaceLabel!
    @IBOutlet var LblLitri100Km: WKInterfaceLabel!
    @IBOutlet var ImgPartial: WKInterfaceImage!
    
    
    // var items: (String, Date,String,String,String,String,String,String,String,String)
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        let items = context as! (String, String, String, String, String, String, String, String, String, String)
        
        LblDate.setText(items.1)
        LblKmTot.setText(items.2)
        LblKm.setText(items.4)
        Lbleurolitro.setText(items.7)
        Lbleuro.setText(items.5)
        LblLitri.setText(items.3)
        LblLitri100Km.setText(items.8)
        
        let Partial: String = items.9
        
        if (Partial == "0"){
           ImgPartial.setHidden(true)
        }else{
            ImgPartial.setHidden(false)

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
    
}
