//
//  AsteroidDetailViewController.swift
//  Asterank
//
//  Created by Sascha Müllner on 25.01.16.
//  Copyright © 2016 Sascha Muellner. All rights reserved.
//

import UIKit

class AsteroidDetailViewController: UITableViewController {
    var asteroid :Asteroid?
    @IBOutlet weak var asteroidClassLabel: UILabel!
    @IBOutlet weak var asteroidTypeLabel: UILabel!
    @IBOutlet weak var closenessLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var profitLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        self.title = self.asteroid!.fullName
        self.asteroidClassLabel.text = String(self.asteroid!.asteroidClass)
        self.asteroidTypeLabel.text = String(self.asteroid!.asteroidType)
        self.closenessLabel.text = String(self.asteroid!.closeness)
        self.priceLabel.text = String(self.asteroid!.price)
        self.profitLabel.text = String(self.asteroid!.profit)
    }
}
