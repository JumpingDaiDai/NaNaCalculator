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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        if let number = calculationView.text,
            let stringToDouble = Double(number) {
            
            let percentNumber = stringToDouble / 100
            calculationView.text = "\(percentNumber)"
            nowNumber = Double(percentNumber)
            isCalculation = true
            isNew = false
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        
        guard let number = calculationView.text else { return }
        print("\n原始text = \(number)")
        
        if number.count == 1 {
            
            calculationView.text = "0"
            isCalculation = false
            isNew = true
            nowNumber = nil
        }
        else if number.contains("e") {
            
            calculationView.text = "0"
            isCalculation = false
            isNew = true
            nowNumber = nil
        } else {
            
            let deleteNumber = number.dropLast()
            calculationView.text = "\(deleteNumber)"
            nowNumber = Double(deleteNumber)
        }
    }
    
    @IBAction func pointButton(_ sender: UIButton) {
        
        guard let number = calculationView.text else { return }
        guard !number.contains(".") else { return }
        
        calculationView.text = number + "."
        isNew = false
    }
 
    
    @IBAction func numberButton(_ sender: UIButton) {
        numberButtonByDai(sender)
    }
    
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
        
        if displayText.count > 13 { return }
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
}

