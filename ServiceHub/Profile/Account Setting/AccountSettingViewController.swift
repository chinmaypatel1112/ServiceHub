//
//  AccountSettingViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 4/7/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class AccountSettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
   // var user_id = "1"
    
    var selected_user_id = String()
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    
    
    //var areaName = [String]()
    var areaPickerView = UIPickerView()
    var selected_area = String()
    var areaId = String()
    
    
    @IBAction func btnSave(_ sender: Any) {
        
        if txtName.text == ""
        {
            SKToast.show(withMessage: "Please Enter Name")
        }
        else if txtMobileNo.text == ""
        {
            SKToast.show(withMessage: "Please Enter Mobile No")
        }
        else if txtEmailId.text == ""
        {
            SKToast.show(withMessage: "Please Enter Email ID")
        }
        else if txtAddress.text == ""
        {
            SKToast.show(withMessage: "Please Enter Address")
        }
        else if txtArea.text == ""
        {
            SKToast.show(withMessage: "Please Select Area")
        }
        else if(txtName.text! == "" || txtMobileNo.text! == "" || txtEmailId.text! == "" || txtAddress.text! == "" || txtArea.text! == "")
        {
            SKToast.show(withMessage: "Please Enter Details")
        }
        else
        {
            self.UserData()
        }
        
    }
    
    
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selected_user_id = UserDefaults.standard.value(forKey: "user_id") as! String
        print("selected_user_id =\(selected_user_id)")
        
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
        
        txtEmailId.isUserInteractionEnabled = false
        txtEmailId.textColor = UIColor.gray
        fetch_account_data()
       
        url = URL(string: API_WEB_URL.ACCOUNT_SETTING_UPDATE)
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
        
        fetch_account_area()
    }
    
    
    func fetch_account_area()
    {
        let url = URL(string: API_WEB_URL.AREA_URL )
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            //JSON_FIELDS.arr_account_area.removeAll()
            //JSON_FIELDS.arr_account_areaId.removeAll()
            
            if let arrayJson = adata["area"] as? NSArray
            {
                print("arrJsonArea = \(arrayJson)")
                for index in 0...(adata["area"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_account_areaIdJSON = (object["area_id"]as! String)
                    JSON_FIELDS.arr_account_areaId.append(arr_account_areaIdJSON)
                    
                    let arr_account_areaNameJSON = (object["area_name"]as! String)
                    JSON_FIELDS.arr_account_area.append(arr_account_areaNameJSON)
                    
                }
            }
        }
        catch{
            print(error)
        }
        
    }
    
    @IBAction func selectArea(_ sender: UITextField) {
        areaPickerView.delegate = self
        txtArea.inputView = areaPickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let btnClick = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked2))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(doneClicked2))
        
        toolBar.setItems([cancelButton, spaceButton, btnClick], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtArea.inputView = areaPickerView
        txtArea.inputAccessoryView = toolBar
    }
    
    
    @objc func doneClicked2() {
        txtArea.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return JSON_FIELDS.arr_account_area.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return JSON_FIELDS.arr_account_area[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selected_area = JSON_FIELDS.arr_account_areaId[pickerView.selectedRow(inComponent: 0)]
        txtArea.text = JSON_FIELDS.arr_account_area[row]
        let area = JSON_FIELDS.arr_account_area[row]
        
        print("area:=\(area)")
        
    }
    
    func fetch_account_data()
    {
        let url = URL(string: API_WEB_URL.ACCOUNT_SETTING + selected_user_id)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            //JSON_FIELDS.arr_account_area.removeAll()
           // JSON_FIELDS.arr_account_id.removeAll()
            JSON_FIELDS.arr_account_name.removeAll()
            JSON_FIELDS.arr_account_mobileNo.removeAll()
            JSON_FIELDS.arr_account_emailId.removeAll()
            JSON_FIELDS.arr_account_address.removeAll()
            JSON_FIELDS.arr_account_areaId.removeAll()
            JSON_FIELDS.arr_account_Selected_areaName.removeAll()
            
            
            if let arrayJson = adata["Account Setting"] as? NSArray
            {
                
                for index in 0...(adata["Account Setting"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_account_idJSON = (object["user_id"]as! String)
                    JSON_FIELDS.arr_account_id.append(arr_account_idJSON)
                    print("JSON_FIELDS.arr_account_id = \(JSON_FIELDS.arr_account_id)")
                    
                    let arr_account_nameJSON = (object["user_name"]as! String)
                    JSON_FIELDS.arr_account_name.append(arr_account_nameJSON)
                    print("JSON_FIELDS.arr_account_name = \(JSON_FIELDS.arr_account_name)")
                    
                    let arr_account_mobileNoJSON = (object["mobile_no"]as! String)
                    JSON_FIELDS.arr_account_mobileNo.append(arr_account_mobileNoJSON)
                    
                    let arr_account_emailIdJSON = (object["email_id"]as! String)
                    JSON_FIELDS.arr_account_emailId.append(arr_account_emailIdJSON)
                    
                    let arr_account_addressJSON = (object["address"]as! String)
                    JSON_FIELDS.arr_account_address.append(arr_account_addressJSON)
                    
                    let arr_account_areaIdJSON = (object["area_id"]as! String)
                    JSON_FIELDS.arr_account_areaId.append(arr_account_areaIdJSON)
                    
                    let arr_account_areaJSON = (object["area_name"]as! String)
                    JSON_FIELDS.arr_account_Selected_areaName.append(arr_account_areaJSON)
                }
            }
        }
        catch{
            print(error)
        }
       txtName.text = JSON_FIELDS.arr_account_name
        txtMobileNo.text = JSON_FIELDS.arr_account_mobileNo
        txtEmailId.text = JSON_FIELDS.arr_account_emailId
        txtAddress.text = JSON_FIELDS.arr_account_address
        txtArea.text = JSON_FIELDS.arr_account_Selected_areaName
        
    }
    
    
    
    func UserData()
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "user_name=\(txtName.text!)&mobile_no=\(txtMobileNo.text!)&email_id=\(txtEmailId.text!)&address=\(txtAddress.text!)&area_id=\(selected_area)&user_id=\(selected_user_id)"
        
        print("postString =\(postString)")
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
            print("Write to Us Successful!")
            
            
            DispatchQueue.main.sync {
                let  alert = UIAlertController(title: "", message: "User Profile Update Successfull.!", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler:
                { (alert) in
                    
//                    let HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//                    self.navigationController?.pushViewController(HomeViewController, animated: true)
                    
                    self.navigationController?.popViewController(animated: true)
                    
                })
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                self.txtName.text = ""
                self.txtMobileNo.text = ""
                self.txtEmailId.text = ""
                self.txtAddress.text = ""
                self.txtArea.text = ""

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
