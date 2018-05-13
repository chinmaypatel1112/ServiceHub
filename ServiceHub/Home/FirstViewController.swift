//
//  FirstViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/10/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit
import UserNotifications

class FirstViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBAction func btnLocationAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationViewController")
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    
    @IBOutlet weak var HomeScrollView: UIScrollView!
    var selected_cat_id = String()
    var  selected_cat_name = String()
    var cat_id = String()
    var cat_name = String()
    var cat_id1 = "1"
    var cat_id2 = "2"
   
    var selected_subcat_id = String()
    var subcat_id = String()
    var selected_subcat_name = String()
    var subcat_name = String()
    
    
    
    @IBOutlet weak var scrollerView: UIScrollView!
    @IBOutlet weak var page: UIPageControl!
    
    
    @IBOutlet weak var scrollerView2: UIScrollView!
    
    // For ScrollerView - Slider Image
    var img = [String]()
    var frame = CGRect(x:0, y:0, width:0, height:0)
    var imageView = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        HomeScrollView.delegate = self
        HomeScrollView.contentSize = CGSize(width: self.view.frame.width, height: 2230)
        
        myLocalNotification()
        fetch_slider_images()
        fetch_slider_images2()
        fetch_category_images()
        fetch_subcategory_images()
        fetch_subcategory_images2()
        myCategoryCollectionView.reloadData()
        mySubcategoryCollectionView.reloadData()
        mySubcategoryCollectionView2.reloadData()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNextPage2), userInfo: nil, repeats: true)
    
        
        
        
    }

    
    func myLocalNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (success, error) in
            if success {
                print("success")
            } else {
                print("error")
            }
        }
    }
    
    
    
    
