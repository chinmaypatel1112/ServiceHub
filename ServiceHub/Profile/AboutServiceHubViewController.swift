//
//  AboutServiceHubViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/12/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class AboutServiceHubViewController: UIViewController {

    
    
    @IBAction func btnBack(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
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
