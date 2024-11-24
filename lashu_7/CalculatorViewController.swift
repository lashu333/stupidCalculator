//
//  CalculatorViewController.swift
//  lashu_7
//
//  Created by Lasha Tavberidze on 23.11.24.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstVariable: UITextField!
    @IBOutlet weak var secondVariable: UITextField!
    @IBOutlet weak var segmentedOperations: UISegmentedControl!
    @IBOutlet weak var calculatedValue: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var horizontalSlider: UISlider!
    let toolBar = UIToolbar()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTextFields()
        setUpToolBar()
    }
    private func setUpToolBar(){
        toolBar.sizeToFit()
        let nextButton = UIBarButtonItem(title: "next", style: .plain, target: self, action: #selector(nextButtonTapped))
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [nextButton, doneButton]
        
        firstVariable.inputAccessoryView = toolBar
        secondVariable.inputAccessoryView = toolBar
    }
    @IBAction func didTapCalculateButton(_ sender: UIButton) {
        let firstValue = Double(firstVariable.text!) ?? 0
        let secondValue = Double(secondVariable.text!) ?? 0
        guard let operation = Operation(rawValue: segmentedOperations.selectedSegmentIndex)
        else { return }
        let result = operation.perform( firstValue, secondValue)
        calculatedValue.text = String(result)
    }
    
    @IBAction func didSlideSlider(_ sender: UISlider) {
        let value = Int(sender.value)
        calculatedValue.font = .systemFont(ofSize: CGFloat(value + 19))
    }
    private func setUpTextFields(){
        firstVariable.delegate = self
        secondVariable.delegate = self
        
        firstVariable.keyboardType =  .decimalPad
        secondVariable.keyboardType = .decimalPad
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        if string == "," {
            return !(textField.text?.contains(",") ?? false)
        }
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
        
    }
    @objc private func nextButtonTapped(){
        if firstVariable.isFirstResponder{
            secondVariable.becomeFirstResponder()
        } else{
            dismissKeyboard()
        }
    }
    @objc private func doneButtonTapped(){
        dismissKeyboard()
    }
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
}

