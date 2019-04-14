//
//  ViewController.swift
//  LAMLAI alamofire
//
//  Created by Mac on 1/19/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
struct Objects {
    var key : String!
    var listCountry = [Country]()
}
class AlbumCountryViewController: UIViewController, UISearchControllerDelegate {
    
    
    var dividedArray:NSMutableArray = []
    let sections = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    
    let refreshControl = UIRefreshControl()
    
    var listcoutry = [Country]()
    
    var arrayData = [Objects]()
    
    var listCountrySearch = [Country]()
    @IBOutlet weak var tableview: UITableView!    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableview.dataSource = self
        tableview.delegate = self
        
        getRequestAPICall()
        callsearchbar()
        callRefreshcontrol()
        loadingData()
    }
    // ket thuc loading Data
    override func viewDidAppear(_ animated: Bool) {
        dismiss(animated: false, completion: nil)
    }
    
    
    
    // goi thanh chờ loading data
    func loadingData() {
        
        let alert = UIAlertController(title: nil, message: "Loading Data...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    //    khi k có internet goi refreshcontrol
    
    func callRefreshcontrol(){
        if #available(iOS 10.0, *) {
            self.tableview.refreshControl = refreshControl
        } else {
            self.tableview.addSubview(refreshControl)
        }
        // Setup Refresh Control
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        self.refreshControl.tintColor = UIColor.lightGray
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading Data", attributes: attributes)
        
    }
    
    
    @objc private func updateData() {
        
        getRequestAPICall()
        self.tableview.reloadData()
        self.refreshControl.endRefreshing()
        
        
    }
    
    
    
    //   goi searchbar hoat dong
    func callsearchbar(){
        // lay search bar
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableview.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search Country"
        searchController.delegate = self
        searchController.searchBar.delegate = self
        tableview.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    // loc noi dung
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        listCountrySearch = listcoutry.filter({( country : Country) -> Bool in
            return country.namecountry!.lowercased().contains(searchText.lowercased())
        })
        tableview.reloadData()
    }
    
    // dang search noi dung
    func  isFiltering () -> Bool {
        return searchController.isActive && !searchBarIsEmpty ()
    }
    
    //
    
    
    func setupTableViewBackgroundView() {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.text = " Oops, No results to show "
        backgroundViewLabel.textAlignment = NSTextAlignment.center
        backgroundViewLabel.font.withSize(20)
        tableview.backgroundView = backgroundViewLabel
    }
    //    xử lí thanh tuỳ chọn chử cái
    func sortWithAlphabet() {
        //hasPrefix: ham kiem tra ky tu dau tien cua string
        // tableview phai dung array dang [String: [Country]]()
        
        for key in sections {
            var arrayCountry = [Country]()
            for country in listcoutry {
                if ((country.namecountry?.hasPrefix(key))!) {
                    arrayCountry.append(country)
                }
            }
            if (arrayCountry.count > 0) {
                let obj = Objects(key: key, listCountry: arrayCountry)
                arrayData.append(obj)
            }
        }
    }
    
    
    // get Api
    func getRequestAPICall()  {
        self.listcoutry.removeAll()
        Alamofire.request(UrlApi, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
                if let listData = response.result.value as? [[String: Any]] {
                    for dic in listData {
                        let country = Country(Json: dic)
                        self.listcoutry.append(country)
                        
                    }
                    
                    self.sortWithAlphabet()
                    self.tableview.reloadData()
                    
                }
        }
        
        
    }
    
}
extension AlbumCountryViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // a - z
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering(){
            return 1
        }
        return arrayData.count
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sections
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let object = self.arrayData[section]
        return object.key
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // khi dang search
        if isFiltering() {
            return listCountrySearch.count
            
        } else {
            let object = self.arrayData[section]
            return object.listCountry.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AbumTableViewCell
        
        
        
        // khi dang search
        let callcountry:Country
        if isFiltering(){
            callcountry = listCountrySearch[indexPath.row]
            
        } else {
            
            // khi dang a-z
            let object = self.arrayData[indexPath.section]
            callcountry = object.listCountry[indexPath.row]
            
            
        }
        cell.country_label.text = callcountry.namecountry ?? ""
        cell.demonym_label.text = callcountry.namedemonym ?? ""
        
        let alpha2Code = callcountry.alpha2Code ?? ""
        cell.image_logo.image = UIImage(named: alpha2Code.lowercased())
        
        //
        //            let url = URL(string: callcountry.flag!)
        //            let request = URLRequest.init(url: url!)
        //
        //
        //
        //            cell.webview_logos.load(request)
        
        
        return cell
        
        
        
        
        
        //        Alamofire.request("https://httpbin.org/image/png").responseImage { response in
        //            debugPrint(response)
        //
        //            if let images = response.result.value {
        //               cell.image_logo.image = images
        //            }
        //
        //        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowheightCountry
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // taoj storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // tao man hinh 2
        let screentwo = storyboard.instantiateViewController(withIdentifier: "newtwo")as!AbumDetailViewController
        // khi dang search
        let searchfilteredDataa:Country
        if isFiltering(){
            searchfilteredDataa = listCountrySearch[indexPath.row]
        } else{
            // khi dang a-z
            let Object = arrayData[indexPath.section]
            searchfilteredDataa = Object.listCountry[indexPath.row]
        }
        
        
        screentwo.imagelabel = searchfilteredDataa.alpha2Code?.lowercased()
        screentwo.Detailcountry = searchfilteredDataa.namecountry!
        screentwo.Detailcell = searchfilteredDataa.namecountry
        screentwo.regions = searchfilteredDataa.region
        screentwo.cioc = searchfilteredDataa.cioc
        screentwo.nativeName = searchfilteredDataa.nativeName
        screentwo.numericCode = searchfilteredDataa.numericCode
        
        self.navigationController?.pushViewController(screentwo, animated: true)
        
    }
    
}

extension AlbumCountryViewController: UISearchResultsUpdating {
    //    searchbar
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
}


