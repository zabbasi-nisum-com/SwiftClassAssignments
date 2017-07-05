//
//  ViewController.swift
//  SwiftBasicStoryBoard
//
//  Created by Zohaib Aziz on 13/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,EntityViewControllerInterface  {

    @IBOutlet var txt_Item: UITextField!
    @IBOutlet var txt_Loc: UITextField!
    @IBOutlet var txt_BIn: UITextField!
    var activeTextFeild: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var saveButton: UIButton!
    var entity:EntityBase?
    var fetchUtility = FetchUtility()
    
    enum ActionType {
        case Create
        case Update
        case Delete
    }

    
    var pickerDataSource = [String()];
    var pickerRowSelectedHandler: ((Int) -> Void)?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       self.title = "My First App"
        
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTap))
        self.navigationItem.rightBarButtonItem = searchBtn
        
        pickerView.isHidden = true
        txt_BIn.delegate = self
        pickerView.reloadAllComponents()
        //saveButton.addTarget(self, action: #selector(SaveTapped), for: .touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
  // MARK: iBActions
    
    @IBAction func AddLocTapped(_ sender: UIButton) {
        
        //Here we get Value for add Bin List
        self.showAddEntityAlertView(entityType: .Location, actionType: .Create)

    }
    
    @IBAction func SaveTapped(_ sender: UIButton) {
        
        //Here we just Print a textfeild vakues as required
        print(" Item = ", txt_Item.text! , " Bin = " ,txt_BIn.text! , "Location" ,txt_Loc.text! )
    }

    // MARK: Custom Methods
    
    func updateTitle(actionType:ActionType) {
        //navigationBar.topItem?.title = "\(String(describing:actionType)) Item"
    }

    
    func showAddEntityAlertView(entityType:EntityType, actionType:ActionType)    {
        
        let alert = UIAlertController(title: "\(actionType) \(entityType)", message: "Enter \(entityType) name", preferredStyle: .alert)
        alert.addTextField { (textField) in textField.placeholder = "\(entityType) name"}
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            [weak alert, weak self] (_) in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.reset()
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField.text))")
            var isError = false
            var errorMessage = ""
            if entityType == EntityType.Location {
                let location = Location(context: context)
                do {
                    location.name = textField.text!
                    location.entityType = EntityType.Location
                }catch {
                    isError = true
                    errorMessage = error.localizedDescription
                }
            }
            
            if !isError {
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            } else {
                UIAlertController(title: "\(actionType) \(entityType)", message: errorMessage, preferredStyle: .alert)
            }
            
            }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    func searchTap(_ sender: UIButton) {
        
       //Here we Create Object
        let searchView = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        
         //Here we Push searchView
        self.navigationController?.pushViewController(searchView!, animated: true)

    }
    
// MARK: TextFeild Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var allowEditing = true
        switch textField {
        case self.txt_Loc:
            self.pickerDataSource = (fetchUtility.fetchSortedLocation()?.map(
                {
                    (value: Location) -> String in
                    return value.name!
            }))!
            pickerView.reloadAllComponents()
            self.pickerView.isHidden = false
            if self.txt_Loc.text != nil && !self.txt_Loc.text!.isEmpty  {
                self.pickerView.selectRow(pickerDataSource.index(of: self.txt_Loc.text!)!, inComponent:0, animated: false)
            }
            else {
                self.pickerView.selectRow(0, inComponent:0, animated: false)
            }
            allowEditing = true
        
        default: self.pickerView.isHidden = true
        }
        
        self.pickerRowSelectedHandler = {(selectedIndex:Int) -> Void in
            var entityType: EntityType?
            switch textField {
            case self.txt_Loc:
                entityType = EntityType.Location
                self.txt_Loc.text = self.pickerDataSource[selectedIndex]
            case self.txt_BIn:
                entityType = EntityType.Bin
                self.txt_BIn.text = self.pickerDataSource[selectedIndex]
            default: break
            }
            print("\(entityType) selected: \(selectedIndex)")
        }
        
        return allowEditing;
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
        
        //Here we pass index to set selected Value
        pickerRowSelectedHandler!(row)
        
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
        print("Value of add bin Text field - ", item)
        
    }
    
    @IBAction func unwindFromSearch(sender: UIStoryboardSegue) {
        let itemSearchTableViewController = sender.source as! EntityViewControllerInterface
        let entity:EntityBase? = itemSearchTableViewController.entity
        if let item = entity as? Item? {
            self.entity = item
            self.updateFields(fromItem: item!)
        } else if let bin = entity as? Bin? {
            self.updateFields(fromBin: bin!)
        }
        else if let location = entity as? Location? {
            self.updateFields(fromLocation: location!)
        }
    }

    func updateFields(fromItem:Item)    {
        self.txt_Loc.text = fromItem.itemtoBin?.binToLoc?.name
         self.updateTitle(actionType: ActionType.Update)
    }

    func updateFields(fromBin:Bin)    {
        //        self.locationText.text = fromBin.location?.name
        //        self.binText.text = fromBin.name
    }
    
    func updateFields(fromLocation:Location)    {
        self.txt_Loc.text = fromLocation.name
    }

    
}

