//
//  SubCatViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/21/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class SubCatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    var cat_id = String()
    var cat_name = String()
    //var cat_name = String()
    var selected_subcat_id = String()
    var subcat_id = String()
    var selected_subcat_name = String()
    var subcat_name = String()
    
//    var selected_subcat_Image = String()
//    var subcat_Image = String()
    
   
    @IBOutlet weak var mySubCatCollectionView: UICollectionView!
    
    @IBOutlet weak var lblCategoryHeading: UILabel!
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("Sub Category View Controller Cat Name:\(cat_name)")
        CatHeading()
        
        mySubCatCollectionView.reloadData()
        
        fetch_subcat_images()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JSON_FIELDS.arr_subcategory_name3.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MySubCat", for: indexPath)as! SubCatCollectionViewCell
        cell.subCat_name.text = JSON_FIELDS.arr_subcategory_name3[indexPath.row]
        //cell.category_image?.image = UIImage(named: JSON_FIELDS.arr_category_image[indexPath.row])
        
        //displya the image url for singl image
        if let imageURL = URL(string: API_WEB_URL.MAIN_URL + "API/" + JSON_FIELDS.arr_subcategory_image3[indexPath.row])
        {
            //print(imageURL)
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
                            cell.subCat_image.image = image
                        }
                    }
            }
        }
        return cell
    }
    
    
    func fetch_subcat_images()
    {
        let url = URL(string:API_WEB_URL.SUBCATEGORY_IMAGE + cat_id)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            JSON_FIELDS.arr_subcategory_id3.removeAll()
            JSON_FIELDS.arr_subcategory_name3.removeAll()
            JSON_FIELDS.arr_subcategory_image3.removeAll()
            subcat_id.removeAll()
            selected_subcat_id.removeAll()
            subcat_name.removeAll()
            selected_subcat_name.removeAll()
            cat_id.removeAll()
            cat_name.removeAll()
            
            if let arrayJson = adata["subcategory"] as? NSArray
            {
                //when you again request for sub catefory the id will be clear for new request
                for index in 0...(adata["subcategory"]?.count)! - 1{
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let sub_cat_IdJson = (object["subcategory_id"]as! String)
                    JSON_FIELDS.arr_subcategory_id3.append(sub_cat_IdJson)
                    
                    let sub_cat_titleJson = (object["subcategory_name"]as! String)
                    JSON_FIELDS.arr_subcategory_name3.append(sub_cat_titleJson)
                    
                    let sub_cat_imageJson = (object["subcategory_image"]as! String)
                    JSON_FIELDS.arr_subcategory_image3.append(sub_cat_imageJson)
                }
            }
        }
        catch{print("error:\(error)")
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mySubCatCollectionView.deselectItem(at: indexPath, animated: true)
        let worker = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WorkerListingViewController")as! WorkerListingViewController
        selected_subcat_id = JSON_FIELDS.arr_subcategory_id3[indexPath.row]
        selected_subcat_name = JSON_FIELDS.arr_subcategory_name3[indexPath.row]
        worker.subcat_id = selected_subcat_id
        worker.subcat_name = selected_subcat_name
        navigationController?.pushViewController(worker, animated: true)
    }

    
    // For Display Category Name in Heading
    func CatHeading(){
        if cat_id == "1"{

            lblCategoryHeading.text = "Beauty & Spa"
        }
        else if cat_id == "2"{
            lblCategoryHeading.text = "Electronic & Appliance"
        }
        
        else{
            lblCategoryHeading.text = cat_name
        }
    }
    
    


}
