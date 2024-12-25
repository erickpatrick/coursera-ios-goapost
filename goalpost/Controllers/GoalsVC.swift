//
//  GoalsVC.swift
//  goalpost
//
//  Created by Erick Rocha on 23.12.24.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createGoal: UIButton!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetch(completion: {(complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        })
        tableView.reloadData()
    }
    
    @IBAction func addNewGoalWasPressed(_ sender: Any) {
        guard let createGoalsVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return
        }
        
        createGoalsVC.modalPresentationStyle = .fullScreen
        
        presentDetail(createGoalsVC)
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {
            return UITableViewCell()
        }
        
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        
        return cell
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
            completion(false)
        }
    }
}
