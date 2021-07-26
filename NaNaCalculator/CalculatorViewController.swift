//
//  CalculatorViewController.swift
//  NaNaCalculator
//
//  Created by DaiDai on 2021/4/26.
//  Copyright © 2021 NaDaiCompany. All rights reserved.
//

import UIKit

//// Button 的類別
//enum ButtonCategory {
//    // 1 ~ 9
//    case Number(Int)
//    // +: 11, -: 12, x: 13, /: 14
//    case Operator(Int)
//    // clean: 21, delete: 22, %: 23, =: 24
//    case Function(Int)
//    // none define
//    case None
//
//    static func setTag(index: Int) -> ButtonCategory {
//
//        if index >= 1 && index <= 9 {
//            return .Number(index)
//        } else if index >= 11 && index <= 14 {
//            return .Operator(index)
//        } else if index >= 21 && index <= 24 {
//            return .Function(index)
//        } else {
//            return .None
//        }
//    }
//}



protocol CalculatorViewControllerDataSource: class {
    func textForCalculationView() -> String
}

protocol CalculatorViewControllerDelegate: class {
    func buttonDidSelected(buttonTag: Int)
}

class CalculatorViewController: UIViewController {

    @IBOutlet weak var calculationView: UILabel!
    
    weak var dataSource: CalculatorViewControllerDataSource?
    weak var delegate: CalculatorViewControllerDelegate?
    
    var calculateBrain: CalculateBrain = CalculateBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = calculateBrain
        delegate = calculateBrain
    }
    
    // MARK: Button action
    @IBAction func allButtonClicked(_ sender: UIButton) {
        
        delegate?.buttonDidSelected(buttonTag: sender.tag)
        
        calculationView.text = dataSource?.textForCalculationView()
    }
}
