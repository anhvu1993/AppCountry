//
//  OpenCountry.swift
//  LAMLAI alamofire
//
//  Created by Mac on 1/23/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
import SystemConfiguration
class OpenCountry: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction(){
        let storyboar = UIStoryboard(name: "Main", bundle: nil)
        let newnex = storyboar.instantiateViewController(withIdentifier: "Country")
        self.navigationController?.pushViewController(newnex, animated: false)
    }
    
    // thong bao khong co internet
    override func viewDidAppear(_ animated: Bool) {
        
        if CheckInternet.Connection(){
            print("loading internet")
            //            self.Alert(Message: "Connected")
        }
            
        else{
            self.Alert(Message: "No Internet, please connect wifi")
        }
    }
    func Alert (Message: String){
        
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}






