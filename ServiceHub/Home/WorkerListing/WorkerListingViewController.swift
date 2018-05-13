//
//  WorkerListingViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/23/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class WorkerListingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var workerListingLabel: UILabel!
    
    var subcat_id = String()
    var subcat_name = String()
    
    
    var selected_WorkerId = String()
    var selected_WorkerName = String()
    var selected_workerServiceCharge = String()
    var workerId = String()
    var workerName = String()
    var workerServiceCharge = String()
    
    @IBOutlet weak var WorkerListingCollectionView: UICollectionView!
    
    
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SubCat_Name :\(subcat_name)")
        
        workerListingLabel.text = subcat_name
        WorkerListingCollectionView.reloadData()
        
        fetch_worker_images()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JSON_FIELDS.arr_worker_name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyWorker", for: indexPath)as! WorkerListingCollectionViewCell
        cell.worker_name.text = JSON_FIELDS.arr_worker_name[indexPath.row]
        cell.worker_charges.text = JSON_FIELDS.arr_worker_serviceCharge[indexPath.row]
        //cell.category_image?.image = UIImage(named: JSON_FIELDS.arr_category_image[indexPath.row])
        
        //displya the image url for singl image
        if let imageURL = URL(string: API_WEB_URL.MAIN_URL + JSON_FIELDS.arr_worker_photo[indexPath.row])
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
                            cell.worker_photo.image = image
                        }
                    }
            }
        }
        return cell
    }
    
    
    
    
    func fetch_worker_images()
    {
        
        let url = URL(string:API_WEB_URL.WORKER_MASTER + subcat_id)
        print("Fetch Worker Image URL:\(url)")
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            //when you again request for sub catefory the id will be clear for new request
            JSON_FIELDS.arr_worker_id.removeAll()
            JSON_FIELDS.arr_worker_name.removeAll()
            JSON_FIELDS.arr_worker_photo.removeAll()
            JSON_FIELDS.arr_worker_serviceCharge.removeAll()
            subcat_id.removeAll()
            //subcat_name.removeAll()
            
            
            
            if let arrayJson = adata["worker"] as? NSArray
            {
                
                
                for index in 0...(adata["worker"]?.count)! - 1{
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let worker_IdJson = (object["worker_id"]as! String)
                    JSON_FIELDS.arr_worker_id.append(worker_IdJson)
                    
                    let worker_NameJson = (object["worker_name"]as! String)
                    JSON_FIELDS.arr_worker_name.append(worker_NameJson)
                    
                    let worker_PhotoJson = (object["photo"]as! String)
                    JSON_FIELDS.arr_worker_photo.append(worker_PhotoJson)
                    
                    let worker_ChargesJson = (object["service_charge"]as! String)
                    JSON_FIELDS.arr_worker_serviceCharge.append(worker_ChargesJson)

                }
            }
        }
        catch{print("error:\(error)")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        WorkerListingCollectionView.deselectItem(at: indexPath, animated: true)
        let worker = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WorkerDetailsViewController")as! WorkerDetailsViewController
        selected_WorkerId = JSON_FIELDS.arr_worker_id[indexPath.row]
        selected_WorkerName = JSON_FIELDS.arr_worker_name[indexPath.row]
        selected_workerServiceCharge = JSON_FIELDS.arr_worker_serviceCharge[indexPath.row]
        worker.workerId = selected_WorkerId
        worker.workerName = selected_WorkerName
        worker.workerServiceCharge = selected_workerServiceCharge
        worker.subcat_id = subcat_id
        worker.subcat_name = subcat_name
        navigationController?.pushViewController(worker, animated: true)
    }
    
    
    
    

}
