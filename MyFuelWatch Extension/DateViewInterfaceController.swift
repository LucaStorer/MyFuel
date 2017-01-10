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
	

	let yearOffset = 1950
	
	@IBOutlet var monthPicker: WKInterfacePicker!
	@IBAction func monthPicker(_ value: Int) {
		month = value + 1
	}
	
    
	@IBOutlet var dayPicker: WKInterfacePicker!
	@IBAction func dayPicker(_ value: Int) {
		day = value + 1
	}
	
	@IBOutlet var yearPicker: WKInterfacePicker!
	@IBAction func yearPicker(_ value: Int) {
		year = yearsArray[value]
	}
	
	
	func getDateFromString() -> NSDate {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd mm yyyy"
		
		let dateString = day.description + " " + month.description + " " + year.description 
		let dateObtainedFromString = dateFormatter.date(from: dateString)
		
		if let _ = dateObtainedFromString {
			return dateObtainedFromString! as NSDate
		}
		else {
			return NSDate.init(timeIntervalSinceNow: 100)
		}
	}
	
	   override func awake(withContext context: Any?) {
        super.awake(withContext: context)
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
		for i in 0 ..< monthsMap.count {
			let pickerItem = WKPickerItem()
			pickerItem.title = monthsMap[i]
			pickerItem.caption = "Mese"
			monthPickerItems.append(pickerItem)
		}
		
		monthPicker.setItems(monthPickerItems)
		
		// Create and initialize daysArray and daysPicker
        var day: Int = 1
		
		var dayPickerItems = [WKPickerItem]()
		for i in 0 ..< 31 {
            
			daysArray.append(day)
			let pickerItem = WKPickerItem()
			pickerItem.title = daysArray[i].description
			pickerItem.caption = "Giorno"
			dayPickerItems.append(pickerItem)
            day += 1
		}
		
		dayPicker.setItems(dayPickerItems)
		
		//for var yearIndex = 1900; yearIndex <= 2100; yearIndex += 1 {
	//		yearsArray.append(yearIndex)
	//	}
        
        for yearIndex in 1950...2050{
            
            yearsArray.append(yearIndex)
            
        }
        
		var yearPickerItems = [WKPickerItem]()
		for i in 0 ..< yearsArray.count {
			let pickerItem = WKPickerItem()
			pickerItem.title = yearsArray[i].description
			pickerItem.caption = "Anno"
			yearPickerItems.append(pickerItem)
		}
		
		yearPicker.setItems(yearPickerItems)
		
		// Set picker defaults so user doesn't have to manually scroll
		setDefaultPickersOnDatePickerInterfaceController()
		
		year = yearsArray[0]
	}

       override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
	
	func setDefaultPickersOnDatePickerInterfaceController() {
		let todayDate = NSDate()
		let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
		
		let monthComponent = calendar.components(.month, from: todayDate as Date)
		let month = monthComponent.month
		
		let dayComponent = calendar.components(.day, from: todayDate as Date)
		let day = dayComponent.day
		
		let yearComponent = calendar.components(.year, from: todayDate as Date)
		let year = yearComponent.year
		
				
		// These have no "0" state so they are 0 index based
		monthPicker.setSelectedItemIndex(month! - 1)
		dayPicker.setSelectedItemIndex(day! - 1)
		yearPicker.setSelectedItemIndex(year! - yearOffset)
		
	}

 
       @IBAction func CmdOk() {
        
        let DateString = getDateFromString()
        
        print(DateString)
        
        presentController(withName: "newitemview", context: DateString)
        
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
