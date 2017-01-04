//
//  CustomStatCell.swift
//  MyFuel
//
//  Created by Luca Storer on 26/09/16.
//  Copyright © 2016 Luca Storer. All rights reserved.
//

import UIKit

class CustomStatCell: UITableViewCell {

    @IBOutlet weak var LblLitri100Km: UILabel!
    @IBOutlet weak var LblKmLitro: UILabel!
    @IBOutlet weak var LblLitri: UILabel!
    @IBOutlet weak var LblEuroLitro: UILabel!
    @IBOutlet weak var LblKmTot: UILabel!
    @IBOutlet weak var LblEuroKm: UILabel!
    @IBOutlet weak var LblKmYear: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadItem(KmTot:String,Litri:String,Litri_100Km:String,Km_Litri:String,Euro_Litro:String,Euro_Km:String,KMYear: String)
    {
        LblKmTot.text = KmTot
        LblLitri.text = Litri
        LblLitri100Km.text = Litri_100Km
        LblKmLitro.text = Km_Litri
        LblEuroLitro.text = Euro_Litro
        LblEuroKm.text = Euro_Km
        LblKmYear.text = KMYear + " Km Anno"

    }
}
