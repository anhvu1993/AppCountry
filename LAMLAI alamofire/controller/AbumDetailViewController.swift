//
//  AbumViewController.swift
//  LAMLAI alamofire
//
//  Created by Mac on 1/20/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
import Alamofire
class AbumDetailViewController: UIViewController {
    var cioc:String!
    var nativeName:String!
    var numericCode:String!
    var regions:String!
    var Detailcell:String!
    var imagelabel:String!
    var Detailcountry:String!
    var listcountrys = [Country]()
    
    var mangDetails = [CallDetail] ()
    
    @IBOutlet weak var image_label: UIImageView!
    
    @IBOutlet weak var countrys_label: UILabel!
    
    @IBOutlet weak var tableviewnew: UITableView!
    
    @IBAction func back(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image_label.image = UIImage(named: imagelabel)
        
        // mang cho man hinh 2
        mangDetails =  [CallDetail(name: "NumericCode", value: Detailcell), CallDetail(name: "Gegion", value: regions ), CallDetail(name: "NativeName", value: nativeName), CallDetail(name: "Cioc", value: cioc), CallDetail(name: "numericCode", value: numericCode) ]
        
        countrys_label.text = Detailcountry
        
        tableviewnew.dataSource = self
        tableviewnew.delegate = self
        
        getRequestAPICalls()
        
    }
    
    func getRequestAPICalls()  {
        
        let todosEndpoint: String = "https://restcountries.eu/rest/v2/all"
        
        Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
                if let listdata = response.result.value as? [[String: Any]] {
                    for dic in listdata {
                        let listDetail = Country(Json: dic)
                        self.listcountrys.append(listDetail)
                        
                    }
                    self.tableviewnew.reloadData()
                }
                
                
                
                if let data = response.result.value{
                    // Response type-1
                    if  (data as? [[String : AnyObject]]) != nil{
                        print("data_1: \(data)")
                    }
                    // Response type-2
                    if  (data as? [String : AnyObject]) != nil{
                        print("data_2: \(data)")
                    }
                }
        }
    }
}





extension AbumDetailViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! AbumDetailTableViewCell
        
        cell.textLabel?.text = mangDetails[indexPath.row].name
        cell.textLabel?.textColor = UIColor.orange
        cell.detailTextLabel?.text = mangDetails[indexPath.row].value 
        
        return cell
        
        
    }
}

extension AbumDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowheighDetaiCountry
        
        
        
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


