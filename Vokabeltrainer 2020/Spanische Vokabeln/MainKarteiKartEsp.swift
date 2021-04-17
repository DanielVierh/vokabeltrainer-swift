//
//  MainKarteiKartEsp.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 06.03.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//  MAIN KARTEIKARTEN SPANISCH

import UIKit

class MainKarteiKartEsp: UIViewController {

    // Var / Label
        
        var deutschesWortStack = ""
        var spanischesWortStack = ""
        
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

            for (key, value) in woerterBuchEsp{ // dann neu befüllt
                deutschesWortStack = "\(key)"
                spanischesWortStack = "\(value)"
                firstOfFourStacksEsp[deutschesWortStack] = spanischesWortStack
                UserDefaults.standard.set(firstOfFourStacksEsp, forKey: "gespWoerterbuchFirstStackEsp") // Speichern
                lblBtnBestaetigen.backgroundColor = UIColor.green
            }
        }
        
        
        
        // Dict Elemente zählen und in den Label daneben anzeigen
        func countDictsAndDisplayInStacks(){
            numberOfFirstStack = firstOfFourStacksEsp.count
            lblFrstStack.text = "Kann ich noch nicht / Neu: \(numberOfFirstStack)"
            numberOfSecondStack = secondOfFourStacksEsp.count
            lblSecStack.text = "Kann ich ein bisschen: \(numberOfSecondStack)"
            numberOfThirStack = thirdOfFourStacksEsp.count
            lblThrStack.text = "Kann ich schon: \(numberOfThirStack)"
            numberOfFourStack = fourOfFourStacksEsp.count
            lblFourStack.text = "Kann ich gut: \(numberOfFourStack)"
        }
        
        // Abfangschutz für leere Arrays
        func tuerSteherBeiLeerenDicts(){
            
        }

}
