//
//  AbumTableViewCell.swift
//  LAMLAI alamofire
//
//  Created by Mac on 1/19/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
import WebKit
class AbumTableViewCell: UITableViewCell {
    


  
    
    @IBOutlet weak var image_logo: UIImageView!
    
    @IBOutlet weak var country_label: UILabel!
    
    @IBOutlet weak var demonym_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
     
    }

}
