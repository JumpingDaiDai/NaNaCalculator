//
//  CalculateBrain.swift
//  NaNaCalculator
//
//  Created by DaiDai on 2021/4/26.
//  Copyright © 2021 NaDaiCompany. All rights reserved.
//

import UIKit

class CalculateBrain: CalculatorViewControllerDataSource, CalculatorViewControllerDelegate {
    
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
    
    var nowNumber: Double = 0.0
    
    
    func textForCalculationView() -> String {
        let floorNumber = Double(String(format: "%.0f", nowNumber))
        if nowNumber == floorNumber {
            return "\(String(format: "%.0f", nowNumber))"
        } else {
            return "\(nowNumber)"
        }
    }
    
    func buttonDidSelected(buttonTag: Int) {
        
        let buttonCategory = ButtonCategory.setTag(index: buttonTag)

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
//        let inputNumber = number
//        var displayText = calculationView.text ?? ""
//
//        if isNew { // 新的運算時
//            // 直接將輸入的數字，設定給顯示的字串
//            displayText = "\(inputNumber)"
//            isNew = false
//        } else { // 不是新的運算   (底下程式碼還沒搞懂邏輯，所以就照著你的寫，不下註解了)
//            if displayText == "0" || calculationSymbol != "" {
//                displayText = "\(inputNumber)"
//                calculationSymbol = ""
//            } else {
//                displayText = displayText + "\(inputNumber)"
//            }
//        }
//        nowNumber = Double(displayText) ?? 0
    }
    
    // 處理運算子
    func operatorHandle(index: Int) {
        
//        guard index == 11, index == 12, index == 13, index == 14 else { return }
//
////        if previousNunber != 0 {
////
////            nowAnswer()
////        }
////        isCalculation = true
////        isNew = false
//
//        switch index {
//        case 11:
////            calculationSymbol = "+"
////            operation = .plus
//        case 12:
////            calculationSymbol = "-"
////            operation = .minus
//        case 13:
////            calculationSymbol = "x"
////            operation = .multiply
//        case 14:
////            calculationSymbol = "/"
////            operation = .division
//        default:
//            break;
//        }
    }
    
    // 處理功能鍵
    func functionHanle(index: Int) {
//        switch index {
//        case 21:
//            // 呼叫 clean function
//            break
//        case 22:
//            // 呼叫 deleate function
//            break
//        default:
//            break;
//        }
    }
    
}
