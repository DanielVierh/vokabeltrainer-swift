//
//  NeueVocEsp.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 04.03.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//  NEUE VOKABEL EINTRAGEN

import UIKit

class NeueVocEsp: UIViewController {

    var deutschesWort = ""
    var spanischesWort = ""
        
        
        @IBOutlet weak var btnSpeichern: UIButton!
        @IBOutlet weak var textDeutsch: UITextField!
        @IBOutlet weak var textSpanish: UITextField!
        @IBOutlet weak var lblErrorHandler: UILabel!
        
        // Button speichern
        @IBAction func btnSpeichern(_ sender: UIButton) {
            if textSpanish.text!.isEmpty || textDeutsch.text!.isEmpty{
                lblErrorHandler.isHidden = false
                lblErrorHandler.text = "Error 0815: Beide Textfelder ausfüllen"
            }else{
                lblErrorHandler.isHidden = true
                deutschesWort = textDeutsch.text!
                spanischesWort = textSpanish.text!
                // Wenn Keywort bereits existiert
                if woerterBuchEsp[deutschesWort] != nil{
                    lblErrorHandler.isHidden = false
                    lblErrorHandler.text = "Error 4711: Das Wort \(deutschesWort) existiert bereits"
                }else{
                        woerterBuchEsp[deutschesWort] = spanischesWort
                        firstOfFourStacks[deutschesWort] = spanischesWort
                        saveDictionary() // Speichert das Hauptwörtbuch
                        deleteTextfields()
                        hapticFeedback()
                        animatedButton()
                    }
                }
        }
        
        
        @IBAction func btnDel(_ sender: UIButton) {
            deleteTextfields()
        }
        
    // VIEWDIDLOAD
        
        override func viewDidLoad() {
            super.viewDidLoad()
            lblErrorHandler.isHidden = true
            textDeutsch.becomeFirstResponder()
            themeColor()
        }
        
    
    // FUNKTIONEN

        func saveDictionary (){
            UserDefaults.standard.set(woerterBuchEsp, forKey: "gespWoerterbuchEsp") // Speichert Wort in Wörterbuch
            UserDefaults.standard.set(firstOfFourStacksEsp, forKey: "gespWoerterbuchFirstStackEsp") // Speichert Wort in First Stack
        }
        
        func deleteTextfields(){
            textSpanish.text = ""
            textDeutsch.text = ""
            textDeutsch.becomeFirstResponder()
            lblErrorHandler.isHidden = true
            buttonDruckFeedback()
        }
        
        
        // Button Feedback
        func hapticFeedback(){
             let notificaionFeedback = UINotificationFeedbackGenerator()
             notificaionFeedback.notificationOccurred(.error)
        }
        
        func buttonDruckFeedback(){
            let selectionFeedback = UISelectionFeedbackGenerator()
            selectionFeedback.selectionChanged()
        }
        
        func animatedButton(){
            let ausschlag: CGFloat = 30.0
            let midx = btnSpeichern.center.x
            let midy = btnSpeichern.center.y
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 3
            animation.autoreverses = true
            animation.fromValue = CGPoint(x: midx-ausschlag, y: midy)
            animation.toValue = CGPoint(x: midx + ausschlag, y: midy)
            btnSpeichern.layer.add(animation, forKey: "position")
        }
        
        
        // Eine Message Box erstellen
        func CreateAlert(title: String, message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert,animated: true, completion: nil)
        }
        // Theme
        func themeColor(){
            if theme == "dark"{
                self.view.backgroundColor = UIColor.init(named: "DarkThemeBack")
            }else{
                self.view.backgroundColor = UIColor.link
            }
        }

}