// ---------------- Scroller View Start ------------------
    
    @objc func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollerView.frame.width
        let maxWidth:CGFloat = pageWidth * 7
        let contentOffset:CGFloat = self.scrollerView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        scrollViewDidEndDecelerating(scrollerView)
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrollerView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollerView.frame.height), animated: true)
    }
    
    // For Image JSON Serialization
    func fetch_slider_images()
    {
        let url = URL(string: API_WEB_URL.SLIDER_IMAGES)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            if let arrayJson = adata["slider"] as? NSArray
            {
                for index in 0...(adata["slider"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_slider_id = (object["slider_id"]as! String)
                    JSON_FIELDS.arr_slider_id.append(arr_slider_id)
                    
                    let arr_slider_title = (object["slider_name"]as! String)
                    JSON_FIELDS.arr_slider_title.append(arr_slider_title)
                    
                    let arr_slider_img = (object["slider_image"]as! String)
                    JSON_FIELDS.arr_slider_img.append(arr_slider_img)
                }
            }
        }
        catch{
            print(error)
        }
        self.slider_images()
    }
    
    
    // For Slider Images
    func slider_images()
    {
        page.currentPage = JSON_FIELDS.arr_slider_img.count
        self.page.numberOfPages = JSON_FIELDS.arr_slider_img.count
        
        for index in 0..<JSON_FIELDS.arr_slider_img.count
        {
            frame.origin.x = scrollerView.frame.size.width * CGFloat(index)
            frame.size = scrollerView.frame.size
            imageView = UIImageView(frame: frame)
            
            let imgPath = API_WEB_URL.MAIN_URL + "API/" + JSON_FIELDS.arr_slider_img[index]
            // print("IMAGE_URL : \(imgPath)")
            if URL(string: JSON_FIELDS.arr_slider_img[index]) != nil
            {
                let sliderUrl = URL(string: imgPath)
                // print("SLIDER: \(String(describing: sliderUrl))")
                
                if let data = NSData(contentsOf: sliderUrl!)
                {
                    if data != nil{
                        imageView.image = UIImage(data: data as Data)
                    }
                    else{
                        print("Error in ImageView")
                    }
                }
            }
            self.scrollerView.addSubview(self.imageView)
        }
        self.scrollerView.contentSize = CGSize(width: (scrollerView.frame.size.width * CGFloat(JSON_FIELDS.arr_slider_img.count)), height: scrollerView.frame.size.height)
        self.scrollerView.delegate = self
    }
    
    // -----------------------------
    // ----------- Slider 2 --------
    @objc func moveToNextPage2 (){
        let pageWidth:CGFloat = self.scrollerView2.frame.width
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollerView2.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        scrollViewDidEndDecelerating(scrollerView2)
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrollerView2.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollerView2.frame.height), animated: true)
    }
    
    
    
    // For Image JSON Serialization
    func fetch_slider_images2()
    {
        let url = URL(string: API_WEB_URL.SLIDER_IMAGES2)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            if let arrayJson = adata["slider2"] as? NSArray
            {
                
                for index in 0...(adata["slider2"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_slider_id = (object["slider_id2"]as! String)
                    JSON_FIELDS.arr_slider_id2.append(arr_slider_id)
                    
                    let arr_slider_title = (object["slider_name2"]as! String)
                    JSON_FIELDS.arr_slider_title2.append(arr_slider_title)
                    
                    let arr_slider_img = (object["slider_image2"]as! String)
                    JSON_FIELDS.arr_slider_img2.append(arr_slider_img)
                }
            }
        }
        catch{
            print(error)
        }
        self.slider_images2()
    }
    
    
    
    // For Slider Images
    func slider_images2()
    {
       // page.currentPage = JSON_FIELDS.arr_slider_img.count
       // self.page.numberOfPages = JSON_FIELDS.arr_slider_img.count
        
        for index in 0..<JSON_FIELDS.arr_slider_img2.count
        {
            frame.origin.x = scrollerView2.frame.size.width * CGFloat(index)
            frame.size = scrollerView2.frame.size
            imageView = UIImageView(frame: frame)
            
            let imgPath = API_WEB_URL.MAIN_URL + "API/" + JSON_FIELDS.arr_slider_img2[index]
            // print("IMAGE_URL : \(imgPath)")
            if URL(string: JSON_FIELDS.arr_slider_img2[index]) != nil
            {
                let sliderUrl = URL(string: imgPath)
                // print("SLIDER: \(String(describing: sliderUrl))")
                
                if let data = NSData(contentsOf: sliderUrl!)
                {
                    if data != nil{
                        imageView.image = UIImage(data: data as Data)
                    }
                    else{
                        print("Error in ImageView")
                    }
                }
            }
            self.scrollerView2.addSubview(self.imageView)
        }
        self.scrollerView2.contentSize = CGSize(width: (scrollerView2.frame.size.width * CGFloat(JSON_FIELDS.arr_slider_img2.count)), height: scrollerView2.frame.size.height)
        self.scrollerView2.delegate = self
    }
    
    
    
    // For Page View
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        self.page.numberOfPages = JSON_FIELDS.arr_slider_img.count
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+2
        self.page.currentPage = Int(currentPage);
       // print(" Current Page: \(currentPage)")
       // print("Tatal Page: \(JSON_FIELDS.arr_slider_img.count)")
    }
    
    
// ----------------- Scroller View End ------------------
    
    
    
