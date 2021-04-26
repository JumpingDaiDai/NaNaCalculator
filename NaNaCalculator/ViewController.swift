//
//  ViewController.swift
//  NaNaCalculator
//
//  Created by DaiDai on 2021/4/19.
//  Copyright © 2021 NaDaiCompany. All rights reserved.
//

import UIKit

// TODO: Int 能裝的位數不足，會在轉型時閃退
// 可以用這取代轉整數的處理 => String(format: "%.0f", nowNumber)




class ViewController: UIViewController {
    
    //紀錄運算符號 (calculationSymbol = ""、"+"、"-"、"x"、"/")
    var calculationSymbol : String = ""
    //紀錄目前數字
    var nowNumber : Double = 0{
        didSet {
            
            
            let floorNumber = Double(String(format: "%.0f", nowNumber))
            if nowNumber == floorNumber {
                calculationView.text = "\(String(format: "%.0f", nowNumber))"
            } else {
                calculationView.text = "\(nowNumber)"
            }
            print("nowNumber: \(nowNumber)")
        }
    }
    //紀錄上一個數字
    var previousNunber : Double = 0 {
        didSet {
            print("previousNunber: \(previousNunber)")
        }
    }
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
        numberButtonByDai(sender)
//        let inputNumber = sender.tag
//
//
//        if let number = calculationView.text {
//
//            if isNew == true {
//
//                calculationView.text = "\(inputNumber)"
//                isNew = false
//            } else {
//
//                // calculationSymbol 不管等於什麼都會 進到 if 區塊
//                if calculationView.text == "0" || calculationSymbol != "" {
//
//                    calculationView.text = "\(inputNumber)"
//                    calculationSymbol = ""
//                } else {
//
//                    calculationView.text = number + "\(inputNumber)"
//                }
//            }
//
//           nowNumber = Double(number) ?? 0
//        }

    }
    
    func numberButtonByDai(_ sender: UIButton) {
        let inputNumber = sender.tag
        var displayText = calculationView.text ?? ""
        
        if isNew { // 新的運算時
            // 直接將輸入的數字，設定給顯示的字串
            displayText = "\(inputNumber)"
            isNew = false
        } else { // 不是新的運算   (底下程式碼還沒搞懂邏輯，所以就照著你的寫，不下註解了)
            if displayText == "0" || calculationSymbol != "" {
                displayText = "\(inputNumber)"
                calculationSymbol = ""
            } else {
                displayText = displayText + "\(inputNumber)"
            }
        }
        
//        calculationView.text = displayText
        nowNumber = Double(displayText) ?? 0
    }
    
    @IBAction func number00Button(_ sender: UIButton) {
        
        var displayText = calculationView.text ?? ""
        
        if isNew { // 新的運算時
            // 直接將輸入的數字，設定給顯示的字串
            displayText = ""
            isNew = false
        } else { // 不是新的運算   (底下程式碼還沒搞懂邏輯，所以就照著你的寫，不下註解了)
            if displayText == "0" || calculationSymbol != "" {
                displayText = ""
                calculationSymbol = ""
            } else {
                displayText = displayText + "00"
            }
        }
        
//        calculationView.text = displayText
        nowNumber = Double(displayText) ?? 0
        
        
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
        
        print("a=\(previousNunber) b=\(nowNumber) operation=\(operation)")
        
        if isCalculation == true {
            
            switch operation {
                
            case .division:
                
                if nowNumber != 0 {
                    
                    nowNumber = previousNunber / nowNumber
                    okAnswerString(from: nowNumber)

                } else {
                    
                    calculationView.text = "不可除以0"
                }
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
            
            okText = "\(String(format: "%.0f", number))"
        }else {
            
            okText = "\(number)"
        }
        
        // TODO: 這裡有bug
        if okText.count >= 7 {
            
            okText = String(okText.prefix(7))
        }
    
        calculationView.text = okText
    }
    
    func nowAnswer() {
        
        switch operation {
            
        case .division:
            if nowNumber != 0 {
                
                nowNumber = previousNunber / nowNumber
            } else {
                
                calculationView.text = "不可除以0"
            }
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

