//
//  SearchViewController.swift
//  SwiftBasicStoryBoard
//
//  Created by Zohaib Aziz Abbasi on 16/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UITableViewController,EntityViewControllerInterface {
    
    @IBOutlet weak var refreshHandler: UIRefreshControl!
    
    var entity:EntityBase?
    private var filteredEntityArray = [EntityBase]()
    var fetchedResultsController: NSFetchedResultsController<Item>!
    let backgroundDataCoordinator:BackgroundCoordinator = BackgroundCoordinator()
    
    let searchController = UISearchController(searchResultsController: nil)
    let allScope = "All"
    var currentScope:String?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initializeFetchedResultsController()
        self.title = "Item Search"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(cancelHandler(sender:)))
        self.loadTableData()
        currentScope = allScope
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = [allScope, String(describing: EntityType.Item), String(describing: EntityType.Bin), String(describing: EntityType.Location)]
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func initializeFetchedResultsController() {
        let coreDataFetch:DataFetch = DataFetch()
        fetchedResultsController = coreDataFetch.getFetchedResultsController()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func loadTableData()    {

        backgroundDataCoordinator.requestAndLoadEntities(objectType: "Item")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath)
        let entity = self.fetchedResultsController?.object(at: indexPath)
        cell.textLabel?.text = "\(entity?.entityModelType ?? "<none>"): \((entity?.name!)!)"
        if let item = entity as? Item    {
            cell.detailTextLabel?.text = "Bin: \(item.itemtoBin?.name ?? "<none>"), Location: \(item.itemtoBin?.binToLoc?.name ?? "<none>")"
        }
        if let bin = entity as? Bin    {
            cell.detailTextLabel?.text = "Location: \(bin.binToLoc?.name ?? "<none>")"
        }
        if let location = entity as? Location    {
            cell.detailTextLabel?.text = "Location: \(location.name!)"
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //self.entity = filteredEntityArray[indexPath.row]
//        print("\(self.entity?.name!) selected")
//        self.performSegue(withIdentifier: "unwindToAddItem", sender: self)
        
        self.cancelHandler(sender: self.navigationItem.leftBarButtonItem!)

    }
    
    func filterContentForSearchText(_ searchText: String, scope: String){
        var predicate:NSPredicate? = nil
        if searchText.isEmpty {
            if scope != allScope {
                predicate = NSPredicate(format: "entityModelType == %@", scope)
            }
        } else {
            if scope != allScope {
                predicate = NSPredicate(format: "name CONTAINS[cd] %@ and entityModelType == %@", searchText, scope)
            } else {
                predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
            }
        }
        fetchedResultsController.fetchRequest.predicate = predicate
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetched results fetch has failed")
        }

        
    }
    
    @IBAction func refreshHandler(_ sender: UIRefreshControl) {
        loadTableData()
    }
    
    func cancelHandler(sender: UIBarButtonItem) {
        print("Cancel clicked!")
        
        //Here we move back
        self.navigationController?.popViewController(animated: true)
    }

}

extension SearchViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension SearchViewController:NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        if self.refreshControl != nil && self.refreshControl!.isRefreshing   {
            self.refreshControl?.endRefreshing()
            print("Data is refresh now....")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

 }
