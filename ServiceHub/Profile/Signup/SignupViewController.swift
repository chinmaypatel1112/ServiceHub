//
//  SignupViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/27/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate,UIPickerViewDataSource {

    
    @IBOutlet weak var signupScrollView: UIScrollView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    
    @IBOutlet weak var btnSignup: UIButton!
    
//    @IBAction func btnBackAction(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
    
    var gender = ["Male","Female"]
    
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    var genderPickerView = UIPickerView()
    var selected_gender = [String]()
    
    var areaName = [String]()
    var areaPickerView = UIPickerView()
    var selected_area = [String]()
    var areaId = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
        
        signupScrollView.delegate = self
        signupScrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
        // Do any additional setup after loading the view.
        
        fetch_signup_area()
        
        url = URL(string: API_WEB_URL.SIGNUP_URL)
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
    }
    
    
    func fetch_signup_area()
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
                    let arr_signup_areaIdJSON = (object["area_id"]as! String)
                    JSON_FIELDS.arr_signup_areaId.append(arr_signup_areaIdJSON)
                    
                    let arr_signup_areaNameJSON = (object["area_name"]as! String)
                    JSON_FIELDS.arr_signup_areaName.append(arr_signup_areaNameJSON)
                    
                }
            }
        }
        catch{
            print(error)
        }
        
    }
    
    
    
    
    @IBAction func btnSignupAction(_ sender: Any) {
        if txtName.text == ""
        {
            SKToast.show(withMessage: "Please Enter Name..!")
        }
        else if txtGender.text == ""
        {
            SKToast.show(withMessage: "Please Select Gender..!")
        }
        else if txtMobileNo.text == ""
        {
            SKToast.show(withMessage: "Please Enter Mobile No..!")
        }
        else if txtEmailId.text == ""
        {
            SKToast.show(withMessage: "Please Enter Email ID..!")
        }
        else if txtPassword.text == ""
        {
            SKToast.show(withMessage: "Please Enter Password..!")
        }
        else if txtAddress.text == ""
        {
            SKToast.show(withMessage: "Please Enter Address..!")
        }
        else if txtArea.text == ""
        {
            SKToast.show(withMessage: "Please Select Area..!")
        }
        else if(txtName.text! == "" || txtGender.text! == "" || txtMobileNo.text! == "" || txtEmailId.text! == "" || txtPassword.text! == "" || txtAddress.text! == "" || txtArea.text! == "")
        {
            SKToast.show(withMessage: "Please Enter Details!")
        }
        else
        {
            self.RegistrationData()
        }
    }
    
    
    
    func RegistrationData()
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "user_name=\(txtName.text!)&gender=\(txtGender.text!)&mobile_no=\(txtMobileNo.text!)&email_id=\(txtEmailId.text!)&password=\(txtPassword.text!)&address=\(txtAddress.text!)&area_id=\(areaId)"
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
            print("Registration Successful!")
            
            DispatchQueue.main.sync {
                let  alert = UIAlertController(title: "", message: "Registration Successfull.!", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler:
                { (alert) in
                    
//                    let HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
//                    self.navigationController?.pushViewController(HomeViewController, animated: true)
                    
                })
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                self.txtName.text = ""
                self.txtGender.text = ""
                self.txtMobileNo.text = ""
                self.txtEmailId.text = ""
                self.txtPassword.text = ""
                self.txtAddress.text = ""
                self.txtArea.text = ""
            }
        }
        task.resume()
    }
    
    // For Gender
    @IBAction func txtSelectGender(_ sender: UITextField) {
        genderPickerView.delegate = self
        genderPickerView.tag = 1
        txtGender.inputView = genderPickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let btnClick = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(doneClicked))
        
        toolBar.setItems([cancelButton, spaceButton, btnClick], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtGender.inputView = genderPickerView
        txtGender.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        txtGender.resignFirstResponder()
    }
    
    
    
    // For Area
    @IBAction func txtSelectArea(_ sender: UITextField) {
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
        
        if (pickerView == genderPickerView)
        {
            return 1
        }
        else // (pickerView == areaPickerView)
        {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if (pickerView == genderPickerView)
        {
            return gender.count
        }
        else // (pickerView == areaPickerView)
        {
            return areaName.count
            //return JSON_FIELDS.arr_signup_areaName.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == genderPickerView)
        {
            return gender[row]
        }
        else // (pickerView == areaPickerView)
        {
            return areaName[row]
            //return JSON_FIELDS.arr_signup_areaName[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == genderPickerView)
        {
            selected_gender = [gender[pickerView.selectedRow(inComponent: 0)]]
            txtGender.text = gender[row]
        }
        else // (pickerView == areaPickerView)
        {
            selected_area = [areaName[pickerView.selectedRow(inComponent: 0)]]
            areaId = JSON_FIELDS.arr_signup_areaId[row]
            txtArea.text = JSON_FIELDS.arr_signup_areaName[row]
//            selected_area = [JSON_FIELDS.arr_signup_areaName[pickerView.selectedRow(inComponent: 0)]]
//            txtArea.text = JSON_FIELDS.arr_signup_areaName[row]
        }
    }
    
    
    @IBAction func btnBackToLoginAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
