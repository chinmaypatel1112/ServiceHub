//
//  AfterLoginViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 4/25/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class AfterLoginViewController: UIViewController {

    
    var Login_Email = String()
    
   // var LoginEmailId = String()
    
    @IBOutlet weak var txtEmailId: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // txtEmailId.text = Login_Email
        txtEmailId.text = UserDefaults.standard.value(forKey: "email") as! String
        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnTakeVisitAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController")
        self.navigationController?.pushViewController(storyboard, animated: true)
        
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
