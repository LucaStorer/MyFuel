//
//  MainController.swift
//  WatchConnectApp
//
//  Created by Luca Storer on 22/12/16.
//  Copyright © 2016 eBookFrenzy. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class MainController: WKInterfaceController {

    var Stat: String = ""
    var StatTable: [(String, String,String,String,String,String,String)] = []

    
    @IBOutlet var LblLitri100Km: WKInterfaceLabel!
    @IBOutlet var LblKmAnno: WKInterfaceLabel!
    @IBOutlet var LblEuroLitri: WKInterfaceLabel!
    @IBOutlet var LblKm: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
          CallJSON()
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
           CallJSON()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //Esegue la richiesta dei dati all'iphone
    private func CallJSON(){
       
        let requestValues = ["command" : "JSON-STAT"]
        let session = WCSession.default()
        
        
        session.sendMessage(requestValues, replyHandler: { reply in
            self.Stat = (reply["status"] as? String)!
            //  print("Result: \(self.history)")
            
            if  self.CreateDataArry() == true {
                
              //  self.StatusLabel.setText(self.historyTable.count.description)
                
                //Carica i dati nella tabella
                self.LoadDataView()
            }
            
        }, errorHandler: { error in
            print("error: \(error)")
        })
    }

    //Crea l'array dalla stringa passata dalla richiesta all'iphone
    private func CreateDataArry() -> Bool {
        
        let Row :[String] =  self.Stat.components(separatedBy: "#")
        
        self.StatTable = []
        
        for ValueRow :String in Row{
            
            let RowArray : [String] = ValueRow.components(separatedBy: "|")
            
            if RowArray.count > 1 {
                
                let collection : (String, String,String,String,String,String,String)
                
                collection = ("\(RowArray[0])","\(RowArray[1])","\(RowArray[2])","\(RowArray[3])","\(RowArray[4])","\(RowArray[5])","\(RowArray[6])")
                
                self.StatTable.append(collection)
                
            }
            
        }
        
        return true
    }
    
    func LoadDataView(){
        
        LblLitri100Km.setText(self.StatTable[0].2)
        LblKmAnno.setText("\(self.StatTable[0].6) Km Anno")
         LblEuroLitri.setText("\(self.StatTable[0].4)")
         LblKm.setText("\(self.StatTable[0].0) Totali")
        
    }

    @IBAction func MenuNewItem() {
        
          self.presentController(withName: "newitemview", context: "")
        
    }

    

}
