//
//  InterfaceController.swift
//  WatchConnectApp WatchKit Extension
//
//  Created by Neil Smyth on 8/19/15.
//  Copyright © 2015 eBookFrenzy. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var MyTable: WKInterfaceTable!
    @IBOutlet var Loader: WKInterfaceImage!
    
    @IBOutlet var MainGroup: WKInterfaceGroup!
    @IBOutlet var LoaderGroup: WKInterfaceGroup!
    
    var history: String = ""
    var historyTable: [(String, String,String,String,String,String,String,String,String,String)] = []
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
    //   StartLoader()
        
      //  CallJSON()


        
    }
    
    
    @IBAction func CmdJSON() {
        
      StartLoader()
        CallJSON()
        
           }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        StartLoader()
        
        CallJSON()
        

        
          }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func CallJSON(){
        
       // if WCSession.default().isReachable == true {
        
      
        
            let requestValues = ["command" : "JSON"]
            let session = WCSession.default()
            
            session.sendMessage(requestValues, replyHandler: { reply in
                self.history = (reply["status"] as? String)!
                //  print("Result: \(self.history)")
                
                if  self.CreateDataArry() == true {
                    
                    self.statusLabel.setText(self.historyTable.count.description)
                    
                    //Carica i dati nella tabella
                    self.LoadTableData()
                }
                
            }, errorHandler: { error in
                print("error: \(error)")
            })
      //  }

        
    }
    
    private func CreateDataArry() -> Bool {
        
        let Row :[String] =  self.history.components(separatedBy: "#")
        
        self.historyTable = []
        
        for ValueRow :String in Row{
            
            let RowArray : [String] = ValueRow.components(separatedBy: "|")
            
            if RowArray.count > 1 {
                
                let collection : (String, String,String,String,String,String,String,String,String,String)
                
                collection = ("\(RowArray[0])","\(RowArray[1])","\(RowArray[2])","\(RowArray[3])","\(RowArray[4])","\(RowArray[5])","\(RowArray[6])","\(RowArray[7])","\(RowArray[8])","\(RowArray[9])")
                
                self.historyTable.append(collection)
                
            }
            
        }
        
        return true
    }
    
    //Carica la tabella con il numero di elementi dell'array e la calsse della cella da usare
    func LoadTableData(){
        
        MyTable.setNumberOfRows(historyTable.count, withRowType: "CustomCell")
        
        for (index, content) in historyTable.enumerated(){
            
            let row = MyTable.rowController(at: index) as! CustomCell
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeStyle = DateFormatter.Style.none
            
            row.LblDate.setText( content.1)
            row.LblKmTot.setText(content.2)
            
            if (content.9 == "0"){
                
                row.ImgPartial.setHidden(true)
                
            }else{
                row.ImgPartial.setHidden(false)
   
                
            }
          
        }
          StopLoader()
            }
    
    
    func StartLoader(){
        
        Loader.setImageNamed("Activity")
        
        Loader.startAnimatingWithImages(in: NSMakeRange(1,30), duration: 1, repeatCount: 0)
        
        LoaderGroup.setHidden(false)
        MainGroup.setHidden(true)
        
    }
    
    func StopLoader(){
        
        LoaderGroup.setHidden(true)
        MainGroup.setHidden(false)
        
        Loader.stopAnimating()

    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        self.pushController(withName: "DetailView", context: historyTable[rowIndex])
        
        print(historyTable[rowIndex])
        
     }
    
    
}
