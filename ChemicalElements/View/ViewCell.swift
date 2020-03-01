//
//  ViewCell.swift
//  ChemicalElements
//
//  Created by John on 11/11/19.
//  Copyright © 2019 Abraham Shenghur. All rights reserved.
//

import UIKit


class ViewCell: UITableViewCell {
    
    let rowColor = [
        "nonmetal": #colorLiteral(red: 0.9985851645, green: 1, blue: 0.7785508037, alpha: 1),
        "alkali metal": #colorLiteral(red: 0.9954949021, green: 0.814659059, blue: 0.7970948219, alpha: 1),
        "alkaline earth metal": #colorLiteral(red: 0.8209429383, green: 0.8258636594, blue: 1, alpha: 1),
        "metalloid": #colorLiteral(red: 0.8781890273, green: 0.9300621152, blue: 0.7523515821, alpha: 1),
        "halogen": #colorLiteral(red: 0.6745478644, green: 1, blue: 0.7182191894, alpha: 1),
        "noble gas": #colorLiteral(red: 0.9984704852, green: 0.892721951, blue: 0.7551736236, alpha: 1),
        "transition metal": #colorLiteral(red: 0.769241631, green: 0.8644122481, blue: 0.9986781478, alpha: 1),
        "post-transition metal": #colorLiteral(red: 0.8543513417, green: 0.9996760488, blue: 0.8108127713, alpha: 1),
        "lanthanide": #colorLiteral(red: 0.7874277234, green: 0.9976893067, blue: 1, alpha: 1),
        "actinide": #colorLiteral(red: 0.8151629567, green: 0.9985678792, blue: 0.9197391868, alpha: 1)
    ]
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var atomicWeight: UILabel!
    @IBOutlet weak var category: UILabel!
}



