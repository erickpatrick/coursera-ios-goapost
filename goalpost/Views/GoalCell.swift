//
//  GoalCell.swift
//  goalpost
//
//  Created by Erick Rocha on 24.12.24.
//

import UIKit

class GoalCell: UITableViewCell {
    @IBOutlet weak var goalProgress: UILabel!
    @IBOutlet weak var goalTitle: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    func configureCell(goal: Goal) {
        goalTitle.text = goal.title
        goalType.text =  goal.type
        goalProgress.text = String(describing: goal.progress)
        
        if goal.progress == goal.target {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
}
