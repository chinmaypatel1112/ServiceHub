//
//  ChangePasswordViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/27/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    var selected_user_id = String()
    
//    @IBAction func btnBackAction(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selected_user_id = UserDefaults.standard.value(forKey: "user_id") as! String
        
        print("selected_user_id =\(selected_user_id)")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnChangePassword(_ sender: Any) {
        if txtOldPassword.text == ""
        {
            SKToast.show(withMessage: "Enter Old password !")
        }
        else if txtNewPassword.text == ""
        {
            SKToast.show(withMessage: "Enter New password !")
        }
        else if txtConfirmPassword.text == ""
        {
            SKToast.show(withMessage: "Enter Confirm password !")
        }
        else if txtNewPassword.text != txtConfirmPassword.text
        {
            SKToast.show(withMessage: "New and Confirm password dosn't match !")
        }
        else if txtOldPassword.text != "" || txtNewPassword.text != "" || txtConfirmPassword.text != ""
        {
            change_user_password()
        }
        
    }
    
    
    func change_user_password()
    {

        let url = URL(string: "http://localhost/ProjectSem6/admin/flatable.phoenixcoded.net/default/API/ChangePasswordAPI.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "opass=\(txtOldPassword.text!)&npass=\(txtNewPassword.text!)&cpass=\(txtConfirmPassword.text!)&user_id=\(selected_user_id)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            print("Change Password Successful!")
            
            DispatchQueue.main.async
                {
                    let alert = UIAlertController(title: "", message: "Change Password Successful!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler:
                    { (alert) in
                        self.navigationController?.popViewController(animated: true)
                        self.txtNewPassword.text = ""
                        self.txtConfirmPassword.text = ""
                        self.txtOldPassword.text = ""
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
            }
        }
        task.resume()
        
        
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