// ----------------- Category Collection View Start ------------------
    
    
    @IBOutlet weak var myCategoryCollectionView: UICollectionView!
    @IBOutlet weak var mySubcategoryCollectionView: UICollectionView!
    @IBOutlet weak var mySubcategoryCollectionView2: UICollectionView!
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if collectionView == myCategoryCollectionView
        {
            // Category collection view
            return JSON_FIELDS.arr_category_name.count
        
        }
        else if (collectionView == mySubcategoryCollectionView)
        {
            // Subcategory collection view
            return JSON_FIELDS.arr_subcategory_name.count
        }
        else  // collectionView == mySubcategoryCollectionView2
        {
            // Subcategory collection View 2
            return JSON_FIELDS.arr_subcategory_name2.count
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == myCategoryCollectionView
        {
        
        let cell = myCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCategoryCell", for: indexPath)as! MainCategoryCollectionViewCell
        cell.category_label.text = JSON_FIELDS.arr_category_name[indexPath.row]
        //cell.category_image?.image = UIImage(named: JSON_FIELDS.arr_category_image[indexPath.row])
        
        //displya the image url for singl image
        if let imageURL = URL(string: API_WEB_URL.MAIN_URL + "API/" + JSON_FIELDS.arr_category_image[indexPath.row])
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
                            cell.category_image.image = image
                        }
                    }
            }
        }
        return cell
    }
        else if collectionView == mySubcategoryCollectionView
        {
            
            let cell = mySubcategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MySubcategoryCell", for: indexPath)as! SubCategoryCollectionViewCell
            cell.subcategoryName.text = JSON_FIELDS.arr_subcategory_name[indexPath.row]
            //cell.category_image?.image = UIImage(named: JSON_FIELDS.arr_category_image[indexPath.row])
            
            //displya the image url for singl image
            if let imageURL = URL(string: API_WEB_URL.MAIN_URL + "API/" + JSON_FIELDS.arr_subcategory_image[indexPath.row])
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
                                cell.subcategoryImage.image = image
                            }
                        }
                }
            }
            return cell
        }
        else
        {
            let cell = mySubcategoryCollectionView2.dequeueReusableCell(withReuseIdentifier: "MySubcategoryCell2", for: indexPath)as! SubCategory2CollectionViewCell
            cell.subcategoryName2.text = JSON_FIELDS.arr_subcategory_name2[indexPath.row]
            //displya the image url for singl image
            if let imageURL = URL(string: API_WEB_URL.MAIN_URL + "API/" + JSON_FIELDS.arr_subcategory_image2[indexPath.row])
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
                                cell.subcategoryImage2.image = image
                            }
                        }
                }
            }
            return cell
        }
     
    }
    

    
    // For  Category JSON Serialization
    func fetch_category_images()
    {
        let url = URL(string: API_WEB_URL.CATEGORY_IMAGE)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            JSON_FIELDS.arr_category_id.removeAll()
            JSON_FIELDS.arr_category_name.removeAll()
            JSON_FIELDS.arr_category_image.removeAll()
            selected_cat_id.removeAll()
            selected_cat_name.removeAll()
            cat_id.removeAll()
            cat_name.removeAll()
            selected_subcat_id.removeAll()
            selected_subcat_name.removeAll()
            subcat_id.removeAll()
            subcat_name.removeAll()
            
            if let arrayJson = adata["category"] as? NSArray
            {
                
                
                for index in 0...(adata["category"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_category_id = (object["category_id"]as! String)
                    JSON_FIELDS.arr_category_id.append(arr_category_id)
                    
                    let arr_category_title = (object["category_name"]as! String)
                    JSON_FIELDS.arr_category_name.append(arr_category_title)
                    
                    let arr_category_img = (object["category_image"]as! String)
                    JSON_FIELDS.arr_category_image.append(arr_category_img)
                }
            }
        }
        catch{print(error)
        }
        
    }
    
    
    
    
    // For  Subcategory JSON Serialization
    func fetch_subcategory_images()
    {
        
        
        let url = URL(string: API_WEB_URL.SUBCATEGORY_IMAGE + "1")
        //print("SubCategory URL: \(cat_id1)")
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            JSON_FIELDS.arr_subcategory_id.removeAll()
            JSON_FIELDS.arr_subcategory_name.removeAll()
            JSON_FIELDS.arr_subcategory_image.removeAll()
            selected_subcat_id.removeAll()
            selected_subcat_name.removeAll()
            subcat_id.removeAll()
            subcat_name.removeAll()
            
            
            
            if let arrayJson = adata["subcategory"] as? NSArray
            {
                for index in 0...(adata["subcategory"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_subcategory_id = (object["subcategory_id"]as! String)
                    JSON_FIELDS.arr_subcategory_id.append(arr_subcategory_id)
                    
                    let arr_subcategory_title = (object["subcategory_name"]as! String)
                    JSON_FIELDS.arr_subcategory_name.append(arr_subcategory_title)
                    
                    let arr_subcategory_img = (object["subcategory_image"]as! String)
                    JSON_FIELDS.arr_subcategory_image.append(arr_subcategory_img)
                }
            }
        }
        catch{print(error)
        }
        
    }
    
    
    
    
    // For  Subcategory JSON Serialization
    func fetch_subcategory_images2()
    {
        
        
        let url = URL(string: API_WEB_URL.SUBCATEGORY_IMAGE + "2")
        //print("SubCategory URL: \(cat_id2)")
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            JSON_FIELDS.arr_subcategory_id2.removeAll()
            JSON_FIELDS.arr_subcategory_name2.removeAll()
            JSON_FIELDS.arr_subcategory_image2.removeAll()
            selected_subcat_id.removeAll()
            selected_subcat_name.removeAll()
            subcat_id.removeAll()
            subcat_name.removeAll()
            
            
            if let arrayJson = adata["subcategory"] as? NSArray
            {
                for index in 0...(adata["subcategory"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_subcategory_id2 = (object["subcategory_id"]as! String)
                    JSON_FIELDS.arr_subcategory_id2.append(arr_subcategory_id2)
                    
                    let arr_subcategory_title2 = (object["subcategory_name"]as! String)
                    JSON_FIELDS.arr_subcategory_name2.append(arr_subcategory_title2)
                    
                    let arr_subcategory_img2 = (object["subcategory_image"]as! String)
                    JSON_FIELDS.arr_subcategory_image2.append(arr_subcategory_img2)
                }
            }
        }
        catch{print(error)
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == myCategoryCollectionView{
            myCategoryCollectionView.deselectItem(at: indexPath, animated: true)
           let subCat = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCatViewController")as! SubCatViewController
            selected_cat_id = JSON_FIELDS.arr_category_id[indexPath.row]
            selected_cat_name = JSON_FIELDS.arr_category_name[indexPath.row]
            subCat.cat_id = selected_cat_id
            subCat.cat_name = selected_cat_name
            print("First View Controller Cat Name:\(cat_name)")
            navigationController?.pushViewController(subCat, animated: true)
        }
            
            
        else if collectionView == mySubcategoryCollectionView{
            
            mySubcategoryCollectionView.deselectItem(at: indexPath, animated: true)
            let worker = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WorkerListingViewController")as! WorkerListingViewController
            selected_subcat_id = JSON_FIELDS.arr_subcategory_id[indexPath.row]
            selected_subcat_name = JSON_FIELDS.arr_subcategory_name[indexPath.row]
            
            worker.subcat_id = selected_subcat_id
            worker.subcat_name = selected_subcat_name
            navigationController?.pushViewController(worker, animated: true)
        }
            
        else //collectionView == mySubcategoryCollectionView2
        {
            
            mySubcategoryCollectionView2.deselectItem(at: indexPath, animated: true)
            let worker = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WorkerListingViewController")as! WorkerListingViewController
            selected_subcat_id = JSON_FIELDS.arr_subcategory_id2[indexPath.row]
            selected_subcat_name = JSON_FIELDS.arr_subcategory_name2[indexPath.row]
            worker.subcat_id = selected_subcat_id
            worker.subcat_name = selected_subcat_name
            navigationController?.pushViewController(worker, animated: true)

        }
        
    }
    
    
   
    @IBAction func btnViewSubCat1(_ sender: Any) {
        let SubCat = "1"
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCatViewController")as! SubCatViewController
        storyboard.cat_id = SubCat
        self.navigationController?.pushViewController(storyboard, animated: true)
        
    }
    
    
    
    @IBAction func btnViewSubCat2(_ sender: Any) {
        let SubCat = "2"
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCatViewController")as! SubCatViewController
        storyboard.cat_id = SubCat
        self.navigationController?.pushViewController(storyboard, animated: true)
        
    }
    
    
    
    @IBAction func btnInsurance(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InsuranceViewController")
        self.navigationController?.pushViewController(storyboard, animated: true)
        
      // It is For Local Notification
        //1
        let content = UNMutableNotificationContent()
        content.title = "Service Hub"
        content.subtitle = "from serviceHub.com"
        content.body = "Insurance Notification"
        
        // 2
        let imageName = "White Logo"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        content.attachments = [attachment]
        
        // 3
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        
        // 4
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    
    
    @IBAction func btnAllSubcategoryAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllSubcategoryViewController")
        self.navigationController?.pushViewController(storyboard, animated: true)
        
    }
    
    
    
}

