//
//  SearchViewController.swift
//  SwiftBasicStoryBoard
//
//  Created by Zohaib Aziz Abbasi on 16/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {

    var dataDic:[String : Any] = [String:Any]()
    var filterdataDic:[String : Any] = [String:Any]()
    var data:NSArray = [String]() as NSArray
    let allScope = "All"
    var currentScope:String?
    var isSearching:Bool = false
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var typ = [String()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Keys
        data = self.getKeyAry(data: dataDic)

        
         currentScope = allScope
        filterdataDic = dataDic
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = [allScope, String(describing: data[0]), String(describing: data[1]), String(describing: data[2])]
        tableView.tableHeaderView = searchController.searchBar
        

    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Methods
    
    func getKeyAry(data:[String : Any])->NSArray {
        let keys = data.keys
        var arrayKeys = [String]()
        for item in keys{
            arrayKeys.append(item)
        }
        
        
        return arrayKeys as NSArray
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        data = self.getKeyAry(data: filterdataDic)
        return  filterdataDic.count


        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            //Get Key
         let   str  = data[section] as! String
         let   arr = filterdataDic[str]  as! NSArray
            

        return arr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath)
        
        var str = String()
        var arr:NSArray
        
//        if isSearching {
            str  = data[indexPath.section] as! String
            arr = filterdataDic[str]  as! NSArray
//        }else{
//        
//            str  = data[indexPath.section] as! String
//            arr = dataDic[str]  as! NSArray
//        }

        cell.textLabel?.text = "\(arr[indexPath.row])"
        cell.detailTextLabel?.text = str
        return cell
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope:Int) {
        
        self.setFilterData(selectedScope: scope)
        
        //let temp = filterdataDic
        var keyVals : [String:[String]] = [String:[String]]()
        if !searchText.isEmpty{
            for (ky,dt) in dataDic {
                var val = [String]()
                val =   (dt as! [String]).filter({ (val) -> Bool in
                    
                    return val.lowercased().contains(searchText.lowercased())
                })
                
                if val.count > 0 {
                    
                    keyVals[ky] = val
                }
                
                
            }
            filterdataDic = keyVals
        }
        
        
        tableView.reloadData()
    }
    
    func cancelHandler(sender: UIBarButtonItem) {
        print("Cancel clicked!")
        self.dismiss(animated: true, completion: nil)
    }
}


    extension SearchViewController: UISearchBarDelegate {
        // MARK: - UISearchBar Delegate
        
        func setFilterData(selectedScope: Int){
            
            switch (selectedScope) {
            case 0 :
                filterdataDic = dataDic
            case 1 :
                filterdataDic.updateValue(dataDic["item"]!, forKey: "item")
            case 2 :
                filterdataDic.updateValue(dataDic["loc"]!, forKey: "loc")
            case 3 :
                filterdataDic.updateValue(dataDic["bin"]!, forKey: "bin")
                
            default:
                filterdataDic = dataDic
            }
            
          tableView.reloadData()
            
        }
        func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            filterdataDic.removeAll()
            
            searchBar.text = ""
            self.setFilterData(selectedScope: selectedScope)
            
            filterContentForSearchText(searchBar.text!, scope: selectedScope)
            

        }
    }
    
    extension SearchViewController: UISearchResultsUpdating {
        // MARK: - UISearchResultsUpdating Delegate
        func updateSearchResults(for searchController: UISearchController) {
            
            let searchBar = searchController.searchBar
            let idx = searchBar.selectedScopeButtonIndex
    
            filterContentForSearchText(searchController.searchBar.text!, scope: idx)
        }


}
