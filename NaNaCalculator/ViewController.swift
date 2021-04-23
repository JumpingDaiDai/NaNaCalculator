//
//  ViewController.swift
//  NaNaCalculator
//
//  Created by DaiDai on 2021/4/19.
//  Copyright © 2021 NaDaiCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //紀錄運算符號 (calculationSymbol = ""、"+"、"-"、"x"、"/")
    var calculationSymbol : String = ""
    //紀錄目前數字
    var nowNumber : Double = 0
    //紀錄上一個數字
    var previousNunber : Double = 0
    //紀錄是否計算中
    var isCalculation : Bool = false
    //紀錄是否為新運算
    var isNew : Bool = true
    
    
    
    //運算種類
    enum OperationType {
        
        case plus
        case minus
        case multiply
        case division
        case none
    }
    //紀錄目前運算
    var operation : OperationType = .none
    
    @IBOutlet weak var calculationView: UILabel!
    @IBAction func clearButton(_ sender: UIButton) {
        
        calculationView.text = "0"
        calculationSymbol = ""
        nowNumber = 0
        previousNunber = 0
        isCalculation = false
        isNew = true
    }
    @IBAction func percentButton(_ sender: UIButton) {
        
        
        
//        // 不能解包時就 return
//        guard let number = calculationView.text else { return }
//        guard let stringToDouble = Double(number) else { return }
//
//        nowNumber = stringToDouble / 100
//        okAnswerString(from: nowNumber)
//        isCalculation = true
//        starNew = false

        
        if let number = calculationView.text,
            let stringToDouble = Double(number) {
            
            nowNumber = stringToDouble / 100
            okAnswerString(from: nowNumber)
            isCalculation = true
            isNew = false
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        
        
        guard let deleteNumber = calculationView.text else {return}
        
        if deleteNumber.count == 1 {
                
            calculationView.text = "0"
            } else {
                
            guard let stringToDouble = Double(deleteNumber.dropLast()) else {return}
            nowNumber = stringToDouble
            okAnswerString(from: nowNumber)
            }
        isCalculation = true
        isNew = false
        
    }
    @IBAction func pointButton(_ sender: UIButton) {
        
        // calculationView 中沒有 "." => 就能輸入 "."
        // calculationView 中有 "." => 不處理
        if let number = calculationView.text {
        
            if number.contains(".") {
                
                return
            } else {
                
                calculationView.text = number + "."
            }
        }
    }
    
 
    
    @IBAction func numberButton(_ sender: UIButton) {
        
        let inputNumber = sender.tag
        
            
        if let number = calculationView.text {
                
            if isNew == true {
                    
                calculationView.text = "\(inputNumber)"
                isNew = false
            } else {
                    
                // calculationSymbol 不管等於什麼都會 進到 if 區塊
                if calculationView.text == "0" || calculationSymbol != "" {
                        
                    calculationView.text = "\(inputNumber)"
                    calculationSymbol = ""
                } else {
                        
                    calculationView.text = number + "\(inputNumber)"
                }
            }
            
           nowNumber = Double(number) ?? 0
        }

    }
    
    @IBAction func number00Button(_ sender: UIButton) {
        
        guard let number = calculationView.text else {return}
        calculationView.text = number + "00"
        guard let stringToDouble = Double(number) else {return}
        nowNumber = stringToDouble
        isCalculation = true
        isNew = false
    }
    
    @IBAction func divisionButton(_ sender: UIButton) {
        
        if previousNunber != 0 {
            
            nowAnswer()
        }
        calculationSymbol = "/"
        previousNunber = nowNumber
        isCalculation = true
        isNew = false
        operation = OperationType.division
    }
    @IBAction func multiplyButton(_ sender: UIButton) {
        
        if previousNunber != 0 {
            
            nowAnswer()
        }
        calculationSymbol = "X"
        previousNunber = nowNumber
        isCalculation = true
        isNew = false
        operation = OperationType.multiply
    }
    @IBAction func minusButton(_ sender: UIButton) {
        
        if previousNunber != 0 {
            
            nowAnswer()
        }
        calculationSymbol = "-"
        previousNunber = nowNumber
        isCalculation = true
        isNew = false
        operation = OperationType.minus
    }
    @IBAction func plusButton(_ sender: UIButton) {
        
        if previousNunber != 0 {
            
            nowAnswer()
        }
        calculationSymbol = "+"
        previousNunber = nowNumber
        isCalculation = true
        isNew = false
        operation = OperationType.plus
    }
    @IBAction func equalButton(_ sender: UIButton) {
        
        if isCalculation == true {
            
            switch operation {
                
            case .division:
                nowNumber = previousNunber / nowNumber
                okAnswerString(from: nowNumber)
            case .multiply:
                nowNumber = previousNunber * nowNumber
                okAnswerString(from: nowNumber)
            case .minus:
                nowNumber = previousNunber - nowNumber
                okAnswerString(from: nowNumber)
            case .plus:
                nowNumber = previousNunber + nowNumber
                okAnswerString(from: nowNumber)
            case .none:
                calculationView.text = ""
            }
            isCalculation = false
            isNew = true
        }
        previousNunber = 0
    }
    
    func okAnswerString(from number: Double) {
        
        var okText: String
        if floor(number) == number {
            
            okText = "\(Int(number))"
        }else {
            
            okText = "\(number)"
        }
        
        if okText.count >= 7 {
            
            okText = String(okText.prefix(7))
        }
        calculationView.text = okText
    }
    
    func nowAnswer() {
        
        switch operation {
            
        case .division:
            nowNumber = previousNunber / nowNumber
            okAnswerString(from: nowNumber)
        case .multiply:
            nowNumber = previousNunber * nowNumber
            okAnswerString(from: nowNumber)
        case .minus:
            nowNumber = previousNunber - nowNumber
            okAnswerString(from: nowNumber)
        case .plus:
            nowNumber = previousNunber + nowNumber
            okAnswerString(from: nowNumber)
        case .none:
            calculationView.text = ""
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

