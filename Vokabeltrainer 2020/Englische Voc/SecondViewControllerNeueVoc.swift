//
//  SecondViewControllerNeueVoc.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 24.01.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
// NEUE VOKABELN

import UIKit
import UserNotifications



class SecondViewControllerNeueVoc: UIViewController {
var deutschesWort = ""
var englischesWort = ""
    
    
    @IBOutlet weak var btnSpeichern: UIButton!
    @IBOutlet weak var textDeutsch: UITextField!
    @IBOutlet weak var textEnglisch: UITextField!
    @IBOutlet weak var lblErrorHandler: UILabel!
    @IBOutlet weak var lblBtnSave: UIButton!
    
    
    // Button speichern
    @IBAction func btnSpeichern(_ sender: UIButton) {
        if textEnglisch.text!.isEmpty || textDeutsch.text!.isEmpty{
            lblErrorHandler.isHidden = false
            lblErrorHandler.text = "Error 0815: Beide Textfelder ausfüllen"
        }else{
            lblErrorHandler.isHidden = true
            deutschesWort = textDeutsch.text!
            englischesWort = textEnglisch.text!
            // Wenn Keywort bereits existiert
            if woerterBuch[deutschesWort] != nil{
                lblErrorHandler.isHidden = false
                lblErrorHandler.text = "Error 4711: Das Wort \(deutschesWort) existiert bereits"
            }else{
                    woerterBuch[deutschesWort] = englischesWort
                    firstOfFourStacks[deutschesWort] = englischesWort
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblErrorHandler.isHidden = true
        textDeutsch.becomeFirstResponder()
        themeColor()
        lblBtnSave.layer.cornerRadius = 12
    }
    

    func saveDictionary (){
        UserDefaults.standard.set(woerterBuch, forKey: "gespWoerterbuch") // Speichert Wort in Wörterbuch
        UserDefaults.standard.set(firstOfFourStacks, forKey: "gespWoerterbuchFirstStack") // Speichert Wort in First Stack
    }
    
    func deleteTextfields(){
        textEnglisch.text = ""
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
