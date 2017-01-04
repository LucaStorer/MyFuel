//
//  ViewRifornienti.swift
//  MyFuel
//
//  Created by Luca Storer on 26/09/16.
//  Copyright © 2016 Luca Storer. All rights reserved.
//

import UIKit

class ViewRifornienti: UIViewController,UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    @IBOutlet weak var TableViewFuel: UITableView!



    var items: [(String, Date,String,String,String,String,String,String,String,String)] = []
       // ("26 Set 2016", "640 Km Parziali","112.000 Km","63 l","0,6 €/Km","8,6 l/100 Km","1,229 €/l","65 €")

    let MySqlCls: MySql =  MySql()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

self.activityIndicatorView.startAnimating()

        MySqlCls.GetAllData()

        items = MySqlCls.historyTable

        print("Refresh ViewRifornimenti")
          TableViewFuel.reloadData()

     self.activityIndicatorView.stopAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Load ViewRifornimenti")

        let nib = UINib(nibName: "CustomValueCell", bundle: nil)

        TableViewFuel.register(nib, forCellReuseIdentifier: "CustomValueCell")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:CustomValueCell = self.TableViewFuel.dequeueReusableCell(withIdentifier: "CustomValueCell") as! CustomValueCell

        // this is how you extract values from a tuple
        let (ID,Date,KmTot,Litri,Km,Euro,EuroKm,EuroLitro,Litri100Km,Parziale) = items[(indexPath as NSIndexPath).row]

        cell.loadItem(ID: ID,Date: Date, KmParziali: Km,KmTot: KmTot,Litri: Litri,EuroKm: EuroKm,Litri100Km: Litri100Km,EuroLitro: EuroLitro,Euro: Euro, Parziale: Parziale)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You selected cell #\((indexPath as NSIndexPath).row)!")

        let dest = self.storyboard?.instantiateViewController(withIdentifier: "ViewNewValue") as! ViewNewValue

  let (ID,Date,KmTot,Litri,Km,Euro,EuroKm,EuroLitro,Litri100Km,Parziale) = items[(indexPath as NSIndexPath).row]

         let (p_ID,p_Date,p_KmTot,p_Litri,p_Km,p_Euro,p_EuroKm,p_EuroLitro,p_Litri100Km,p_Parziale) = items[(indexPath as NSIndexPath).row + 1]

        dest.IsNewRecord = false

        dest.IDRecord = ID

        print(p_KmTot)

        dest.kmPrecedenti = p_KmTot
        dest.Data = Date
        dest.KmTot = KmTot
        dest.Litri = Litri.replacingOccurrences(of: ".", with: ",")
        dest.Euro = Euro.replacingOccurrences(of: ".", with: ",")
        dest.EuroKm = EuroKm.replacingOccurrences(of: ".", with: ",")
        dest.EuroLitro = EuroLitro.replacingOccurrences(of: ".", with: ",")
        dest.Litri100Km = Litri100Km.replacingOccurrences(of: ".", with: ",")
        dest.Parziale = Parziale
        dest.KmParziali = Km

        let indexCell:Int = (indexPath as NSIndexPath).row + 1
        let i_Litri:Float = Float.init(Litri.replacingOccurrences(of: ",", with: "."))!
        let i_KmParziali:Int = Int(Km)!

        print ("Litri -> ", i_Litri)
        print("Km -> ", i_KmParziali)

        (dest.LitriCalcolo,dest.KmParzialiCalcolo) = CalcolaKmPrecedenti(Indx: indexCell, LitriPrecedenti: i_Litri, KmParziali: i_KmParziali)

        print ("Litri Calc -> ", dest.LitriCalcolo)
        print("Km Calc -> ", dest.KmParzialiCalcolo)

        print ("Km Prec -> ", p_KmTot)
        print("Km Parziali -> ", i_KmParziali)

        self.addChildViewController(dest)
        dest.view.frame = self.view.frame
        self.view.addSubview(dest.view)
        dest.didMove(toParentViewController: self)
    }

     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let MySqlCls: MySql = MySql.init()

            let CellSel:CustomValueCell = tableView.cellForRow(at: indexPath) as! CustomValueCell

            MySqlCls.RemoveRecord(RecordID: CellSel.IDRecord)

            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("delete")

        }
    }

    @IBAction func CmdRefreshClick(_ sender: UIBarButtonItem) {

        self.activityIndicatorView.startAnimating()

        MySqlCls.GetAllData()

        items = MySqlCls.historyTable

        print("Refresh ViewRifornimenti")
        TableViewFuel.reloadData()

         self.activityIndicatorView.stopAnimating()
    }


//    func confirmDelete(planet: String) {
//        let alert = UIAlertController(title: "Delete Planet", message: "Are you sure you want to permanently delete \(planet)?", preferredStyle: .actionSheet)
//
//        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: deleteOk)
//        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//
//        alert.addAction(DeleteAction)
//        alert.addAction(CancelAction)
//
//        // Support display in iPad
//        alert.popoverPresentationController?.sourceView = self.view
//        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
//
//        self.present(alert, animated: true, completion: nil)
//    }

    @IBAction func AddValueClick(_ sender: UIBarButtonItem){

        let dest = self.storyboard?.instantiateViewController(withIdentifier: "ViewNewValue") as! ViewNewValue

        //Verifica se è il primo record
        if (items.count == 0) {

            dest.kmPrecedenti = "0"

        }else{

            let (p_ID,p_Date,p_KmTot,p_Litri,p_Km,p_Euro,p_EuroKm,p_EuroLitro,p_Litri100Km,p_Parziale) = items[items.startIndex]

            let indexCell:Int = items.startIndex + 1
            let i_Litri:Float = 0.0 // Float.init(Litri.replacingOccurrences(of: ",", with: "."))!
            let i_KmParziali:Int = 0 //Int(p_KmTot)!

            dest.kmPrecedenti = (items.first?.2)!

            (dest.LitriCalcolo,dest.KmParzialiCalcolo) = CalcolaKmPrecedenti(Indx: indexCell, LitriPrecedenti: i_Litri, KmParziali: i_KmParziali)
    }

        self.addChildViewController(dest)
        dest.view.frame = self.view.frame
        self.view.addSubview(dest.view)
        dest.didMove(toParentViewController: self)
    }

    func CalcolaKmPrecedenti(Indx: Int,LitriPrecedenti:Float,KmParziali:Int) -> (String,String){

        var i_Litri:Float = LitriPrecedenti
        var i_KmParziali:Int = KmParziali

        let (p_ID,p_Date,p_KmTot,p_Litri,p_Km,p_Euro,p_EuroKm,p_EuroLitro,p_Litri100Km,p_Parziale) = items[Indx]

        if p_Parziale == "1" {

            i_Litri = LitriPrecedenti + Float.init(p_Litri.replacingOccurrences(of: ",", with: "."))!

            i_KmParziali = KmParziali + Int(p_Km)!

            let (ResLitri,ResKm) =  CalcolaKmPrecedenti(Indx: Indx + 1, LitriPrecedenti: i_Litri, KmParziali: i_KmParziali)

            return (ResLitri,ResKm)

        }else{

            print("Result -> ",LitriPrecedenti)
            print("Result -> ",KmParziali)
            
            return (String(format: "%.2f",LitriPrecedenti),String(KmParziali))
            
        }
    }
    }
