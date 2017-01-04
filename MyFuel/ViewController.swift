//
//  ViewController.swift
//  MyFuel
//
//  Created by Luca Storer on 26/09/16.
//  Copyright © 2016 Luca Storer. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    @IBOutlet weak var ViewChart: UIView!
    @IBOutlet weak var TableStat: UITableView!

    var MySqlCls:MySql?

    var items: [(String, Date,String,String,String,String,String,String,String,String)] = []
    var ItemsStat: [(String, String,String, String,String, String,String)] = [

    ]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    //    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)


      //   self.activityIndicatorView = activityIndicatorView

        self.activityIndicatorView.hidesWhenStopped = true

        self.activityIndicatorView.startAnimating()

              MySqlCls=MySql.init()

        MySqlCls?.GetStatData()

        ItemsStat = (MySqlCls?.v_StatTable)!

        print("Refresh ViewStat")
        TableStat.reloadData()

        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.isHidden = true

         }


    override func viewDidLoad() {
        super.viewDidLoad()


        let nib = UINib(nibName: "CustomStatCell", bundle: nil)

        TableStat.register(nib, forCellReuseIdentifier: "customCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemsStat.count;
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:CustomStatCell = self.TableStat.dequeueReusableCell(withIdentifier: "customCell") as! CustomStatCell

        // this is how you extract values from a tuple
        let (KmTot,Litri,Litri_100Km,Km_Litri,Euro_Litro,Euro_Km,KM_Year) = ItemsStat[(indexPath as NSIndexPath).row]

        cell.loadItem(KmTot: KmTot,Litri: Litri,Litri_100Km: Litri_100Km,Km_Litri: Km_Litri,Euro_Litro: Euro_Litro,Euro_Km: Euro_Km,KMYear: KM_Year)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        print("You selected cell #\((indexPath as NSIndexPath).row)!")

        //        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("Canti") as! ViewListCanti
        //
        //        vc.Tipo=ViewListCanti.TipoPreparazione.Eucarestia
        //        vc.ListaPreparazione=items
        //        vc.RowSelIndex = indexPath.row
        //
        //        self.showViewController(vc, sender: ViewEucarestia())
        //
    }

    @IBAction func AddValueClick(_ sender: UIBarButtonItem){

        let dest = self.storyboard?.instantiateViewController(withIdentifier: "ViewNewValue") as! ViewNewValue

        MySqlCls?.GetAllData()
        items = (MySqlCls?.historyTable)!

        dest.kmPrecedenti = (items.first?.2)!
        
        self.addChildViewController(dest)
        dest.view.frame = self.view.frame
        self.view.addSubview(dest.view)
        dest.didMove(toParentViewController: self)
        
    }
}

