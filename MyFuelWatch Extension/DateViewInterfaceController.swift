//
//  DateViewInterfaceController.swift
//  MyFuel
//
//  Created by Luca Storer on 09/01/17.
//  Copyright © 2017 Luca Storer. All rights reserved.
//

import WatchKit
import Foundation


class DateViewInterfaceController: WKInterfaceController {

    @IBOutlet var picDay: WKInterfacePicker!
    @IBOutlet var picMonth: WKInterfacePicker!
    @IBOutlet var picYear: WKInterfacePicker!
    
    
    var DayItems = [WKPickerItem]()
    var MonthItems = [WKPickerItem]()
    var YearItems = [WKPickerItem]()
    
    var PickDayItem = WKPickerItem()
    var PickMonthItem = WKPickerItem()
     var PickYearItem = WKPickerItem()
    
    var day = 01
    var month = 01
    var year = 2000
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if let text = context as? String {
            
            print(text)
        }
        
        for i in 1...31{
            
            let day = String(format: "%02d",i)
            
            PickDayItem.title = day
            PickDayItem.caption = "Giorno"
         
            DayItems.append(PickDayItem)
        }
        
        for i in 1...12{
            
            let Month = String(format: "%02d",i)
            
            PickMonthItem.title = Month
            PickMonthItem.caption = "Mese"
            
            MonthItems.append(PickMonthItem)
            
        }
        
        for i in 2000...2050{
            
            let year = String(i)
            
            PickYearItem.title = year
            PickYearItem.caption = "Anno"
            
            YearItems.append(PickYearItem)
            
        }
     
        picDay.setItems(DayItems)
        picMonth.setItems(MonthItems)
        picYear.setItems(YearItems)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    @IBAction func CmdDay(_ value: Int) {
        
        day = value
        print(value)
    }
    
    @IBAction func CmdMonth(_ value: Int) {
        
        month = value
        print(value)

    }
    
    @IBAction func CmdYear(_ value: Int) {

        year = value
        print(value)

    }
    
    
       @IBAction func CmdOk() {
        
        let DateString = "\(picDay.description)/\(picMonth.description)/\(picYear.description)"
        
        print(DateString)
        
        presentController(withName: "newitemview", context: DateString)
        
    }
    
    
}
