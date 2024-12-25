//
//  FinishGoalVC.swift
//  goalpost
//
//  Created by Erick Rocha on 25.12.24.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var createGoal: UIButton!
    @IBOutlet weak var target: UITextField!
    @IBOutlet weak var backButton: UIButton!
    
    var goalTitle: String!
    var type: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target.delegate = self
        createGoal.bindtoKeyboard()
    }
    
    func initData(description: String, type: GoalType) {
        self.goalTitle = description
        self.type = type
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismissDetail(self)
    }
    
    @IBAction func onCreateGoalPressed(_ sender: Any) {
        if !target.text!.isEmpty {
            self.save { complete in
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let goal = Goal(context: managedContext)
        
        goal.title = self.goalTitle
        goal.type = self.type.rawValue
        goal.target = Int32(target.text!)!
        goal.progress = Int32(0)
        
        do {
            print("saved data")
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save \(error.localizedDescription)")
            completion(false)
        }
    }
}
