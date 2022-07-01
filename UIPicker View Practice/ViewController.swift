//
//  ViewController.swift
//  UIPicker View Practice
//
//  Created by Shien on 2022/7/1.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var colorPickerView: UIPickerView!
    
    let colorNames = ["red", "orange", "yellow", "green", "blue", "purple", "brown", "black", "white"]
    let colors = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.brown, UIColor.black, UIColor.white]
    
    var isFirstComponent = true
    var otherColorNames = ["orange", "yellow", "green", "blue", "purple", "brown", "black", "white"]
    var otherColors = [UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.brown, UIColor.black, UIColor.white]
    
    var pickerField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        setPickerField()
    }
    
    func setPickerField() {
        //產生 UIToolbar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: colorPickerView.bounds.height+20))
        
        //新增部見到 tool bar 裡
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "背景", style: .plain, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "中間色塊", style: .plain, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)]
        toolBar.sizeToFit()
        
        //將 text field 加到 super view 上
        view.addSubview(pickerField)
        
        //將 picker view 及 tool bar 加進 text field 裡
        pickerField.inputView = colorPickerView
        pickerField.inputAccessoryView = toolBar
        
        //叫出 text field
        pickerField.becomeFirstResponder()
    }
}
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isFirstComponent {
            if component == 0 {
                return colors.count
            } else {
                return otherColors.count
            }
        } else {
            if component == 0 {
                return otherColors.count
            } else {
                return colors.count
            }
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isFirstComponent {
            if component == 0 {
                view.backgroundColor = colors[row]
                return colorNames[row]
            } else {
                subView.backgroundColor = otherColors[row]
                return otherColorNames[row]
            }
        } else {
            if component == 0 {
                view.backgroundColor = otherColors[row]
                return otherColorNames[row]
            } else {
                subView.backgroundColor = colors[row]
                return colorNames[row]
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        otherColorNames.removeAll()
        otherColors.removeAll()
        for (i,color) in colors.enumerated() {
            if color != colors[row] {
                otherColors.append(color)
                otherColorNames.append(colorNames[i])
            }
        }
        if isFirstComponent {
            if component == 0 {
                isFirstComponent = true
                view.backgroundColor = colors[row]
            } else {
                isFirstComponent = false
                subView.backgroundColor = otherColors[row]
                
            }
        } else {
            if component == 0 {
                isFirstComponent = true
                view.backgroundColor = otherColors[row]
            } else {
                isFirstComponent = false
                subView.backgroundColor = colors[row]
            }
        }
        pickerView.reloadAllComponents()
    }
    
}
