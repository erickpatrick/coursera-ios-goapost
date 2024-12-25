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
        
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch(completion: {(complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        })
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { rowAction, indexPath in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = .systemRed
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { rowAction, indexPath in
            self.increaseProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        addAction.backgroundColor = .systemOrange
        
        let decreaseAction = UITableViewRowAction(style: .normal, title: "Decrease 1") { rowAction, indexPath in
            self.decreaseProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        decreaseAction.backgroundColor = .systemTeal
        
        return [deleteAction, addAction, decreaseAction]
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
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not remove \(error.localizedDescription)")
        }
    }
    
    func increaseProgress(atIndexPath indexPath: IndexPath) {
        print("entered increaseProgress")
        updateProgress(by: 1, atIndexPath: indexPath)
    }
    
    func decreaseProgress(atIndexPath indexPath: IndexPath) {
        print("entered decreaseProgress")
        updateProgress(by: -1, atIndexPath: indexPath)
    }
    
    func updateProgress(by quantity: Int32, atIndexPath indexPath: IndexPath) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let chosenGoal = goals[indexPath.row]
        
        print("entered updateProgress")
        
        if chosenGoal.progress < chosenGoal.target {
            chosenGoal.progress += quantity
        } else if quantity == -1 && chosenGoal.progress > 0 {
            chosenGoal.progress += quantity
        } else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("could not update progress \(error.localizedDescription)")
        }
    }
}
