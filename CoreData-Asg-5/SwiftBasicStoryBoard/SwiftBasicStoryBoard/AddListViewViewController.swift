//
//  AddListViewViewController.swift
//  SwiftBasicStoryBoard
//
//  Created by Zohaib Aziz on 14/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import UIKit

class AddListViewViewController: UIViewController {

    @IBOutlet var txt_ListName: UITextField!
    
    @IBOutlet var navbar: UINavigationBar!
     var name: String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txt_ListName.placeholder = name;
        navbar.topItem?.title = name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        
        
        self.name = txt_ListName.text!
        if self.name != ""{
            self.performSegue(withIdentifier: "unwindToAddItem", sender: self)
        }

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        print("Segue")
//        
//        if segue.identifier == "ItemAction" {
//            txt_ListName.placeholder = "Enter Item"
//            
//        }
//        
//        if segue.identifier == "BinAction" {
//            txt_ListName.placeholder = "Enter Bin"
//            
//        }
//        
//        if segue.identifier == "LocAction" {
//            txt_ListName.placeholder = "Enter Location"
//            
//        }
//
//
//    }
    

}
