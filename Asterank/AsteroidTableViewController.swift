//
//  AsteroidTableViewController.swift
//  Asterank
//
//  Created by Sascha Müllner on 24.01.16.
//  Copyright © 2016 Sascha Muellner. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

class AsteroidTableViewController: UITableViewController {
    
    @IBOutlet weak var closenessTextField: UITextField!
    private let searchController = UISearchController(searchResultsController: nil)
    private var asteroids :[Asteroid] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup search bar
        self.definesPresentationContext = true
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Closeness"
        self.searchController.searchBar.keyboardType = UIKeyboardType.DecimalPad
        self.searchController.searchBar.keyboardAppearance = UIKeyboardAppearance.Dark
        self.tableView.tableHeaderView = self.searchController.searchBar
        // Add toolbar to UIKeyboard of searchBar
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Black
        toolBar.translucent = true
        toolBar.tintColor = UIColor.whiteColor()
        let doneButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Done, target: self, action: "searchPressed")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        toolBar.sizeToFit()
        self.searchController.searchBar.inputAccessoryView = toolBar
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.asteroids.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AsteroidIdentifier", forIndexPath: indexPath)
        let asteroid = self.asteroids[indexPath.row]
        cell.textLabel?.text = asteroid.fullName
        cell.detailTextLabel?.text = "Closeness \(asteroid.closeness), Profit \(asteroid.profit)"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueShowAsteroidDetail"{
            let asteroidDetailViewController = segue.destinationViewController as! AsteroidDetailViewController
            asteroidDetailViewController.asteroid = self.asteroids[self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
    func searchPressed(){
        self.searchController.searchBar.resignFirstResponder()
        view.endEditing(true)
        let alertView = SCLAlertView()
        alertView.showCloseButton = false
        alertView.showWait(NSLocalizedString("Load Asterank Data...", comment: "Load Asterank Data"), subTitle: "")
        let closeness = (self.searchController.searchBar.text! as NSString).floatValue
        Alamofire.request(.GET, "http://asterank.com/api/asterank", parameters: ["query": "{\"closeness\":{\"$lt\":\(closeness)}}", "limit": 1000])
            .responseArray { (response: Response<[Asteroid], NSError>) in
                if let asteroids = response.result.value {
                    self.asteroids = asteroids
                    self.tableView.reloadData()
                }
                alertView.hideView()
        }
    }
    
}
