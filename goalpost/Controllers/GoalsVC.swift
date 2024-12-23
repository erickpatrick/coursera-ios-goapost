//
//  GoalsVC.swift
//  goalpost
//
//  Created by Erick Rocha on 23.12.24.
//

import UIKit

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNewGoalWasPressed(_ sender: Any) {
        print("button was pressed")
    }
}

