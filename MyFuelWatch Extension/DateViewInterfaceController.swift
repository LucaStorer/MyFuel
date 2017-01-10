//
//  DateViewInterfaceController.swift
//  MyFuel
//
//  Created by Luca Storer on 09/01/17.
//  Copyright © 2017 Luca Storer. All rights reserved.
//
// https://github.com/FoxMcWeezer/Date-Picker-for-Apple-Watch/blob/master/DatePickerForAppleWatch.swift

import WatchKit
import Foundation


class DateViewInterfaceController: WKInterfaceController {

var monthsMap = [Int: String]()
	var daysArray = [Int]()
	var yearsArray = [Int]()

	
	var month = 1
	var day = 1
	var year = Int()
	

	let yearOffset = 1900
	
	@IBOutlet var monthPicker: WKInterfacePicker!
	@IBAction func monthPicker(value: Int) {
		month = value + 1
	}
	
	@IBOutlet var dayPicker: WKInterfacePicker!
	@IBAction func dayPicker(value: Int) {
		day = value + 1
	}
	
	@IBOutlet var yearPicker: WKInterfacePicker!
	@IBAction func yearPicker(value: Int) {
		year = yearsArray[value]
	}
	
	
	func getDateFromString() -> NSDate {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "M d yyyy"
		
		let dateString = month.description + " " + day.description + " " + year.description 
		let dateObtainedFromString = dateFormatter.dateFromString(dateString)
		
		if let _ = dateObtainedFromString {
			return dateObtainedFromString!
		}
		else {
			return NSDate.init(timeIntervalSinceNow: 100)
		}
	}
	
	override func awakeWithContext(context: AnyObject?) {
		// Fill months map with month abbreviations
		monthsMap[0] = "Jan"
		monthsMap[1] = "Feb"
		monthsMap[2] = "Mar"
		monthsMap[3] = "Apr"
		monthsMap[4] = "May"
		monthsMap[5] = "Jun"
		monthsMap[6] = "Jul"
		monthsMap[7] = "Aug"
		monthsMap[8] = "Sep"
		monthsMap[9] = "Oct"
		monthsMap[10] = "Nov"
		monthsMap[11] = "Dec"
		
		// Fill monthPicker with month abbreviation strings
		var monthPickerItems = [WKPickerItem]()
		for var i = 0; i < monthsMap.count; ++i {
			let pickerItem = WKPickerItem()
			pickerItem.title = monthsMap[i]
			pickerItem.caption = "Month"
			monthPickerItems.append(pickerItem)
		}
		
		monthPicker.setItems(monthPickerItems)
		
		// Create and initialize daysArray and daysPicker
		var day = 1
		
		var dayPickerItems = [WKPickerItem]()
		for var i = 0; i < 31; ++i {
			daysArray.append(day++)
			let pickerItem = WKPickerItem()
			pickerItem.title = daysArray[i].description
			pickerItem.caption = "Day"
			dayPickerItems.append(pickerItem)
		}
		
		dayPicker.setItems(dayPickerItems)
		
		for var yearIndex = 1900; yearIndex <= 2100; ++yearIndex {
			yearsArray.append(yearIndex)
		}
		var yearPickerItems = [WKPickerItem]()
		for var i = 0; i < yearsArray.count; ++i {
			let pickerItem = WKPickerItem()
			pickerItem.title = yearsArray[i].description
			pickerItem.caption = "Year"
			yearPickerItems.append(pickerItem)
		}
		
		yearPicker.setItems(yearPickerItems)
		
		// Set picker defaults so user doesn't have to manually scroll
		setDefaultPickersOnDatePickerInterfaceController()
		
		year = yearsArray[0]
	}
	
	func setDefaultPickersOnDatePickerInterfaceController() {
		let todayDate = NSDate()
		let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
		
		let monthComponent = calendar.components(.Month, fromDate: todayDate)
		let month = monthComponent.month
		
		let dayComponent = calendar.components(.Day, fromDate: todayDate)
		let day = dayComponent.day
		
		let yearComponent = calendar.components(.Year, fromDate: todayDate)
		let year = yearComponent.year
		
				
		// These have no "0" state so they are 0 index based
		monthPicker.setSelectedItemIndex(month - 1)
		dayPicker.setSelectedItemIndex(day - 1)
		yearPicker.setSelectedItemIndex(year - yearOffset)
		
	}


  /*  @IBOutlet var picDay: WKInterfacePicker!
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
        
    }*/
    
    
}
