//
//  ProfileViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/11/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var selected_user_name = String()
    
    var loginTitle = ["Login / Signup","About ServiceHub","Share ServiceHub","Write to us","Rate us"]
    var loginImg = ["Login","About","Share","WriteToUs","Rate"]
    
    
    var logoutTitle = ["Account Setting","Change Password","About ServiceHub","Share ServiceHub","Write to us","Rate us","Logout"]
    var logoutImg = ["AccountSetting","ChangePassword","About","Share","WriteToUs","Rate","Logout"]
    
    
    var loginStatus = 0 ;
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var lblWelcomeGuest: UILabel!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblLoginHeading: UILabel!
    @IBOutlet weak var lblLoginEmailId: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if loginStatus == 0
        {
            return loginTitle.count
        }
        else
        {
            return logoutTitle.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
     //   let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let cell = myTableView.dequeueReusableCell(withIdentifier: "MyCell") as! TableViewCell
        
        if loginStatus == 0
        {
           // cell?.textLabel?.text = loginTitle[indexPath.row]
            cell.ProfileName.text = loginTitle[indexPath.row]
            cell.imageView?.image = UIImage(named: loginImg[indexPath.row])
        }
        else
        {
          //  cell?.textLabel?.text = logoutTitle[indexPath.row]
            cell.ProfileName.text = logoutTitle[indexPath.row]
            cell.imageView?.image = UIImage(named: logoutImg[indexPath.row])
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if loginStatus == 0
        {
            
            if loginTitle[indexPath.row] == "Login / Signup"
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
                
            else if loginTitle[indexPath.row] == "Share ServiceHub"
            {
                // text to share
                let text = "This is some text that I want to share." + "www.google.com"
                
                // set up activity view controller
                let textToShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
                
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
                
            }
            else if loginTitle[indexPath.row] == "About ServiceHub"
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutServiceHub")
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
            else if loginTitle[indexPath.row] == "Write to us"
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WriteToUs")
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
            
        }
// Logout Code Start
        else
        {
            
            if logoutTitle[indexPath.row] == "Account Setting"
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountSettingViewController")
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
            else if logoutTitle[indexPath.row] == "Change Password"
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordViewController")
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
            else if logoutTitle[indexPath.row] == "Share ServiceHub"
            {
                // text to share
                let text = "This is some text that I want to share." + "www.google.com"
                
                // set up activity view controller
                let textToShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
                
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
                
            }
            else if logoutTitle[indexPath.row] == "About ServiceHub"
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutServiceHub")as! AboutServiceHubViewController
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
            else if logoutTitle[indexPath.row] == "Write to us"
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WriteToUs")as! WriteToUsViewController
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
            else if logoutTitle[indexPath.row] == "Logout"
            {
                
                
                
//                let alert = UIAlertController(title: "", message: "Logout Successful!", preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "Ok", style: .default, handler:
//                { (alert) in
//                    self.navigationController?.popViewController(animated: true)
//                })
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//                alert.addAction(okAction)
//                self.present(alert, animated: true, completion: nil)
                
                
                let refreshAlert = UIAlertController(title: "Log Out", message: "Are You Sure to Log Out ? ", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
                    
                        UserDefaults.standard.set(0, forKey: "success")
                        self.appDelegate.logout = true
//                    let logoutVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")as! ProfileViewController
//                    self.navigationController?.pushViewController(logoutVC, animated: true);
                    self.navigationController?.popViewController(animated: true)
                }))
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                    refreshAlert.dismiss(animated: true, completion: nil)
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            //    self.navigationController?.pushViewController(logoutVC, animated: true);
            }
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        myTableView.reloadData()
        myTableView.tableFooterView =  UIView()
        

        
        
     //   loginStatus = UserDefaults.standard.value(forKey: "success")as! Int
        
    
        
        var a = UserDefaults.standard.value(forKey: "success")
        
        print(a)
        
        
        if UserDefaults.standard.value(forKey: "success") != nil
        {
          
            loginStatus = UserDefaults.standard.value(forKey: "success")as! Int
        }
        else
        {
        //    loginStatus = UserDefaults.standard.value(forKey: "success")
        }
        
        
        if loginStatus == 0
        {
            lblWelcome.text = ""
            lblWelcomeGuest.text = "Welcome Guest."
            lblWelcomeGuest.textColor = UIColor.blue
            lblLoginHeading.text = ""
            lblLoginEmailId.text = ""
        }
        else
        {
            selected_user_name = UserDefaults.standard.value(forKey: "user_name") as! String
            print("selected_user_name =\(selected_user_name)")
            lblWelcomeGuest.text = ""
            lblWelcome.text = "Welcome " + selected_user_name + "."
            lblLoginHeading.text = "You are Login as :"
            lblLoginEmailId.text = UserDefaults.standard.value(forKey: "email") as! String
        }
        
        // Do any additional setup after loading the view.
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
