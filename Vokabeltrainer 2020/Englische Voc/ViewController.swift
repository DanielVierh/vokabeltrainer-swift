//
//  ViewController.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 24.01.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//  STARTSEITE


import UIKit
import CoreData
 // ---------------------------------------------------------------------------------------
// Globale Variable
var woerterBuch = ["Hallo" : "hello"]
var dictString = ""
var numberOfVoc = 0
let sprachauswahl = "en"
var globalIndex = 0
var keys: [String] = [ ]
var values: [String] = [ ]
var woerterBuchArray: [String] = [ ]
var anzahlKannIchNochNicht = 0

// Karteikarten Dicts
var firstOfFourStacks = [String: String]() // Neu und kann ich noch nicht
var secondOfFourStacks = [String: String]() // Kann ich ein bisschen
var thirdOfFourStacks = [String: String]() // kann ich schon
var fourOfFourStacks = [String: String]() // kann ich gut


 // ---------------------------------------------------------------------------------------
class ViewController: UIViewController {
    
    @IBOutlet weak var lblVocableNumber: UILabel!
    @IBOutlet weak var lblAnzKannIchNochNicht: UILabel!
    @IBOutlet weak var lblProgressBar: UIActivityIndicatorView!
    
 // ---------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWoerterbuch()
        showNumberOfVoc()
        loadWoerterbuchFirstStack()
        loadWoerterbuchSecondStack()
        loadWoerterbuchThirdStack()
        loadWoerterbuchFourStack()
        dictInArray()
        loadWoerterbuchWiederholen()
        anzahlKannIchNochNicht = woerterbuchWiederholen.count
        lblAnzKannIchNochNicht.text = "\(anzahlKannIchNochNicht) kann ich noch nicht"
        themeColor()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lblProgressBar.isHidden = true
    }
     // ---------------------------------------------------------------------------------------
    // Button
    
    @IBAction func btnSettings(_ sender: UIButton) {
    }
    
    
    @IBAction func btnVerw(_ sender: UIButton) {
        lblProgressBar.isHidden = false
    }
    
    
   // ---------------------------------------------------------------------------------------
    // Functions
    
    // Laden der Wörterbücher
    
    func loadWoerterbuch(){ // Lädt Wörterbuch mit allen Vokabeln
        let meinWoerterbuch = UserDefaults.standard.object(forKey: "gespWoerterbuch")
        if let gespWoerterbuch = meinWoerterbuch as? NSDictionary{
            woerterBuch = gespWoerterbuch as! [String : String]
        }
    }
    
    func loadWoerterbuchWiederholen(){ //Lädt Wörterbuch mit nicht gewussten Vokabeln
        let meinWoerterbuch2 = UserDefaults.standard.object(forKey: "gespWoerterbuchWied")
        if let gespWoerterbuch = meinWoerterbuch2 as? NSDictionary{
            woerterbuchWiederholen = gespWoerterbuch as! [String : String]
        }
    }
    
    func loadWoerterbuchFirstStack(){ //Lädt Wörterbuch mit erstem Stapel
        let meinWoerterbuch3 = UserDefaults.standard.object(forKey: "gespWoerterbuchFirstStack")
        if let gespWoerterbuch = meinWoerterbuch3 as? NSDictionary{
            firstOfFourStacks = gespWoerterbuch as! [String : String]
        }
    }
    
    func loadWoerterbuchSecondStack(){ //Lädt Wörterbuch mit zweitem Stapel
        let meinWoerterbuch4 = UserDefaults.standard.object(forKey: "gespWoerterbuchSecondStack")
        if let gespWoerterbuch = meinWoerterbuch4 as? NSDictionary{
            secondOfFourStacks = gespWoerterbuch as! [String : String]
        }
    }
    
    func loadWoerterbuchThirdStack(){ //Lädt Wörterbuch mit dritten Stapel
        let meinWoerterbuch5 = UserDefaults.standard.object(forKey: "gespWoerterbuchThirdStack")
        if let gespWoerterbuch = meinWoerterbuch5 as? NSDictionary{
            thirdOfFourStacks = gespWoerterbuch as! [String : String]
        }
    }
    
    func loadWoerterbuchFourStack(){ //Lädt Wörterbuch mit viertem Stapel
        let meinWoerterbuch6 = UserDefaults.standard.object(forKey: "gespWoerterbuchFourStack")
        if let gespWoerterbuch = meinWoerterbuch6 as? NSDictionary{
            fourOfFourStacks = gespWoerterbuch as! [String : String]
        }
    }
    
    func showNumberOfVoc(){
        numberOfVoc = woerterBuch.count
        lblVocableNumber.text = "\(numberOfVoc) Vokabeln vorhanden"
    }
    

     // Dictionary in Array
    func dictInArray(){
        keys.removeAll() // Erst wird das Array gelöscht,
        for key in woerterBuch.keys{ // dann neu befüllt
            keys.append(key)
        }
        values.removeAll()
        for value in woerterBuch.values{
            values.append(value)
        }
            woerterBuchArray.removeAll()
        for (key,value) in woerterBuch{
                woerterBuchArray.append(("\(key) - \(value)"))
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
