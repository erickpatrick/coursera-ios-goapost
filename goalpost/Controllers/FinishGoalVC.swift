//
//  FinishGoalVC.swift
//  goalpost
//
//  Created by Erick Rocha on 25.12.24.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var createGoal: UIButton!
    @IBOutlet weak var target: UITextField!
    @IBOutlet weak var backButton: UIButton!
    
    var goalDescription: String!
    var type: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target.delegate = self
        createGoal.bindtoKeyboard()
    }
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.type = type
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismissDetail(self)
    }
    
    @IBAction func onCreateGoalPressed(_ sender: Any) {
    }
}
