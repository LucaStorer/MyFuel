//
//  MySqlClass.swift
//  MyFuel
//
//  Created by Luca Storer on 28/09/16.
//  Copyright © 2016 Luca Storer. All rights reserved.
//

import Foundation

class MySql : NSObject{

    enum MyError: Error {
        case FoundNil(String)
    }

    let URL_GET_HISTORY:String
    let URL_GET_STAT:String
    var historyTable: [(String, Date,String,String,String,String,String,String,String,String)] = []
    var v_StatTable: [(String,String,String,String,String,String,String)] = []

    override init() {

         URL_GET_HISTORY = "http://www.lucastorer.esy.es/GetMF.php"
        URL_GET_STAT = "http://www.lucastorer.esy.es/GetStatMF.php"

        self.historyTable = []
        self.v_StatTable = []

    }

    func GetAllData(){

        //created NSURL
        let  requestURL:NSURL = NSURL(string: URL_GET_HISTORY)!

        //creating NSMutableURLRequest
        let   request:NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)

        request.httpMethod = "GET"

           do {

            guard let data = try? Data(contentsOf: requestURL as URL) else {
                throw MyError.FoundNil("Impossibile connettersi!")
            }


             let historyJSON = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray

            var jsonElement: NSDictionary = NSDictionary()

                self.historyTable.removeAll()

                //looping through all the json objects in the array teams
                 for i in 0 ..< historyJSON.count{

                    jsonElement = historyJSON[i] as! NSDictionary

                    //the following insures none of the JsonElement values are nil through optional binding
                    let ID:String = jsonElement["ID"] as! String
                    let DATA:String = jsonElement["DATA"] as! String
                    let KMTOT:String = jsonElement["KMTOT"] as! String
                    let LITRI:String = jsonElement["LITRI"] as! String
                    let KM:String = jsonElement["KM"] as! String
                    let EURO:String = jsonElement["EURO"] as! String
                    let EURO_KM:String = jsonElement["EURO_KM"] as! String
                    let EURO_LITRO:String = jsonElement["EURO_LITRO"] as! String
                    let LITRI_100KM:String = jsonElement["LITRI_100KM"] as! String
                    let PARZIALE:String = jsonElement["PARZIALE"] as! String

                    let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    let p_Data:Date = dateFormatter.date(from: DATA)!

                     self.historyTable.append((ID,p_Data,KMTOT,LITRI,KM,EURO,EURO_KM,EURO_LITRO,LITRI_100KM,PARZIALE))

                    print("UID -> ", ID)
                    print("Data -> ", DATA)
                    print("KmTot -> ", KMTOT)
                    print("===================")
                    print("")

                }

                //Warning for line below: "catch block is unreachable because no errors are thrown in 'do' block
           } catch {

            print("error getting xml string: \(error)")
        }
    }

    func GetStatData(){

        //created NSURL
        let  requestURL:NSURL = NSURL(string: URL_GET_STAT)!

        //creating NSMutableURLRequest
        let   request:NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)

        request.httpMethod = "GET"

        do {

            guard let data = try? Data(contentsOf: requestURL as URL) else {
                throw MyError.FoundNil("Impossibile connettersi!")
            }


            let historyJSON = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray

            var jsonElement: NSDictionary = NSDictionary()

            self.historyTable.removeAll()

            //looping through all the json objects in the array teams
            for i in 0 ..< historyJSON.count{

                jsonElement = historyJSON[i] as! NSDictionary

                //the following insures none of the JsonElement values are nil through optional binding
                let KMTOT:String = jsonElement["KMTOT"] as! String + " Km"
                let LITRI:String = jsonElement["LITRI"] as! String + " Litri"
                let LITRI_100KM:String = jsonElement["LITRI_100KM"] as! String //+ " l/100Km"
                let KM_LITRO:String = jsonElement["KM_LITRO"] as! String + " Km/l"
                let EURO_LITRO:String = jsonElement["EURO_LITRO"] as! String + " €/l"
                let EURO_KM:String = jsonElement["EURO_KM"] as! String + " €/Km"
                let KM_YEAR:String = jsonElement["KM_YEAR"] as! String

                self.v_StatTable.append((KMTOT,LITRI,LITRI_100KM,KM_LITRO,EURO_LITRO,EURO_KM,KM_YEAR))

            }

            //Warning for line below: "catch block is unreachable because no errors are thrown in 'do' block
        } catch {
            
            print("error getting xml string: \(error)")
        }
    }



    func InsertNewRecord(ID: String, Data: Date, KmParziali: String,KmTot: String,Litri: String,EuroKm: String,Litri100Km: String,EuroLitro: String,Euro: String, Parziale: String){

        let request = NSMutableURLRequest(url: URL(string: "http://www.lucastorer.esy.es/InsertMF.php")!)

        request.httpMethod = "POST"

        //Preparo le stringhe
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

       let p_KmParziali = KmParziali.replacingOccurrences(of: ",", with: ".")
       let p_litri = Litri.replacingOccurrences(of: ",", with: ".")
       let p_euroKm = EuroKm.replacingOccurrences(of: ",", with: ".")
       let p_Litri100km = Litri100Km.replacingOccurrences(of: ",", with: ".")
       let p_eurolitro = EuroLitro.replacingOccurrences(of: ",", with: ".")
       let p_euro = Euro.replacingOccurrences(of: ",", with: ".")


        let postString = "DATE=\(dateFormatter.string(from: Data))&KMTOT=\(KmTot)&LITRI=\(p_litri)&KM=\(p_KmParziali)&EURO=\(p_euro)&EURO_KM=\(p_euroKm)&EURO_LITRO=\(p_eurolitro)&LITRI_100KM=\(p_Litri100km)&PARZIALE=\(Parziale)"

        print("POSTSTRING -> ", postString)

        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in


            if error != nil {
                print("error=\(error)")
                return
            }

            print("response = \(response)")

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        }
        task.resume()
        
        
    }

    func RemoveRecord(RecordID: String){

        let request = NSMutableURLRequest(url: URL(string: "http://www.lucastorer.esy.es/DeleteMF.php")!)

        request.httpMethod = "POST"

         let postString = "ID=\(RecordID)"

        print("POSTSTRING -> ", postString)

        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in


            if error != nil {
                print("error=\(error)")
                return
            }

            print("response = \(response)")

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        }
        task.resume()

    }

    func UpdateRecord (ID: String, Data: Date, KmParziali: String,KmTot: String,Litri: String,EuroKm: String,Litri100Km: String,EuroLitro: String,Euro: String, Parziale: String){

        let request = NSMutableURLRequest(url: URL(string: "http://www.lucastorer.esy.es/UpdateMF.php")!)

        request.httpMethod = "POST"

        //Preparo le stringhe
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let p_KmParziali = KmParziali.replacingOccurrences(of: ",", with: ".")
        let p_litri = Litri.replacingOccurrences(of: ",", with: ".")
        let p_euroKm = EuroKm.replacingOccurrences(of: ",", with: ".")
        let p_Litri100km = Litri100Km.replacingOccurrences(of: ",", with: ".")
        let p_eurolitro = EuroLitro.replacingOccurrences(of: ",", with: ".")
        let p_euro = Euro.replacingOccurrences(of: ",", with: ".")


        let postString = "ID=\(ID)&DATE=\(dateFormatter.string(from: Data))&KMTOT=\(KmTot)&LITRI=\(p_litri)&KM=\(p_KmParziali)&EURO=\(p_euro)&EURO_KM=\(p_euroKm)&EURO_LITRO=\(p_eurolitro)&LITRI_100KM=\(p_Litri100km)&PARZIALE=\(Parziale)"

        print("POSTSTRING -> ", postString)

        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in


            if error != nil {
                print("error=\(error)")
                return
            }

            print("response = \(response)")

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
}
