//
//  CreateGoalVC.swift
//  goalpost
//
//  Created by Erick Rocha on 24.12.24.
//

import UIKit

class CreateGoalVC: UIViewController {
    
    @IBOutlet weak var goalLongType: UIButton!
    @IBOutlet weak var goalShortType: UIButton!
    @IBOutlet weak var goalTitle: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    var goalType: GoalType = .ShortTerm

    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.bindtoKeyboard()
        goalShortType.setSelectedColor()
        goalLongType.setDeselectedColor()
    }
    
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismissDetail(self)
    }
    
    @IBAction func onLongTypePressed(_ sender: Any) {
        goalType = .LongTerm
        goalShortType.setDeselectedColor()
        goalLongType.setSelectedColor()
    }
    
    @IBAction func onShortTypePressed(_ sender: Any) {
        goalType = .ShortTerm
        goalShortType.setSelectedColor()
        goalLongType.setDeselectedColor()
    }
    
    @IBAction func onNextPressed(_ sender: Any) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
