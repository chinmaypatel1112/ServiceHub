//
//  ForgotPasswordViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 4/7/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = URL(string: API_WEB_URL.FORGOTPASSWORD_URL)
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
    
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            txtEmail.text = "chinmay.patel1112@gmail.com"
        }
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        
        if txtEmail.text == ""
        {
            SKToast.show(withMessage: "Please Enter Email ID")
        }
        else
        {
            self.ForgotPasswordData()
        }
    }
    
    
    func ForgotPasswordData()
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "email_id=\(txtEmail.text!)"
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
            print("Forgot Password Successful!")
            
            
            DispatchQueue.main.sync {
                let  alert = UIAlertController(title: "", message: "Password will be Send Successfull.!", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler:
                { (alert) in
                    
                    let ForgotPass = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.navigationController?.pushViewController(ForgotPass, animated: true)
                    
                })
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                self.txtEmail.text = ""
                
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
