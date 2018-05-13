//
//  AllSubcategoryViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/31/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class AllSubcategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var selected_subcat_id = String()
    var subcat_id = String()
    var selected_subcat_name = String()
    var subcat_name = String()
    
    
    @IBOutlet weak var myAllSubcategoryTableView: UITableView!
    
    
    var subcatDictionary = [String: [String]]()
    var subcatSectionTitles = [String]()
    var subcatSectionImage = [String]()
    var subcats = [String]()
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        print("subcatSectionTitles.count:\(subcatSectionTitles.count)")
        return subcatSectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        let subcatKey = subcatSectionTitles[section]
        if let subcatValues = subcatDictionary[subcatKey] {
            return subcatValues.count
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MySubcatCell", for: indexPath)as! AllSubcategoyTableViewCell
        
        cell.AllSubcategory_Name.text = JSON_FIELDS.arr_allSubcategory_name[indexPath.row]
        cell.imageView?.image = UIImage(named: JSON_FIELDS.arr_allSubcategory_image[indexPath.row])
        
        let subcatKey = subcatSectionTitles[indexPath.section]
        if let subcatValues = subcatDictionary[subcatKey] {
            cell.AllSubcategory_Name.text = subcatValues[indexPath.row]
            print("cell.AllSubcategory_Name.text:\(cell.AllSubcategory_Name.text)")
            cell.imageView?.image = UIImage(named: subcatValues[indexPath.row])
            print("cell.imageView?.image:\(subcatValues[indexPath.row])")
            
        }
        
        //displya the image url for singl image
        if let imageURL = URL(string: API_WEB_URL.MAIN_URL + "API/" + JSON_FIELDS.arr_allSubcategory_image[indexPath.row])
        {
            
            print("imageURL:\(imageURL)")
            //call the main thread ..when we are not in main thread then it necessary to call the main thread
            DispatchQueue.global().async
                {
                    //store url into data format
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        //store data into 1 VARIABLE
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            //AGAIN WE HAVE TO CALL THE MAIN thread
                            //and assign the variable value into cell image view
                            cell.AllSubcategory_Image.image = image
                           // print(subcatValue)
                           // print(cell.AllSubcategory_Image.image)
                        }
                    }
            }
        }
        return cell
        
    }
    
    
    func fetch_AllSubcat_images()
    {
        
        let url = URL(string:API_WEB_URL.ALL_SUBCATEGORY_IMAGE)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            
            JSON_FIELDS.arr_allSubcategory_id.removeAll()
            JSON_FIELDS.arr_allSubcategory_name.removeAll()
            JSON_FIELDS.arr_allSubcategory_image.removeAll()
            subcat_id.removeAll()
            selected_subcat_id.removeAll()
            subcat_name.removeAll()
            selected_subcat_name.removeAll()
            
            if let arrayJson = adata["subcategory"] as? NSArray
            {
                
                //when you again request for sub catefory the id will be clear for new request
                for index in 0...(adata["subcategory"]?.count)! - 1{
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let all_sub_cat_IdJson = (object["subcategory_id"]as! String)
                    JSON_FIELDS.arr_allSubcategory_id.append(all_sub_cat_IdJson)
                    
                    let all_sub_cat_titleJson = (object["subcategory_name"]as! String)
                    JSON_FIELDS.arr_allSubcategory_name.append(all_sub_cat_titleJson)
                    
                    let all_sub_cat_imageJson = (object["subcategory_image"]as! String)
                    JSON_FIELDS.arr_allSubcategory_image.append(all_sub_cat_imageJson)
                }
            }
        }
        catch{print("error:\(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("subcatSectionTitles[section]:\(subcatSectionTitles[section])")
        return subcatSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        print("subcatSectionTitles:\(subcatSectionTitles)")
        return subcatSectionTitles
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        myAllSubcategoryTableView.reloadData()
        fetch_AllSubcat_images()
        
       // subcats = ["Audi", "Aston Martin","BMW", "Bugatti", "Bentley","Chevrolet", "Cadillac","Dodge","Ferrari", "Ford","Honda","Jaguar","Lamborghini","Mercedes", "Mazda","Nissan","Porsche","Rolls Royce","Toyota","Volkswagen"]
        
        // 1
        for subcat in JSON_FIELDS.arr_allSubcategory_name {
            let subcatKey = String(subcat.prefix(1))
            if var subcatValues = subcatDictionary[subcatKey] {
                subcatValues.append(subcat)
                subcatDictionary[subcatKey] = subcatValues
            } else {
                subcatDictionary[subcatKey] = [subcat]
            }
        }
        
        // 2
        subcatSectionTitles = [String](subcatDictionary.keys)
        subcatSectionImage = [String](subcatDictionary.keys)
        subcatSectionTitles = subcatSectionTitles.sorted(by: { $0 < $1 })
        subcatSectionImage = subcatSectionImage.sorted(by: { $0 < $1 })
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let worker = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WorkerListingViewController")as! WorkerListingViewController
        print("arr_allSubcategory ID:\(JSON_FIELDS.arr_allSubcategory_id)")
        print("arr_allSubcategory Name:\(JSON_FIELDS.arr_allSubcategory_name)")
        selected_subcat_id = JSON_FIELDS.arr_allSubcategory_id[indexPath.row]
        selected_subcat_name = JSON_FIELDS.arr_allSubcategory_name[indexPath.row]
        print("Selected Subcategory ID:\(selected_subcat_id)")
        print("Selected Subcat Name:\(selected_subcat_name)")
        worker.subcat_id = selected_subcat_id
        worker.subcat_name = selected_subcat_name
        navigationController?.pushViewController(worker, animated: true)
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
