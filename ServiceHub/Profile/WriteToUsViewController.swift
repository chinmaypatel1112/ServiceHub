//
//  WriteToUsViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/12/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class WriteToUsViewController: UIViewController {

//    @IBAction func btnBack(_ sender: Any) {
//    self.navigationController?.popViewController(animated: true)
//    }
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtMessage: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = URL(string: API_WEB_URL.CONTACT_URL)
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
    
  
    
    
    @IBAction func btnSendAction(_ sender: Any) {
        if txtName.text == ""
        {
            SKToast.show(withMessage: "Please Enter Name")
        }
        else if txtEmailId.text == ""
        {
            SKToast.show(withMessage: "Please Enter Email ID")
        }
        else if txtMobileNo.text == ""
        {
            SKToast.show(withMessage: "Please Enter Mobile No")
        }
        else if txtMessage.text == ""
        {
            SKToast.show(withMessage: "Please Enter Message")
        }
        else if(txtName.text! == "" || txtEmailId.text! == "" || txtMobileNo.text! == "" || txtMessage.text! == "")
        {
            SKToast.show(withMessage: "Please Enter Details")
        }
        else
        {
            self.ContactData()
        }
    }
    
    
    
    func ContactData()
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "contact_name=\(txtName.text!)&email_id=\(txtEmailId.text!)&mobile_no=\(txtMobileNo.text!)&message=\(txtMessage.text!)"
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
                let  alert = UIAlertController(title: "", message: "Write to Us Successfull.!", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler:
                { (alert) in
                    
                    //                    let HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
                    //                    self.navigationController?.pushViewController(HomeViewController, animated: true)
                    
                })
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                self.txtName.text = ""
                self.txtEmailId.text = ""
                self.txtMobileNo.text = ""
                self.txtMessage.text = ""
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
