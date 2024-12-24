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
    
    func configureCell(title: String, type:String, progress: Int) {
        goalTitle.text = title
        goalType.text = type
        goalProgress.text = String(describing: progress)
    }
}
