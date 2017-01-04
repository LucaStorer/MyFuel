//
//  CustomValueCell.swift
//  MyFuel
//
//  Created by Luca Storer on 26/09/16.
//  Copyright © 2016 Luca Storer. All rights reserved.
//

import UIKit

class CustomValueCell: UITableViewCell {

    var IDRecord:String="0"

    @IBOutlet weak var LblDate: UILabel!
    @IBOutlet weak var LblKmParziali: UILabel!
    @IBOutlet weak var LblKmTot: UILabel!
    @IBOutlet weak var LblLitri: UILabel!
    @IBOutlet weak var LblEuroKm: UILabel!
    @IBOutlet weak var LblLitri100Km: UILabel!
    @IBOutlet weak var LblEuroLitro: UILabel!
    @IBOutlet weak var LblEuro: UILabel!

    @IBOutlet weak var ImgIconParziale: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadItem(ID: String, Date: Date, KmParziali: String,KmTot: String,Litri: String,EuroKm: String,Litri100Km: String,EuroLitro: String,Euro: String, Parziale: String)
    {

        IDRecord = ID
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none

        LblDate.text = dateFormatter.string(from: Date)
        LblKmParziali.text=KmParziali + " Km Percorsi"
        LblKmTot.text=KmTot + " Km Totali"
        LblLitri.text=Litri + " litri"
        LblEuroKm.text=EuroKm + " €/Km"
        LblLitri100Km.text=Litri100Km + " l/100Km"
        LblEuroLitro.text=EuroLitro + " €/l"
        LblEuro.text=Euro + " €"

        //Colora se è negativo
        if (LblKmParziali.text?.contains("-") == true){
            LblKmTot.textColor = UIColor.red
        }else{
            LblKmTot.textColor = UIColor.black
        }

        if Parziale == "1" {
            LblLitri100Km.text = "Parziale"
            LblLitri100Km.textColor = UIColor.gray
            ImgIconParziale.alpha = 1.0

        }else{
             LblLitri100Km.textColor = UIColor.black
            ImgIconParziale.alpha = 0.0

        }
    }


}
