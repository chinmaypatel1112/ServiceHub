//
//  LocationViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/28/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  UISearchBarDelegate, UISearchResultsUpdating {
    
    

    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
//    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
//                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
//                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
//                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
//                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    var selectedArea = String()
    
    @IBOutlet weak var txtLocation: UILabel!
//    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    var filteredData: [String]!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        myTableView.dataSource = self
        myTableView.delegate = self
     //   mySearchBar.delegate = self
        
        fetch_area()
        
        filteredData = JSON_FIELDS.arr_search_areaName
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        
        myTableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true

        
        // Do any additional setup after loading the view.
    }

    
    func fetch_area()
    {
        let url = URL(string:API_WEB_URL.LOCATION_URL)
        print("url:\(url)")
        do{
            let allmydata = try Data(contentsOf: url!)
            print("allmydata:\(allmydata)")
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            print("adata:\(adata)")
            
//            JSON_FIELDS.arr_search_areaId.removeAll()
//            JSON_FIELDS.arr_search_areaName.removeAll()
            
            if let arrayJson = adata["area"] as? NSArray
            {
                //when you again request for sub catefory the id will be clear for new request
                for index in 0...(adata["area"]?.count)! - 1{
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let Area_IdJson = (object["area_id"]as! String)
                    JSON_FIELDS.arr_search_areaId.append(Area_IdJson)
                    print("JSON_FIELDS.arr_search_areaId:\(JSON_FIELDS.arr_search_areaId)")
                    
                    let Area_titleJson = (object["area_name"]as! String)
                    JSON_FIELDS.arr_search_areaName.append(Area_titleJson)
                    print("JSON_FIELDS.arr_search_areaName:\(JSON_FIELDS.arr_search_areaName)")
                }
            }
        }
        catch{print("error:\(error)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
            cell.textLabel?.text = filteredData[indexPath.row]
//        cell.txtLocation?.text = filteredData[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? JSON_FIELDS.arr_search_areaName : JSON_FIELDS.arr_search_areaName.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive ) != nil
            })
            myTableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let SelectArea = JSON_FIELDS.arr_search_areaName[indexPath.row]
        print("SelectArea:\(SelectArea)")
        txtLocation.text = SelectArea
        print("txtLocation.text:\(txtLocation.text)")
    }
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
