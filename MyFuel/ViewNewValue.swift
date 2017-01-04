//
//  ViewNewValue.swift
//  MyFuel
//
//  Created by Luca Storer on 26/09/16.
//  Copyright © 2016 Luca Storer. All rights reserved.
//

import UIKit

class ViewNewValue: UIViewController {

    @IBOutlet weak var MySubView: UIView!

    @IBOutlet weak var TxtDate: UITextField!
    @IBOutlet weak var LblKmTot: UITextField!
    @IBOutlet weak var LblLitri: UITextField!
    @IBOutlet weak var LblEuroLitro: UITextField!
    @IBOutlet weak var LblEuro: UITextField!
    @IBOutlet weak var LblKmParziali: UILabel!
    @IBOutlet weak var LblLitri100Km: UILabel!
    @IBOutlet weak var swcPieno: UISwitch!

    var IsNewRecord:Bool = true

    var IDRecord:String=""
    var kmPrecedenti:String = "0"
    var Data:Date? = Date.init()
    var KmTot:String = "0"
    var EuroLitro:String = "0"
    var Euro:String = "0"
    var Litri:String = "0"
    var KmParziali:String = "0"
    var EuroKm:String = "0"
    var Litri100Km:String = "0"
    var Parziale:String = "0"

    var KmParzialiCalcolo:String = "0"
    var LitriCalcolo:String = "0"


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        self.MySubView.layer.cornerRadius = 10.0
        self.MySubView.clipsToBounds = true

        self.showAnimate()

        LblKmTot.keyboardType = .numberPad
        LblEuroLitro.keyboardType = .decimalPad
        LblEuro.keyboardType = .decimalPad

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none

        if (IsNewRecord == true){

            TxtDate.text = dateFormatter.string(from: Date.init())
            LblKmTot.text = kmPrecedenti

        }else{

            TxtDate.text = dateFormatter.string(from: Data!)
            LblKmTot.text = KmTot
            LblEuroLitro.text = EuroLitro
            LblEuro.text = Euro
            LblLitri.text = Litri
            LblKmParziali.text = KmParziali + " Km Pariziali"
            LblLitri100Km.text = Litri100Km + " l/100Km"

            if (Parziale=="1") {

                swcPieno.isOn = false

            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)

        self.view.alpha = 0.0;

        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }

    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }

    @IBAction func TxtDateClick(_ sender: UITextField) {

        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView

        datePickerView.addTarget(self, action: #selector(ViewNewValue.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }


    @IBAction func PienoSwitch(_ sender: UISwitch) {

        if sender.isOn{
            Parziale = "0"
        }else{
            Parziale = "1"
        }
    }


    func datePickerValueChanged(sender:UIDatePicker) {

        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none

        Data = sender.date

        TxtDate.text = dateFormatter.string(from: sender.date)
    }

    @IBAction func EuroLitroClick(_ sender: UITextField) {

        CalcolaLitri()
        CalcolaValoriMedi()

    }

    @IBAction func EuroClick(_ sender: UITextField) {

        CalcolaLitri()
        CalcolaValoriMedi()

    }

    @IBAction func KmClick(_ sender: UITextField) {

        CalcolaKmParziale()
        CalcolaValoriMedi()

    }

    func CalcolaLitri(){

        if (LblEuro.text == "") || (LblEuroLitro.text == "") {
            //Valori non inseriti
        }else{

            let f_Euro:Float = Float.init(LblEuro.text!.replacingOccurrences(of: ",", with: "."))!
            let f_EuroLitro:Float =  Float.init(LblEuroLitro.text!.replacingOccurrences(of: ",", with: "."))!

            let f_Litri :Float = f_Euro / f_EuroLitro

            LblLitri.text  = String(format: "%.2f",f_Litri)
            Litri = String(format: "%.2f",f_Litri)
            LblLitri.text  = LblLitri.text?.replacingOccurrences(of: ".", with: ",")

        }
    }

    func CalcolaKmParziale(){

        if (LblKmTot.text != ""){

            let f_kmPrecedenti:Int = Int.init(kmPrecedenti)!
            let f_KmTot:Int = Int.init(LblKmTot.text!)!

            let f_KmParziale:Int = f_KmTot - f_kmPrecedenti

            LblKmParziali.text = String(f_KmParziale) + " Km Pariziali"

            KmParziali = String(f_KmParziale)

            //Colora se è negativo
            if (LblKmParziali.text?.contains("-") == true){
                LblKmTot.textColor = UIColor.red
            }else{
                LblKmTot.textColor = UIColor.black
            }
        }
    }

    func CalcolaValoriMedi(){

        if (LblKmTot.text != "" && LblEuroLitro.text != "" && KmParziali != "0" && LblLitri.text != ""){

            let f_Litri:Float = Float.init(LitriCalcolo.replacingOccurrences(of: ",", with: "."))!
            let f_KmParziali:Float = Float.init(KmParzialiCalcolo)!
            let f_Euro:Float = Float.init(LblEuro.text!.replacingOccurrences(of: ",", with: "."))!

            let f_Litri100Km = (f_Litri * 100) / f_KmParziali

            Litri100Km =  String(format: "%.2f",f_Litri100Km)

            LblLitri100Km.text = Litri100Km + " l/100Km"

            let f_EuroKm =  f_Euro / f_KmParziali

            EuroKm =  String(format: "%.3f",f_EuroKm)
        }

    }

    @IBAction func SaveClick(_ sender: UIBarButtonItem) {

        CalcolaLitri()
        CalcolaKmParziale()

        //Controlla la compilazione dei campi
        if (LblKmTot.text != "" && LblEuroLitro.text != "" && LblEuro.text != "" && LblKmParziali.text?.contains("-") == false) {

            CalcolaValoriMedi()

            let MySqlCls: MySql = MySql.init()

            if (IsNewRecord == true){

                MySqlCls.InsertNewRecord(ID: "", Data:  Data!, KmParziali: KmParziali, KmTot: LblKmTot.text!, Litri: LblLitri.text!, EuroKm: EuroKm, Litri100Km: Litri100Km, EuroLitro: LblEuroLitro.text!, Euro: LblEuro.text!, Parziale: Parziale)

                print("Insert")
            }else{
                
                MySqlCls.UpdateRecord(ID: IDRecord, Data:  Data!, KmParziali: KmParziali, KmTot: LblKmTot.text!, Litri: LblLitri.text!, EuroKm: EuroKm, Litri100Km: Litri100Km, EuroLitro: LblEuroLitro.text!, Euro: LblEuro.text!, Parziale: Parziale)
                
                print("Update")
            }
            
            self.removeAnimate()
            
        }else{
            
            print("Mancano dati!")
            
        }
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        
        self.removeAnimate()
        print("Annulla")
    }
}
