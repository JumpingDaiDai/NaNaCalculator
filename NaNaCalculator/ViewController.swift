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
    var calculationSymbol : String = "" {
        didSet {
            print("calculationSymbol = \(calculationSymbol)")
        }
    }
    //紀錄目前數字
    var nowNumber : Double? {
        
        didSet {
            print("nowNumber: \(nowNumber)")
            
            guard let nowNumber = nowNumber else { return }
//            displayHandle(number: nowNumber)
            
        }
    }
    //紀錄上一個數字
    var previousNunber : Double? {
        didSet {
            print("previousNunber: \(previousNunber)")
        }
    }
    //紀錄是否計算中
    var isCalculation : Bool = false {
        didSet {
//            print("isCalculation = \(isCalculation)")
        }
    }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let number = scientificNotationToNumber(number: 1.12e+15)
        print("number = \(number)")
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        
        calculationView.text = "0"
        calculationSymbol = ""
        nowNumber = nil
        previousNunber = nil
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
//            okAnswerString(from: nowNumber)
            isCalculation = true
            isNew = false
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        
        guard let number = calculationView.text else { return }
        
        if number.count == 1 {
            
            calculationView.text = "0"
        } else {
            
            guard let stringToDouble = Double(number.dropLast()) else { return }
            nowNumber = stringToDouble
//            okAnswerString(from: nowNumber)
        }
        
        isCalculation = true
        isNew = false
    }
    
    @IBAction func pointButton(_ sender: UIButton) {
        
        // calculationView 中沒有 "." => 就能輸入 "."
        // calculationView 中有 "." => 不處理
        guard let number = calculationView.text else { return }
        guard !number.contains(".") else { return }
        
        calculationView.text = number + "."
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
    
    /* 可以這樣子做整理
    // Button 的類別
    enum ButtonCategory {
        // 1 ~ 9
        case Number(Int)
        // +: 11, -: 12, x: 13, /: 14
        case Operator(Int)
        // clean: 21, delete: 22, %: 23, =: 24
        case Function(Int)
        // none define
        case None
        
        static func setTag(index: Int) -> ButtonCategory {
            
            if index >= 1 && index <= 9 {
                return .Number(index)
            } else if index >= 11 && index <= 14 {
                return .Operator(index)
            } else if index >= 21 && index <= 24 {
                return .Function(index)
            } else {
                return .None
            }
        }
    }
    
    
    // 所有按鈕的clicked事件
    @IBAction func allButtonClicked(_ sender: UIButton) {
        
        let buttonCategory = ButtonCategory.setTag(index: sender.tag)
        
        switch buttonCategory {
        case .Number(let number):
            numberHandle(number: number)
            
        case .Operator(let index):
            operatorHandle(index: index)
            
        case .Function(let index):
            functionHanle(index: index)
            
        case .None:
            return
        }
    }
    
    // 處理數字
    func numberHandle(number: Int) {
        let inputNumber = number
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
        nowNumber = Double(displayText) ?? 0
    }
    
    // 處理運算子
    func operatorHandle(index: Int) {
        
        guard index == 11, index == 12, index == 13, index == 14 else { return }
        
        if previousNunber != 0 {
            
            nowAnswer()
        }
        isCalculation = true
        isNew = false
        
        switch index {
        case 11:
            calculationSymbol = "+"
            operation = .plus
        case 12:
            calculationSymbol = "-"
            operation = .minus
        case 13:
            calculationSymbol = "x"
            operation = .multiply
        case 14:
            calculationSymbol = "/"
            operation = .division
        default:
            break;
        }
    }
    
    // 處理功能鍵
    func functionHanle(index: Int) {
        switch index {
        case 21:
            // 呼叫 clean function
            break
        case 22:
            // 呼叫 deleate function
            break
        default:
            break;
        }
    }
     */
    
    
    func numberButtonByDai(_ sender: UIButton) {
       
        let inputNumber = sender.tag
        var displayText = calculationView.text ?? ""
        
        if isNew { // 新的運算時
            // 直接將輸入的數字，設定給顯示的字串
            displayText = "\(inputNumber)"
            isNew = false
        } else { // 不是新的運算   (底下程式碼還沒搞懂邏輯，所以就照著你的寫，不下註解了)
            if calculationSymbol != "" {
                displayText = "\(inputNumber)"
                calculationSymbol = ""
            } else {
                displayText = displayText + "\(inputNumber)"
            }
        }
        // 若超過13位則不允許輸入
        if displayText.count > 13 { return }
        calculationView.text = displayText
        print("displayText = \(displayText)")
        nowNumber = Double(displayText) ?? 0
    }
    
    // MARK: (00)
    @IBAction func number00Button(_ sender: UIButton) {
        
        var displayText = calculationView.text ?? ""
        
        if !isNew {
            if calculationSymbol != "" {
                displayText = ""
                calculationSymbol = ""
            } else {
                displayText = displayText + "00"
            }
        }
//        }
        
        calculationView.text = displayText
        nowNumber = Double(displayText) ?? 0
        
        
    }
    
    // MARK: (/)
    @IBAction func divisionButton(_ sender: UIButton) {
        
        if nowNumber != nil {
            calculate()
            calculationSymbol = "/"
            previousNunber = nowNumber
            isCalculation = true
            isNew = false
            operation = OperationType.division
        }
        
    }
    
    // MARK: (x)
    @IBAction func multiplyButton(_ sender: UIButton) {
        
        if nowNumber != nil {
            calculate()
            calculationSymbol = "X"
            previousNunber = nowNumber
            isCalculation = true
            isNew = false
            operation = OperationType.multiply
        }
        
    }
    
    // MARK: (-)
    @IBAction func minusButton(_ sender: UIButton) {
        
        if nowNumber != nil {
            calculate()
            calculationSymbol = "-"
            previousNunber = nowNumber
            isCalculation = true
            isNew = false
            operation = OperationType.minus
        }
    }
    
    // MARK: (+)
    @IBAction func plusButton(_ sender: UIButton) {
        
        if nowNumber != nil {
            calculate()
            calculationSymbol = "+"
            previousNunber = nowNumber
            isCalculation = true
            isNew = false
            operation = OperationType.plus
        }
    }
    
    // MARK: (=)
    @IBAction func equalButton(_ sender: UIButton) {
        
        print("a=\(previousNunber) b=\(nowNumber) operation=\(operation)")
        
        if isCalculation == true {
            
            // 計算
            calculate()
            
            isCalculation = false
            isNew = true
        }
        previousNunber = nil
    }
    
    
    // 已移到 nowNumber didSet 中做處理
//    func okAnswerString(from number: Double) {
//
//        var okText: String
//        if floor(number) == number {
//
//            okText = "\(String(format: "%.0f", number))"
//        }else {
//
//            okText = "\(number)"
//        }
//
//        // TODO: 這裡有bug
//        if okText.count >= 7 {
//
//            okText = String(okText.prefix(7))
//        }
//
//        calculationView.text = okText
//    }
    
//    func nowAnswer() {
        
//        switch operation {
//
//        case .division:
//            if nowNumber != 0 {
//
//                nowNumber = previousNunber / nowNumber
//            } else {
//
//                calculationView.text = "不可除以0"
//            }
//            okAnswerString(from: nowNumber)
//        case .multiply:
//            nowNumber = previousNunber * nowNumber
//            okAnswerString(from: nowNumber)
//        case .minus:
//            nowNumber = previousNunber - nowNumber
//            okAnswerString(from: nowNumber)
//        case .plus:
//            nowNumber = previousNunber + nowNumber
//            okAnswerString(from: nowNumber)
//        case .none:
//            calculationView.text = ""
//
//        }
//    }
    
    
    // 計算
    func calculate() {
        
        print("\n計算:")
        print("previousNunber: \(previousNunber)")
        print("nowNumber: \(nowNumber)")
        print("operation: \(operation)\n")
        
        var inCalculation : Double = 0
        guard let previousNunber = previousNunber else { return }
        guard let number = nowNumber else { return }
        switch operation {
           
        case .division:
            
            if nowNumber != 0 {
                
                inCalculation = previousNunber / number
                displayHandle(number: inCalculation)
                nowNumber = inCalculation
            } else {
                calculationView.text = "不可除以0"
            }
            
        case .multiply:
            inCalculation = previousNunber * number
            displayHandle(number: inCalculation)
            nowNumber = inCalculation
            
        case .minus:
            inCalculation = previousNunber - number
            displayHandle(number: inCalculation)
            nowNumber = inCalculation
            
        case .plus:
            inCalculation = previousNunber + number
            displayHandle(number: inCalculation)
            nowNumber = inCalculation
            
        case .none:
            calculationView.text = ""
        }
        print("calculate nowNumber = \(nowNumber)")
        
    }
    
    // 顯示 Number 的處理
    func displayHandle(number: Double) {
        
        var numberStr = String(format:"%g", number)
        //超過13位以科學記號顯示
        if numberStr.count > 13 {
            numberStr = transformScientificNotation(number: number)
            
        }
        calculationView.text = numberStr
        
    }
    
    //位數過多時轉換為科學記號
    func transformScientificNotation(number: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.###E+0"
        formatter.positiveFormat = "0.###E-0"
        formatter.exponentSymbol = "e"
        if let scientificFormatted = formatter.string(for: number) {
            return scientificFormatted
        } else { return "" }
    }
    
    //刪除整數時小數點後的顯示
    //此function可用"%g"取代
    /*
    func zeroFloatHandle(number: Double) -> String {
        
        // 若數字為整數時，不顯示小數點
        // 四捨五入到整數位
        let floorNumber = Double(String(format: "%.0f", number)) ?? 0
        print("floorNumber = \(floorNumber)")
        // 判斷 "四捨五入後的數字" 與 "原本數字" 是否相同
        if number == floorNumber {
            return String(format: "%.0f", number)
        } else {
            return "\(number)"
        }
    }
     */
    
    //將科學記號轉回數字
    func scientificNotationToNumber(number: Double) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let finalNumber = numberFormatter.number(from: "\(number)")
        let numberStr = String("\(finalNumber)")
        return numberStr
    }
}

