//
//  LandingViewControllerStart.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 04.03.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
// LANDING PAGE -- SPRACHAUSWAHL

import UIKit
// Einst.
var tippsEin = "true"
var theme = ""


class LandingViewControllerStart: UIViewController {
    @IBOutlet weak var lblBtnEngl: UIButton!
    @IBOutlet weak var lblBtnSettings: UIButton!
    @IBAction func btnEnglVoc(_ sender: UIButton) {
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        animateRotation()
        loadSettingsTips()
        loadSettingsTheme()
        themeColor()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        themeColor()
    }
    override func viewDidAppear(_ animated: Bool) {
        animateRotation()
    }
    
    // Animation Drehen
    func animateRotation(){
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 2.0 // or however long you want ...
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        lblBtnSettings.layer.add(rotation, forKey: "rotationAnimation")
    }
    
       func loadSettingsTips(){
           // settTips
           let mySettingsTipps = UserDefaults.standard.object(forKey: "settTips")
           if let gespSettingsTipps = mySettingsTipps as? NSString{
               tippsEin = gespSettingsTipps as (String)
           }
       }

       func loadSettingsTheme(){
           // settTheme
           let mySettingsTheme = UserDefaults.standard.object(forKey: "settTheme")
           if let gespSettingsTheme = mySettingsTheme as? NSString{
               theme = gespSettingsTheme as (String)
           }
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
