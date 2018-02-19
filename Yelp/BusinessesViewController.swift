//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    var searchBar = UISearchBar()
    var businesses: [Business]!
    var filteredBusinesses : [Business]!
    var isSearching = false
    var isMoreDataLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                self.businesses = businesses
                self.tableView.reloadData()
            
                if let businesses = businesses {
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                }
            }
        )
        
        // search bar
        filteredBusinesses = businesses
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*if businesses != nil {
            return businesses!.count
        }*/
        if isSearching {
            return filteredBusinesses!.count
        }
        else if businesses != nil{
            return businesses!.count
            
        }
        else{
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath as IndexPath) as! BusinessCell
        
        
        if isSearching{
            cell.business = filteredBusinesses[indexPath.row]
        }
        else{
            cell.business = businesses[indexPath.row]
        }
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }
        else{
            
            isSearching = true
            filteredBusinesses = businesses.filter(
                { ($0.name?.lowercased().contains( searchBar.text!.lowercased()))! })
            tableView.reloadData()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !isMoreDataLoading{
            
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging){
                isMoreDataLoading = true
            }
        }
        
    }
    
    
    func loadMoreData(){
        //TODO

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        
        if let indexPath = tableView.indexPath(for: cell){
            
            let businessIndexPath = businesses[indexPath.row]
            let detailViewController = segue.destination as! detailedViewController
            
            detailViewController.backdropImageViewURL = businessIndexPath.imageURL
            detailViewController.nameStr = businessIndexPath.name!
            detailViewController.ratingImageViewURL = businessIndexPath.ratingImageURL
            detailViewController.addressStr = businessIndexPath.address!
            detailViewController.distanceStr = businessIndexPath.distance!
            detailViewController.categoriesStr = businessIndexPath.categories!
         
        }
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
