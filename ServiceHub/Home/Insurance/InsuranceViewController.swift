//
//  InsuranceViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/22/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class InsuranceViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var InsuranceScrollView: UIScrollView!
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        InsuranceScrollView.delegate = self
        InsuranceScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1110)
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
