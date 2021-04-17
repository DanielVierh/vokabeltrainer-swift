//
//  siebteViewControllerSettings.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 10.02.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
// EINSTELLUNGEN

import UIKit

class siebteViewControllerSettings: UIViewController {
    @IBOutlet weak var lblBtnTips: UISwitch!
    @IBOutlet weak var txtLanguage: UITextField!
    @IBOutlet weak var lblBtnTheme: UISwitch!
    
    
    // Tips anzigen
    @IBAction func swtTipps(_ sender: UISwitch) {
        if lblBtnTips.isOn == true{
            tippsEin = "true"
        }else{
            tippsEin = "false"
        }
        UserDefaults.standard.set(tippsEin, forKey: "settTips")
    }
    
    // Theme
    @IBAction func setTheme(_ sender: UISwitch) { // settTheme
        if lblBtnTheme.isOn == true{
            theme = "normal"
            print("normal")
        }else{
            theme = "dark"
            print("dark")
        }
        UserDefaults.standard.set(theme, forKey: "settTheme")
    }
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // check Tipps
        if tippsEin == "true"{
            lblBtnTips.isOn = true
        }else{
            lblBtnTips.isOn = false
        }
        // show language
        txtLanguage.text = sprachauswahl
        
        // Check Theme
        if theme == "normal"{
            lblBtnTheme.isOn = true
        }else if theme == "dark"{
            lblBtnTheme.isOn = false
        }
    }
    



}
