//
//  BookingViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 4/4/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var subcat_id = String()
    var subcat_name = String()
    var workerId = String()
    var workerName = String()
    var workerServiceCharge = String()
    
    var SubCategory_id = String()
//    var user_id = "1"
    var selected_user_id = String()
    
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBOutlet weak var BookingScrollView: UIScrollView!
    
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var BookingDatePicker: UIDatePicker!
    @IBOutlet weak var BookingTimePicker: UIDatePicker!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var SubcategoryImage: UIImageView!
    @IBOutlet weak var SubcategoryName: UILabel!
    
    @IBOutlet weak var WorkerImage: UIImageView!
    @IBOutlet weak var WorkerName: UILabel!
    
    @IBOutlet weak var txtBookingAddress: UITextField!
    @IBOutlet weak var txtBookingArea: UITextField!
    @IBOutlet weak var lblBookingAmount: UILabel!
    
    
    var areaPickerView = UIPickerView()
    var selected_area = [String]()
    var areaId = String()
    
    @IBAction func BookingDatePickerAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: BookingDatePicker.date)
        lblDate.text = strDate
    }
    
    @IBAction func BookingTimePickerAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let strDate = dateFormatter.string(from: BookingTimePicker.date)
        lblTime.text = strDate
        
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selected_user_id = UserDefaults.standard.value(forKey: "user_id") as! String
        print("selected_user_id =\(selected_user_id)")
        
        // For View 1 Shadow
        View1.layer.shadowColor = UIColor.black.cgColor
        View1.layer.shadowRadius = 1.7
        View1.layer.shadowOpacity = 0.2
        
        // For Veiw 2 Shadow
        View2.layer.shadowColor = UIColor.black.cgColor
        View2.layer.shadowRadius = 1.7
        View2.layer.shadowOpacity = 0.2
        
        // Select Date and Time
        BookingDatePicker.datePickerMode = UIDatePickerMode.date
        BookingTimePicker.datePickerMode = UIDatePickerMode.time
        
        BookingScrollView.delegate = self
        BookingScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1900)
        
        WorkerImage.layer.cornerRadius = WorkerImage.frame.size.width / 2
        WorkerImage.clipsToBounds = true
        WorkerImage.layer.borderWidth = 2
        WorkerImage.layer.borderColor = UIColor.black.cgColor
        
        txtBookingAddress.layer.cornerRadius = 20
        txtBookingAddress.clipsToBounds = true
        
        txtBookingArea.layer.cornerRadius = 20
        txtBookingArea.clipsToBounds = true
        
        SubcategoryImage.layer.cornerRadius = 20
        SubcategoryImage.clipsToBounds = true
        
        SubcategoryName.backgroundColor = UIColor.black.withAlphaComponent(0.40)
        SubcategoryName.isOpaque = true
        SubcategoryName.layer.cornerRadius = 20
        SubcategoryName.clipsToBounds = true
        
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
        fetch_account_area()
    
        fetch_workerDetails_images()
        
        fetch_account_data()
        
        
        
        
        url = URL(string: API_WEB_URL.BOOKING_URL)
        urlRequest = NSMutableURLRequest(url: url as URL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                print("Successfully connected..")
            }
        }
        task.resume()
        
        // Do any additional setup after loading the view.
    }

    
    func fetch_workerDetails_images()
    {
        print("WorkerId:\(workerId)")
        let url = URL(string:API_WEB_URL.WORKER_DEATAILS + workerId)
        print("Fetch Worker Details URL:\(url)")
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            //when you again request for sub catefory the id will be clear for new request
            JSON_FIELDS.arr_Booking_Worker_id.removeAll()
            JSON_FIELDS.arr_Booking_Worker_Name.removeAll()
            JSON_FIELDS.arr_Booking_Worker_Image.removeAll()
            JSON_FIELDS.arr_Booking_Subcat_id.removeAll()
            JSON_FIELDS.arr_Booking_Subcat_Name.removeAll()
            JSON_FIELDS.arr_Booking_Subcat_Image.removeAll()
            JSON_FIELDS.arr_Booking_Amount.removeAll()
            //workerId.removeAll()
            //subcat_id.removeAll()
            //subcat_name.removeAll()
            
            
            
            if let arrayJson = adata["worker"] as? NSArray
            {
                
                
                for index in 0...(adata["worker"]?.count)! - 1{
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let worker_PhotoJson = (object["photo"]as! String)
                    JSON_FIELDS.arr_Booking_Worker_Image.append(worker_PhotoJson)
                    
                    let worker_IdJson = (object["worker_id"]as! String)
                    JSON_FIELDS.arr_Booking_Worker_id.append(worker_IdJson)
                    print("JSON_FIELDS.arr_Booking_Worker_id:\(JSON_FIELDS.arr_Booking_Worker_id)")
                    
                    let worker_NameJson = (object["worker_name"]as! String)
                    JSON_FIELDS.arr_Booking_Worker_Name.append(worker_NameJson)
                    print("JSON_FIELDS.arr_Booking_Worker_Name:\(JSON_FIELDS.arr_Booking_Worker_Name)")
                    
                    let worker_ChargesJson = (object["service_charge"]as! String)
                    JSON_FIELDS.arr_Booking_Amount.append(worker_ChargesJson)
                    
                    let worker_SubCatJson = (object["subcategory_id"]as! String)
                    SubCategory_id = (object["subcategory_id"]as! String)
                    JSON_FIELDS.arr_Booking_Subcat_id.append(worker_SubCatJson)
                    print("SubCategory_id:\(SubCategory_id)")
                    
                    let worker_SubCatNameJson = (object["subcategory_name"]as! String)
                    JSON_FIELDS.arr_Booking_Subcat_Name.append(worker_SubCatNameJson)
                    
                    let worker_SubCatImageJson = (object["subcategory_image"]as! String)
                    JSON_FIELDS.arr_Booking_Subcat_Image.append(worker_SubCatImageJson)
                    
//                    // User Address and Area
//                    let worker_AreaIdJson = (object["area_id"]as! String)
//                    JSON_FIELDS.arr_Booking_Area_id.append(worker_AreaIdJson)
//
//                    let worker_AreaNameJson = (object["area_name"]as! String)
//                    JSON_FIELDS.arr_Booking_Area_Name.append(worker_AreaNameJson)

                    
                }
            }
        }
        catch{print("error:\(error)")
        }
        fetch_worker_Details()
    }
    
    
    
    func fetch_worker_Details() {
        
        WorkerName.text = JSON_FIELDS.arr_Booking_Worker_Name
        SubcategoryName.text = JSON_FIELDS.arr_Booking_Subcat_Name
        lblBookingAmount.text = JSON_FIELDS.arr_Booking_Amount
        
        
        
        if let imageURL = URL(string: API_WEB_URL.MAIN_URL + JSON_FIELDS.arr_Booking_Worker_Image)
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
                            self.WorkerImage.image = image
                        }
                    }
            }
        }
        
        
        if let subCatURL = URL(string: API_WEB_URL.MAIN_URL + JSON_FIELDS.arr_Booking_Subcat_Image)
        {
            //print(imageURL)
            //call the main thread ..when we are not in main thread then it necessary to call the main thread
            DispatchQueue.global().async
                {
                    //store url into data format
                    let data = try? Data(contentsOf: subCatURL)
                    if let data = data
                    {
                        //store data into 1 VARIABLE
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            //AGAIN WE HAVE TO CALL THE MAIN thread
                            //and assign the variable value into cell image view
                            self.SubcategoryImage.image = image
                        }
                    }
            }
        }
        
    }
    
    
    
    // For Area Picker View
    
    func fetch_account_area()
    {
        let url = URL(string: API_WEB_URL.AREA_URL )
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            if let arrayJson = adata["area"] as? NSArray
            {
                for index in 0...(adata["area"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_account_areaIdJSON = (object["area_id"]as! String)
                    JSON_FIELDS.arr_Booking_Area_id.append(arr_account_areaIdJSON)
                    
                    let arr_account_areaNameJSON = (object["area_name"] as! String)
                    JSON_FIELDS.arr_Booking_Area_Name.append(arr_account_areaNameJSON)
                    
                }
            }
        }
        catch{
            print(error)
        }
        
    }
    
    
    @IBAction func txtSelectArea(_ sender: Any) {
        areaPickerView.delegate = self
        txtBookingArea.inputView = areaPickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let btnClick = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked2))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(doneClicked2))
        
        toolBar.setItems([cancelButton, spaceButton, btnClick], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtBookingArea.inputView = areaPickerView
        txtBookingArea.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked2() {
        txtBookingArea.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return JSON_FIELDS.arr_Booking_Area_id.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return JSON_FIELDS.arr_Booking_Area_Name[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_area = [JSON_FIELDS.arr_Booking_Area_id[pickerView.selectedRow(inComponent: 0)]]
        areaId = JSON_FIELDS.arr_Booking_Area_id[row]
        txtBookingArea.text = JSON_FIELDS.arr_Booking_Area_Name[row]
    }
    
    
    
    // For Address Fetch from Database
    
    func fetch_account_data()
    {
        let url = URL(string: API_WEB_URL.ACCOUNT_SETTING + selected_user_id)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            JSON_FIELDS.arr_Booking_Address.removeAll()
            JSON_FIELDS.arr_Booking_Selected_AreaName.removeAll()
            
            if let arrayJson = adata["Account Setting"] as? NSArray
            {
                for index in 0...(adata["Account Setting"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_account_idJSON = (object["user_id"]as! String)
                    JSON_FIELDS.arr_Booking_User_id.append(arr_account_idJSON)
                    
                    let arr_account_addressJSON = (object["address"]as! String)
                    JSON_FIELDS.arr_Booking_Address.append(arr_account_addressJSON)
                    print("JSON_FIELDS.arr_Booking_Address:\(JSON_FIELDS.arr_Booking_Address)")
                    
                    let arr_account_areaJSON = (object["area_name"]as! String)
                    JSON_FIELDS.arr_Booking_Selected_AreaName.append(arr_account_areaJSON)
                }
            }
        }
        catch{
            print(error)
        }
        fetch_user_data()
    }
    
    func fetch_user_data() {
        txtBookingAddress.text = JSON_FIELDS.arr_Booking_Address
        txtBookingArea.text = JSON_FIELDS.arr_Booking_Selected_AreaName
    }
    
    
    @IBAction func btnPlaceBookingAction(_ sender: Any) {
        if txtBookingAddress.text == ""
        {
            SKToast.show(withMessage: "Please Enter Address")
        }
        else if txtBookingArea.text == ""
        {
            SKToast.show(withMessage: "Please Select Area")
        }
        else if lblDate.text == ""
        {
            SKToast.show(withMessage: "Please Set Date")
        }
        else if lblTime.text == ""
        {
            SKToast.show(withMessage: "Please Set Time")
        }
        else if(txtBookingAddress.text! == "" || txtBookingArea.text! == "" || lblDate.text! == "" || lblTime.text! == "")
        {
            SKToast.show(withMessage: "Please Enter Details")
        }
        else
        {
            self.BookingData()
        }
        
    }
    
    
    
    func BookingData()
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "booking_date=\(lblDate.text!)&worker_id=\(workerId)&user_id=\(selected_user_id)&price=\(lblBookingAmount.text!)&address=\(txtBookingAddress.text!)&area_id=\(areaId)&time=\(lblTime.text!)&subcategory_id=\(JSON_FIELDS.arr_Booking_Subcat_id)"
        print("postString=\(String(describing: postString))")
        request.httpBody = postString.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            
            guard let data = data, error == nil else{
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {// check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            print("Booking Successful!")
            
            
            DispatchQueue.main.sync {
                let  alert = UIAlertController(title: "", message: "Booking Successfull.!", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler:
                { (alert) in
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingScreenViewController")
                    self.navigationController?.pushViewController(storyboard, animated: true)
                    
                })
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                
//                print("self.workerId= \(self.workerId)")
//                print("self.user_id= \(self.user_id)")
//                print("self.lblTime.text= \(self.lblTime.text)")
//                print("self.lblDate.text= \(self.lblDate.text)")
//                print("self.lblBookingAmount.text= \(self.lblBookingAmount.text)")
//                print("self.txtBookingAddress.text= \(self.txtBookingAddress.text)")
//                print("self.txtBookingArea.text= \(self.txtBookingArea.text)")
                
                self.lblTime.text = ""
                self.lblDate.text = ""
                self.lblBookingAmount.text = ""
                self.txtBookingAddress.text = ""
                self.txtBookingArea.text = ""
                self.SubCategory_id = ""
            }
            
        }
        task.resume()
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
