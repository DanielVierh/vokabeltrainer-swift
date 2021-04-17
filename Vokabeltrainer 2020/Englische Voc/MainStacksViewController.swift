//
//  MainStacksViewController.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 21.02.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//

import UIKit

class MainStacksViewController: UIViewController {
// Var / Label
    
    var deutschesWortStack = ""
    var englischesWortStack = ""
    
    var numberOfFirstStack = 0
    var numberOfSecondStack = 0
    var numberOfThirStack = 0
    var numberOfFourStack = 0
   
    
    @IBOutlet weak var lblFrstStack: UILabel!
    @IBOutlet weak var lblSecStack: UILabel!
    @IBOutlet weak var lblThrStack: UILabel!
    @IBOutlet weak var lblFourStack: UILabel!
    @IBOutlet weak var lblBtnBestaetigen: UIButton!
    
    
    
    
    
    // Button
    
    // DEAKTIVIEREN DIESEN BUTTON
    @IBAction func btnDownloadVoc(_ sender: UIButton) {
      //  firstOfFourStacks.removeAll()
        downloadAllVoc()
        countDictsAndDisplayInStacks()
    }
    
    
    
    
    // View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        countDictsAndDisplayInStacks()
        print(firstOfFourStacks)
    }
    
    
    
// Funktionen
    
    
    // DEAKTIVE FUNKTION / DIESE FUNKTION lädt alle Daten vom Wörterbuch in den Stack 1
    func downloadAllVoc(){

        for (key, value) in woerterBuch{ // dann neu befüllt
            deutschesWortStack = "\(key)"
            englischesWortStack = "\(value)"
            firstOfFourStacks[deutschesWortStack] = englischesWortStack
            UserDefaults.standard.set(firstOfFourStacks, forKey: "gespWoerterbuchFirstStack") // Speichern
            lblBtnBestaetigen.backgroundColor = UIColor.green
        }
    }
    
    
    
    // Dict Elemente zählen und in den Label daneben anzeigen
    func countDictsAndDisplayInStacks(){
        numberOfFirstStack = firstOfFourStacks.count
        lblFrstStack.text = "Kann ich noch nicht / Neu: \(numberOfFirstStack)"
        numberOfSecondStack = secondOfFourStacks.count
        lblSecStack.text = "Kann ich ein bisschen: \(numberOfSecondStack)"
        numberOfThirStack = thirdOfFourStacks.count
        lblThrStack.text = "Kann ich schon: \(numberOfThirStack)"
        numberOfFourStack = fourOfFourStacks.count
        lblFourStack.text = "Kann ich gut: \(numberOfFourStack)"
    }
    
    // Abfangschutz für leere Arrays
    func tuerSteherBeiLeerenDicts(){
        
    }

}
