//
//  ViewController.swift
//  SwiftBasicStoryBoard
//
//  Created by Zohaib Aziz on 13/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate  {

    @IBOutlet var txt_Item: UITextField!
    @IBOutlet var txt_Loc: UITextField!
    @IBOutlet var txt_BIn: UITextField!
    var activeTextFeild: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var saveButton: UIButton!
    
    
    var pickerDataSource = [String()];
    var item = ["Item-1", "Item-2", "Item-3", "Item-4"];
    var bin = ["Bin-1", "Bin-2", "Bin-3", "Bin-4"];
    var loc = ["Loc-1", "Loc-2", "Loc-3", "Loc-4"];

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        pickerView.isHidden = true
        txt_BIn.delegate = self
        pickerView.reloadAllComponents()
        //saveButton.addTarget(self, action: #selector(SaveTapped), for: .touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func SaveTapped(_ sender: UIButton) {
        
        //Here we just Print a textfeild vakues as required
        print(" Item = ", txt_Item.text! , " Bin = " ,txt_BIn.text! , "Location" ,txt_Loc.text! )
    }
    
// MARK: TextFeild Delegate

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
    
        textField.allowsEditingTextAttributes = false
        
        //Here we save reference for future use
        activeTextFeild = textField
        
        switch (textField) {
        case txt_Item:
            pickerDataSource = item
        case txt_BIn:
            pickerDataSource = bin
        case txt_Loc:
            pickerDataSource = loc
            
        default:
            pickerDataSource = [String()]
        }
        
        //Here we open and load Data of PickerView
        pickerView.isHidden = false
        pickerView.reloadAllComponents()
        return true
    }
    
// MARK: Picker Datasouce Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
    
    return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }

    // MARK: Picker Delegate
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
    
        //Set TextFeild Data from saved references
        activeTextFeild.text = pickerDataSource[row]
        
        //Hide Picker
        pickerView.isHidden = true

        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("did that thing")
       let nextViewController = segue.destination as? AddListViewViewController
        
        
        if segue.identifier == "ItemAction" {
           nextViewController?.name = "Enter Item"
            activeTextFeild = txt_Item
            
               
        }
        
        if segue.identifier == "BinAction" {
           nextViewController?.name = "Enter Bin"
            activeTextFeild = txt_BIn

        }
        
        if segue.identifier == "LocAction" {
            nextViewController?.name = "Enter Location"
            activeTextFeild = txt_Loc

            
        }
        
        
    }
    
    
    @IBAction func unwindToAddItem(sender: UIStoryboardSegue) {
        
        
        let src = sender.source as! AddListViewViewController
        let item = src.name
        activeTextFeild.text = src.name
        addinArray(name: src.name)
        print("Value of add bin Text field - ", item)
        
    }
    
    func addinArray(name :String) {
    
        if activeTextFeild == txt_Item {
            item.append(name)
        }
        
        if activeTextFeild == txt_BIn {
            bin.append(name)
        }

        if activeTextFeild == txt_Loc {
            loc.append(name)
        }

        textFieldShouldBeginEditing(activeTextFeild)
//        pickerView.reloadAllComponents();
    
    }
    
    
}

