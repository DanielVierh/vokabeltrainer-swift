//
//  LandingViewControllerKarteikart.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 21.02.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//

import UIKit

class LandingViewControllerKarteikart: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        themeColor()
    }
    
    
    func themeColor(){
        if theme == "dark"{
            //self.view.backgroundColor = UIColor.black
            self.view.backgroundColor = UIColor.init(named: "DarkThemeBack")
        }else{
            self.view.backgroundColor = UIColor.link
        }
    }

}
