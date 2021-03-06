//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Tyler Bailey on 1/31/17.
//  Copyright © 2017 Tyler Bailey. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>?
    {
        didSet{
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>?
    {
        if let fahrenheitValue = fahrenheitValue{
            return fahrenheitValue.converted(to: .celsius)
        }
        else{
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view")
        
        updateCelsiusLabel()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        if let text = textField.text, let number = numberFormatter.number(from: text){
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        }
        else{
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel()
    {
        if let celsiusValue = celsiusValue{
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }
        else{
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField:UITextField,shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{

        let currentLocale = Locale.current
        let decimalSeperator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeperator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeperator)
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil{
            return false
        }
        else{
            return true
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        darkMode()
    }
    
    //Silver Challange : Dark Mode
    func darkMode()
    {
        let hour = Calendar.current.component(.hour, from: Date())
        if (hour > 18 || hour < 6) {
            view.backgroundColor = UIColor.darkGray
        } else {
            view.backgroundColor = UIColor.lightGray
        }
    }
}
