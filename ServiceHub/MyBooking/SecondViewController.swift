//
//  SecondViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/10/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

//    var user_id = "1"
    var selected_user_id = String()
    
    @IBOutlet weak var myBookingCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selected_user_id = UserDefaults.standard.value(forKey: "user_id") as! String
        print("selected_user_id =\(selected_user_id)")
        
        myBookingCollectionView.dataSource = self
        myBookingCollectionView.delegate = self
        myBookingCollectionView.reloadData()
        
        fetch_myBooking_Data()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JSON_FIELDS.arr_ViewBooking_Id.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBooking", for: indexPath)as! MyViewBookingCollectionViewCell
        cell.SubcatName.text = JSON_FIELDS.arr_ViewBooking_SubcatName[indexPath.row]
        cell.SubcatImage?.image = UIImage(named: JSON_FIELDS.arr_ViewBooking_SubcatImage[indexPath.row])
        cell.WorkerName.text = JSON_FIELDS.arr_ViewBooking_WorkerName[indexPath.row]
        cell.WorkerImage?.image = UIImage(named: JSON_FIELDS.arr_ViewBooking_WorkerImage[indexPath.row])
        cell.BookingDate.text = JSON_FIELDS.arr_ViewBooking_Date[indexPath.row]
        cell.BookingTime.text = JSON_FIELDS.arr_ViewBooking_Time[indexPath.row]
        cell.BookingAddress.text = JSON_FIELDS.arr_ViewBooking_Address[indexPath.row] + ", " + JSON_FIELDS.arr_ViewBooking_AreaName[indexPath.row]
        cell.BookingAmount.text = JSON_FIELDS.arr_ViewBooking_Amount[indexPath.row]
        cell.BookingStatus.text = JSON_FIELDS.arr_ViewBooking_Status[indexPath.row]
        
        if cell.BookingStatus.text == "0" {
            cell.BookingStatus.text = "Not Complete"
            cell.BookingStatus.textColor = UIColor.red
        }
        else {
            cell.BookingStatus.text = "Completed"
            cell.BookingStatus.textColor = UIColor.green
        }
        
        
        //displya the image url for singl image
        if let imageURL = URL(string: API_WEB_URL.MAIN_URL +  JSON_FIELDS.arr_ViewBooking_SubcatImage[indexPath.row])
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
                            cell.SubcatImage.image = image
                        }
                    }
            }
        }
        
        if let imageURL = URL(string: API_WEB_URL.MAIN_URL +  JSON_FIELDS.arr_ViewBooking_WorkerImage[indexPath.row])
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
                            cell.WorkerImage.image = image
                        }
                    }
            }
        }
        
        return cell
    }
    
    
    func fetch_myBooking_Data()
    {
        let url = URL(string:API_WEB_URL.VIEWBOOKING_URL + selected_user_id)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            JSON_FIELDS.arr_ViewBooking_SubcatId.removeAll()
            JSON_FIELDS.arr_ViewBooking_SubcatName.removeAll()
            JSON_FIELDS.arr_ViewBooking_SubcatImage.removeAll()
            JSON_FIELDS.arr_ViewBooking_WorkerId.removeAll()
            JSON_FIELDS.arr_ViewBooking_WorkerName.removeAll()
            JSON_FIELDS.arr_ViewBooking_WorkerImage.removeAll()
            JSON_FIELDS.arr_ViewBooking_AreaId.removeAll()
            JSON_FIELDS.arr_ViewBooking_AreaName.removeAll()
            JSON_FIELDS.arr_ViewBooking_Id.removeAll()
            JSON_FIELDS.arr_ViewBooking_Date.removeAll()
            JSON_FIELDS.arr_ViewBooking_Time.removeAll()
            JSON_FIELDS.arr_ViewBooking_Address.removeAll()
            JSON_FIELDS.arr_ViewBooking_Amount.removeAll()
            JSON_FIELDS.arr_ViewBooking_Status.removeAll()
      
            
            if let arrayJson = adata["MyBooking"] as? NSArray
            {
                //when you again request for sub catefory the id will be clear for new request
                for index in 0...(adata["MyBooking"]?.count)! - 1{
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let sub_cat_IdJson = (object["subcategory_id"]as! String)
                    JSON_FIELDS.arr_ViewBooking_SubcatId.append(sub_cat_IdJson)
                    
                    let sub_cat_titleJson = (object["subcategory_name"]as! String)
                    JSON_FIELDS.arr_ViewBooking_SubcatName.append(sub_cat_titleJson)
                    
                    let sub_cat_imageJson = (object["subcategory_image"]as! String)
                    JSON_FIELDS.arr_ViewBooking_SubcatImage.append(sub_cat_imageJson)
                    
                    let worker_IdJson = (object["worker_id"]as! String)
                    JSON_FIELDS.arr_ViewBooking_WorkerId.append(worker_IdJson)
                    
                    let worker_titleJson = (object["worker_name"]as! String)
                    JSON_FIELDS.arr_ViewBooking_WorkerName.append(worker_titleJson)
                    
                    let worker_imageJson = (object["photo"]as! String)
                    JSON_FIELDS.arr_ViewBooking_WorkerImage.append(worker_imageJson)
                    
                    let area_IdJson = (object["area_id"]as! String)
                    JSON_FIELDS.arr_ViewBooking_AreaId.append(area_IdJson)
                    
                    let area_titleJson = (object["area_name"]as! String)
                    JSON_FIELDS.arr_ViewBooking_AreaName.append(area_titleJson)
                    
                    let booking_IdJson = (object["booking_id"]as! String)
                    JSON_FIELDS.arr_ViewBooking_Id.append(booking_IdJson)
                    
                    let booking_dateJson = (object["booking_date"]as! String)
                    JSON_FIELDS.arr_ViewBooking_Date.append(booking_dateJson)
                    
                    let booking_timeJson = (object["time"]as! String)
                    JSON_FIELDS.arr_ViewBooking_Time.append(booking_timeJson)
                    
                    let booking_addressJson = (object["address"]as! String)
                    JSON_FIELDS.arr_ViewBooking_Address.append(booking_addressJson)
                    
                    let booking_priceJson = (object["price"]as! String)
                    JSON_FIELDS.arr_ViewBooking_Amount.append(booking_priceJson)
                    
                    let booking_isCompletedJson = (object["is_completed"]as! String)
                    JSON_FIELDS.arr_ViewBooking_Status.append(booking_isCompletedJson)
                }
            }
        }
        catch{print("error:\(error)")
        }
    }
    
    


}

