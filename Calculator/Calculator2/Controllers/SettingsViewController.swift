//
//  SettingsViewController.swift
//  Calculator2
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    @IBOutlet weak var colorOfSegmentControl: UISegmentedControl!
    
    //MARK: - Properties
    var colorSetting = ColorSettings()
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.confirmButton.layer.cornerRadius = 5
        self.setConfirmButtonColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.colorSetting.changeColorOf = .background
        self.colorOfSegmentControl.selectedSegmentIndex = 0
        self.resetDefaults()
    }
    
    //MARK: - IBActions
    @IBAction func redColorSliderValueChange(_ sender: UISlider) {
        self.colorSetting.red = CGFloat(sender.value / 255)
        self.setConfirmButtonColor()
    }
    
    @IBAction func greenColorSliderValueChanged(_ sender: UISlider) {
        self.colorSetting.green = CGFloat(sender.value / 255)
        self.setConfirmButtonColor()
    }
    
    @IBAction func blueColorSliderValueChanged(_ sender: UISlider) {
        self.colorSetting.blue = CGFloat(sender.value / 255)
        self.setConfirmButtonColor()
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
        
        switch segmentIndex {
        case 0:
            self.colorSetting.changeColorOf = .background
        case 1:
            self.colorSetting.changeColorOf = .tint
        case 2:
            self.colorSetting.changeColorOf = .text
        default:
            break
        }
        
        self.resetDefaults()
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        let tabbar = tabBarController as! BaseTabBarController
        let newColor = UIColor(red: self.colorSetting.red, green: self.colorSetting.green, blue: self.colorSetting.blue, alpha: 1)
        switch self.colorSetting.changeColorOf {
        case .background:
            tabbar.calculatorBackgroundColor = newColor
        case .text:
            tabbar.calculatorLabelTextColor = newColor
        case .tint:
            tabbar.calculatorButtonTintColor = newColor
        }
        
        self.resetDefaults()
    }
    
    
    //MARK: - Private Methods
    private func setConfirmButtonColor() {
        confirmButton.backgroundColor = UIColor(red: self.colorSetting.red, green: self.colorSetting.green, blue: self.colorSetting.blue, alpha: 1.0)
    }
    
    private func resetDefaults() {
        self.redColorSlider.value = 1
        self.greenColorSlider.value = 1
        self.blueColorSlider.value = 1
        self.confirmButton.backgroundColor = .black
        
        self.colorSetting.red = 0
        self.colorSetting.green = 0
        self.colorSetting.blue = 0
    }
}

