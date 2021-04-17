//
//  StartSeite.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 04.03.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
// SPANISCH STARTSEITE

import UIKit
 // ---------------------------------------------------------------------------------------
// Globale Variable
var woerterBuchEsp = ["Hallo" : "hola"]
var dictStringEsp = ""
var numberOfVocEsp = 0
let sprachauswahlEsp = "es"
var globalIndexEsp = 0
var keysEsp: [String] = [ ]
var valuesEsp: [String] = [ ]
var woerterBuchArrayEsp: [String] = [ ]
var anzahlKannIchNochNichtEsp = 0
var woerterbuchWiederholenEsp = ["Hallo":"hello"] // Dict für falsche Vokabel aus dem vokabeltest

// Karteikarten Dicts
var firstOfFourStacksEsp = [String: String]() // Neu und kann ich noch nicht
var secondOfFourStacksEsp = [String: String]() // Kann ich ein bisschen
var thirdOfFourStacksEsp = [String: String]() // kann ich schon
var fourOfFourStacksEsp = [String: String]() // kann ich gut


 // ---------------------------------------------------------------------------------------


class StartSeite: UIViewController {

    @IBOutlet weak var lblVocableNumber: UILabel!
       @IBOutlet weak var lblAnzKannIchNochNicht: UILabel!
       @IBOutlet weak var lblProgressBar: UIActivityIndicatorView!
       
    // ---------------------------------------------------------------------------------------
       override func viewDidLoad() {
           super.viewDidLoad()
           loadWoerterbuch()
           showNumberOfVoc()
          // loadSettingsTips()
          // loadSettingsTheme()
           loadWoerterbuchFirstStack()
           loadWoerterbuchSecondStack()
           loadWoerterbuchThirdStack()
           loadWoerterbuchFourStack()
           dictInArray()
           loadWoerterbuchWiederholen()
           anzahlKannIchNochNichtEsp = woerterbuchWiederholenEsp.count
           lblAnzKannIchNochNicht.text = "\(anzahlKannIchNochNichtEsp) kann ich noch nicht"
           themeColor()
        print(woerterBuchEsp)
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           lblProgressBar.isHidden = true
       }
        // ---------------------------------------------------------------------------------------
       // Button
       
       
       @IBAction func btnVerw(_ sender: UIButton) {
           lblProgressBar.isHidden = false
       }
       
       
      // ---------------------------------------------------------------------------------------
       // Functions
       
       // Laden der Wörterbücher
       
       func loadWoerterbuch(){ // Lädt Wörterbuch mit allen Vokabeln
           let meinWoerterbuch = UserDefaults.standard.object(forKey: "gespWoerterbuchEsp")
           if let gespWoerterbuch = meinWoerterbuch as? NSDictionary{
               woerterBuchEsp = gespWoerterbuch as! [String : String]
           }
       }
       
       func loadWoerterbuchWiederholen(){ //Lädt Wörterbuch mit nicht gewussten Vokabeln
           let meinWoerterbuch2 = UserDefaults.standard.object(forKey: "gespWoerterbuchWiedEsp")
           if let gespWoerterbuch = meinWoerterbuch2 as? NSDictionary{
               woerterbuchWiederholenEsp = gespWoerterbuch as! [String : String]
           }
       }
       
       func loadWoerterbuchFirstStack(){ //Lädt Wörterbuch mit erstem Stapel
           let meinWoerterbuch3 = UserDefaults.standard.object(forKey: "gespWoerterbuchFirstStackEsp")
           if let gespWoerterbuch = meinWoerterbuch3 as? NSDictionary{
               firstOfFourStacksEsp = gespWoerterbuch as! [String : String]
           }
       }
       
       func loadWoerterbuchSecondStack(){ //Lädt Wörterbuch mit zweitem Stapel
           let meinWoerterbuch4 = UserDefaults.standard.object(forKey: "gespWoerterbuchSecondStackEsp")
           if let gespWoerterbuch = meinWoerterbuch4 as? NSDictionary{
               secondOfFourStacksEsp = gespWoerterbuch as! [String : String]
           }
       }
       
       func loadWoerterbuchThirdStack(){ //Lädt Wörterbuch mit dritten Stapel
           let meinWoerterbuch5 = UserDefaults.standard.object(forKey: "gespWoerterbuchThirdStackEsp")
           if let gespWoerterbuch = meinWoerterbuch5 as? NSDictionary{
               thirdOfFourStacksEsp = gespWoerterbuch as! [String : String]
           }
       }
       
       func loadWoerterbuchFourStack(){ //Lädt Wörterbuch mit viertem Stapel
           let meinWoerterbuch6 = UserDefaults.standard.object(forKey: "gespWoerterbuchFourStackEsp")
           if let gespWoerterbuch = meinWoerterbuch6 as? NSDictionary{
               fourOfFourStacksEsp = gespWoerterbuch as! [String : String]
           }
       }
       
       
       
       /*
       
       func loadSettingsTips(){
           // settTips
           let mySettingsTipps = UserDefaults.standard.object(forKey: "settTipsEsp")
           if let gespSettingsTipps = mySettingsTipps as? NSString{
               tippsEin = gespSettingsTipps as (String)
           }
       }
       */
    /*
       func loadSettingsTheme(){
           // settTheme
           let mySettingsTheme = UserDefaults.standard.object(forKey: "settTheme")
           if let gespSettingsTheme = mySettingsTheme as? NSString{
               theme = gespSettingsTheme as (String)
           }
       }
 */
       
       func showNumberOfVoc(){
           numberOfVocEsp = woerterBuchEsp.count
           lblVocableNumber.text = "\(numberOfVocEsp) Vokabeln vorhanden"
       }
       

        // Dictionary in Array
       func dictInArray(){
           keysEsp.removeAll() // Erst wird das Array gelöscht,
           for key in woerterBuchEsp.keys{ // dann neu befüllt
               keysEsp.append(key)
           }
           valuesEsp.removeAll()
           for value in woerterBuchEsp.values{
               valuesEsp.append(value)
           }
               woerterBuchArrayEsp.removeAll()
           for (key,value) in woerterBuchEsp{
                   woerterBuchArrayEsp.append(("\(key) - \(value)"))
               }
           }


        // ---------------------------------------------------------------------------------------
           
           // Eine Message Box erstellen
           func CreateAlert(title: String, message:String){
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                   alert.dismiss(animated: true, completion: nil)
               }))
               self.present(alert,animated: true, completion: nil)
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
