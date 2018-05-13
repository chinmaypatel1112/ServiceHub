//
//  API_WEB_URL.swift
//  LoginDemoJSON
//
//  Created by Akash Padhiyar on 3/14/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class API_WEB_URL: UIViewController {

   
   //We are running on localhost only. 
    static var MAIN_URL = "http://localhost/ProjectSem6/admin/flatable.phoenixcoded.net/default/"
    
    static var SLIDER_IMAGES = MAIN_URL + "API/SliderAPI.php"
    
    static var SLIDER_IMAGES2 = MAIN_URL + "API/SliderAPI2.php"
    
    static var CATEGORY_IMAGE = MAIN_URL + "API/CategoryAPI.php"
    
    static var SUBCATEGORY_IMAGE = MAIN_URL + "API/SubcategoryAPI.php?category_id="
    
    static var WORKER_MASTER = MAIN_URL + "WorkerMasterAPI.php?subcategory_id="
    
    static var LOGIN_URL = MAIN_URL + "API/LoginAPI.php"
    
    static var SIGNUP_URL = MAIN_URL + "API/SignupAPI.php"
    
    static var FORGOTPASSWORD_URL = MAIN_URL + "API/ForgotPasswordAPI.php"
    
    static var CONTACT_URL = MAIN_URL + "API/ContactAPI.php"
    
    static var WORKER_DEATAILS = MAIN_URL + "WorkerDetailsAPI.php?worker_id="
    
    static var ALL_SUBCATEGORY_IMAGE = MAIN_URL + "API/SubcategoryAPI.php"
    
    static var ACCOUNT_SETTING = MAIN_URL + "API/AccountSettingViewAPI.php?user_id="
    
    static var ACCOUNT_SETTING_UPDATE = MAIN_URL + "API/AccountSettingAPI.php"
    
    static var AREA_URL = MAIN_URL + "API/AreaAPI.php"
    
    static var BOOKING_URL = MAIN_URL + "Booking.php"
    
    static var LOCATION_URL = MAIN_URL + "API/SearchLocation.php"
    
    static var VIEWBOOKING_URL = MAIN_URL + "ViewBookingAPI.php?user_id="

}


