//
//  WorkerDetailsViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/27/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class WorkerDetailsViewController: UIViewController, UIScrollViewDelegate  {

    
    @IBOutlet weak var workerDetailsScrollView: UIScrollView!
    
    var subcat_id = String()
    var subcat_name = String()
    var workerId = String()
    var workerName = String()
    var workerServiceCharge = String()
    
    @IBOutlet weak var worker_image: UIImageView!
    @IBOutlet weak var worker_name: UILabel!
    @IBOutlet weak var worker_gender: UILabel!
    @IBOutlet weak var worker_area: UILabel!
    @IBOutlet weak var worker_subcat: UILabel!
    @IBOutlet weak var worker_serviceCharges: UILabel!
    @IBOutlet weak var worker_serviceDetails: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        workerDetailsScrollView.delegate = self
        workerDetailsScrollView.contentSize = CGSize(width: self.view.frame.width, height: 700)
        print(" viewDidLoadsubcat_name :\(subcat_name)")

        worker_image.layer.cornerRadius = worker_image.frame.size.width / 2
        worker_image.clipsToBounds = true
        worker_image.layer.borderWidth = 2
        worker_image.layer.borderColor = UIColor.black.cgColor
        
        
        
        
        fetch_workerDetails_images()
        
        // fetch_worker_Details()
        // Do any additional setup after loading the view.
    }

   
    
    
    
    func fetch_workerDetails_images()
    {
        
        let url = URL(string:API_WEB_URL.WORKER_DEATAILS + workerId)
        print("Fetch Worker Details URL:\(url)")
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            //when you again request for sub catefory the id will be clear for new request
            JSON_FIELDS.arr_workerDetails_id.removeAll()
            JSON_FIELDS.arr_workerDetails_name.removeAll()
            JSON_FIELDS.arr_workerDetails_photo.removeAll()
            JSON_FIELDS.arr_workerDetails_gender.removeAll()
            JSON_FIELDS.arr_workerDetails_areaId.removeAll()
            JSON_FIELDS.arr_workerDetails_SubCat.removeAll()
            JSON_FIELDS.arr_workerDetails_serviceCharge.removeAll()
            JSON_FIELDS.arr_workerDetails_serviceDetails.removeAll()
            JSON_FIELDS.arr_workerDetails_areaName.removeAll()
           // workerId.removeAll()
            //subcat_id.removeAll()
            //subcat_name.removeAll()
            
            
            
            if let arrayJson = adata["worker"] as? NSArray
            {
                
                
                for index in 0...(adata["worker"]?.count)! - 1{
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let worker_PhotoJson = (object["photo"]as! String)
                    JSON_FIELDS.arr_workerDetails_photo.append(worker_PhotoJson)

                    let worker_IdJson = (object["worker_id"]as! String)
                    JSON_FIELDS.arr_workerDetails_id.append(worker_IdJson)
                    print("JSON_FIELDS.arr_workerDetails_id:\(JSON_FIELDS.arr_workerDetails_id)")
                    
                    let worker_NameJson = (object["worker_name"]as! String)
                    JSON_FIELDS.arr_workerDetails_name.append(worker_NameJson)
                    print("JSON_FIELDS.arr_workerDetails_name:\(JSON_FIELDS.arr_workerDetails_name)")
                    
                    let worker_GenderJson = (object["gender"]as! String)
                    JSON_FIELDS.arr_workerDetails_gender.append(worker_GenderJson)

                    let worker_AreaIdJson = (object["area_id"]as! String)
                    JSON_FIELDS.arr_workerDetails_areaId.append(worker_AreaIdJson)

                    let worker_SubCatJson = (object["subcategory_id"]as! String)
                    JSON_FIELDS.arr_workerDetails_SubCat.append(worker_SubCatJson)

                    let worker_ChargesJson = (object["service_charge"]as! String)
                    JSON_FIELDS.arr_workerDetails_serviceCharge.append(worker_ChargesJson)
                    
                    let worker_DetailsJson = (object["details"]as! String)
                    JSON_FIELDS.arr_workerDetails_serviceDetails.append(worker_DetailsJson)
                    
                    let worker_AreaNameJson = (object["area_name"]as! String)
                    JSON_FIELDS.arr_workerDetails_areaName.append(worker_AreaNameJson)
                    
                    let worker_SubCatNameJson = (object["subcategory_name"]as! String)
                    JSON_FIELDS.arr_workerDetails_SubCatName.append(worker_SubCatNameJson)
                    
                }
            }
        }
        catch{print("error:\(error)")
        }
        fetch_worker_Details()
    }
    
    
    
    func fetch_worker_Details() {
        
        worker_name.text = JSON_FIELDS.arr_workerDetails_name
        worker_gender.text = JSON_FIELDS.arr_workerDetails_gender
        worker_area.text = JSON_FIELDS.arr_workerDetails_areaName
        worker_subcat.text = JSON_FIELDS.arr_workerDetails_SubCatName
        worker_serviceCharges.text = JSON_FIELDS.arr_workerDetails_serviceCharge
        worker_serviceDetails.text = JSON_FIELDS.arr_workerDetails_serviceDetails
        
        
        if let imageURL = URL(string: API_WEB_URL.MAIN_URL + JSON_FIELDS.arr_workerDetails_photo)
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
                            self.worker_image.image = image
                        }
                    }
            }
        }
    }
    
    
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func btnBookNowAction(_ sender: Any) {
        
        let Booking = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingViewController")as! BookingViewController
        
        Booking.subcat_id = subcat_id
        Booking.subcat_name = subcat_name
        Booking.workerId = workerId
        Booking.workerName = workerName
        Booking.workerServiceCharge = workerServiceCharge
        self.navigationController?.pushViewController(Booking, animated: true)
    }
 
    
    


}
