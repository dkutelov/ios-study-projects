//
//  ViewController.swift
//  Calculator2
//

import UIKit

class CalculatorViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet var circleButtons: [UIButton]!
    @IBOutlet var operationButtons: [UIButton]!
    @IBOutlet var mainView: UIView!
    
    //MARK: - Properties
    var calculatorManager = CalculatorManager()
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpButtons()
        self.setColors()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setColors()
    }
    
    //MARK: - IBActions
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        sender.flash()
        
        if var buttonLabel = sender.currentTitle {
            if buttonLabel == "." && (calculatorManager.CurrentNumber == "" || calculatorManager.CurrentNumber == "-") {
                buttonLabel = "0."
            }
            
            calculatorManager.CurrentNumber = buttonLabel
            resultLabel.text = calculatorManager.CurrentNumber
        }
    }
    
    @IBAction func operationsButtonTapped(_ sender: UIButton) {
        guard calculatorManager.CurrentNumber != "" else {
            return
        }
        
        if let operationType = sender.currentTitle {
            
            resetOperationButtons()
            sender.backgroundColor = .systemYellow
            
            if calculatorManager.calculation.operation != nil || calculatorManager.calculation.result != nil{
                let interimResult = calculatorManager.execute()
                resultLabel.text = interimResult
                calculatorManager.resetValues()
                calculatorManager.calculation.firstNumber = Double(interimResult) ?? 0.0
                calculatorManager.numberState = .secondNumber
            }
            
            calculatorManager.setOperation(operationType)
        }
    }
    
    @IBAction func equalButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        resetOperationButtons()
        let result = calculatorManager.execute()
    
        if let error = calculatorManager.error {
            resultLabel.text = error
        } else {
            resultLabel.text = String(result)
        }
        
        calculatorManager.resetValues()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        changeBtnCollorOnTouch(sender, to: .darkGray)
        calculatorManager.resetValues()
        resetOperationButtons()
        resultLabel.text = "0"
    }
    
    
    @IBAction func plusMinusButtonTapped(_ sender: UIButton) {
        changeBtnCollorOnTouch(sender, to: .darkGray)
        calculatorManager.currentNumberChangeSign()
        resultLabel.text = calculatorManager.CurrentNumber
    }
    
    @IBAction func percentButtonTapped(_ sender: UIButton) {
        changeBtnCollorOnTouch(sender, to: .darkGray)
        guard calculatorManager.numberState == .secondNumber else {
            return
        }
        
        var currentNumber = Double(calculatorManager.CurrentNumber) ?? 0.0
        currentNumber /= 100
        resultLabel.text = String(currentNumber)
        calculatorManager.resetCurrentNumber()
        for ch in String(currentNumber) {
            calculatorManager.CurrentNumber = String(ch)
        }
        
    }
    
    @IBAction func deleteBackwardsButtonTapped(_ sender: UIButton) {
        calculatorManager.deleteBackwards()
        if calculatorManager.CurrentNumber != "" {
            resultLabel.text = calculatorManager.CurrentNumber
        } else {
            resultLabel.text = "0"
        }
     }
    
    
    
    //MARK: - Private Methods
    private func setColors() {
        let tabbar = tabBarController as! BaseTabBarController

        mainView.backgroundColor = tabbar.calculatorBackgroundColor
        resultLabel.textColor = tabbar.calculatorLabelTextColor
        circleButtons.forEach {
            $0.tintColor = tabbar.calculatorButtonTintColor
        }
        zeroButton.tintColor = tabbar.calculatorButtonTintColor
    }
    
    private func changeBtnCollorOnTouch(_ sender: UIButton, to color: UIColor) {
        let buttonOrginalColor = sender.backgroundColor
        sender.backgroundColor = color
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            sender.backgroundColor = buttonOrginalColor
        }
        
    }
    
    private func setUpButtons() {
        circleButtons.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.layer.masksToBounds = true
            $0.tintColor = .white
        }
    }
    
    private func resetOperationButtons() {
        operationButtons.forEach {
            $0.backgroundColor = .systemOrange
        }
    }
}


