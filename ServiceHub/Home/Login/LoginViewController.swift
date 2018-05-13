//
//  LoginViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/27/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    var LoginEmailId = String()
    var Login_Email = String()
    var UserId = String()
    var UserName = String()
    
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnForgotPasswordAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordViewController")
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    var loginStatus = Int()
    var status = Int()
    var url = URL(string: "http://localhost/ProjectSem6/admin/flatable.phoenixcoded.net/default/API/LoginAPI.php")
    var appDelegate =  UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        txtEmail.delegate = self
        txtPassword.delegate = self
        // Do any additional setup after loading the view.
    }


    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail{
            txtPassword.becomeFirstResponder()
        }else if textField == txtPassword{
            txtPassword.resignFirstResponder()
        }
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            txtEmail.text = "chinmay.patel1112@gmail.com"
            txtPassword.text = "chinmay123"
        }
    }
    
    
    @IBAction func btnLoginAction(_ sender: Any) {
        let email = txtEmail.text
        let pass = txtPassword.text
        
        if txtEmail.text == ""
        {
            SKToast.show(withMessage: "Please enter Email ID.!")
        }
        else if txtPassword.text == ""
        {
            SKToast.show(withMessage: "Please enter Password.!")
        }
        else if email != "" && pass != ""{
            self.loginData()
        }
        
    }
    
    
    @IBAction func btnCreateAccount(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController")
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    
    
    func loginData()
    {
        //request the url for data url
        var request = URLRequest(url: url!)
        //pass the  method or request the method
        request.httpMethod = "POST"
        
        //pass the data through the textfield
        let postString = "email_id=\(txtEmail.text!)&password=\(txtPassword.text!)"
        //utf is a character endcoding for the shecial character
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        {//this method have three param bydefault
            data, response, error in
            
            guard let data = data, error == nil else{
                print("error=\(String(describing: error))")
                return
            }
            //checking the status of response
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("statusCode  should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            //SKToast.show(withMessage: "Please enter the correct password!")
            print("------------------------------------")
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                
                self.status = json["success"] as! Int
                print("Status \(self.loginStatus)")
                
                self.loginStatus = self.status
                print("loginStatus: \(self.loginStatus)")
                DispatchQueue.main.async
                    {
                        if self.loginStatus == 1
                        {
                            print("Status:=\(self.status)")
                            SKToast.show(withMessage: "Login successfull!")
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
                            self.LoginEmailId = self.txtEmail.text!
                          //  storyboard.Login_Email = self.LoginEmailId
                            
                            let prefs = UserDefaults.standard
                            
                            prefs.setValue(1, forKey: "success")
                            prefs.set(self.txtEmail.text, forKey: "email")
                            
                            //for the change password
                            let uid = json["userdata"]!["user_id"]
                            self.UserId = uid as! String
                            prefs.set(self.UserId, forKey: "user_id")
                            print("UserId:\(self.UserId)")
                            
                            // For User Name
                            let uname = json["userdata"]!["user_name"]
                            self.UserName = uname as! String
                            prefs.set(self.UserName, forKey: "user_name")
                            print("UserName:\(self.UserName)")
                            
//                            UserDefaults.standard.setValue(1, forKey: "success")
//                            UserDefaults.standard.set(self.txtEmail.text, forKey: "email")
                            self.navigationController?.pushViewController(storyboard, animated: true)
                            
                            self.txtEmail.text = ""
                            self.txtPassword.text = ""
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AfterLoginViewController")
//                            self.self.LoginEmailId = self.txtEmail.text!
//                            storyboard.Login_Email = LoginEmailId
//                            self.navigationController?.pushViewController(storyboard, animated: true)
                            
//                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                            let storyboard = storyBoard.instantiateViewController(withIdentifier: "AfterLoginViewController") as! AfterLoginViewController
//                            self.LoginEmailId = self.txtEmail.text!
//                            storyboard.Login_Email = self.LoginEmailId
//                            self.present(storyboard, animated: true, completion: nil)
                            
                        }
                        else if self.loginStatus == 0{
                            let prefs = UserDefaults.standard
                            
                            prefs.setValue(0, forKey: "success")
                           
                          //  UserDefaults.standard.setValue(0, forKey: "success")
                            self.appDelegate.logout = false
                            self.txtEmail.becomeFirstResponder()
                            SKToast.show(withMessage: "Login fail!")
                        }
                }
                
            }
            catch{print(error)
            }
        }
        task.resume()
        if loginStatus == 1
        {
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            print("Welcome User")
        }
    }
    
    
    
    
}
