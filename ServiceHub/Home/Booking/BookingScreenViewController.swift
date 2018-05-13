//
//  BookingScreenViewController.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 4/18/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class BookingScreenViewController: UIViewController {

    
    
    
    
    
    @IBOutlet weak var myView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        myView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapGesture() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController")
        self.navigationController?.pushViewController(storyboard, animated: true)
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
