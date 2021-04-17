//
//  Stack3Esp.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 06.03.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//  STACK 3 SPANISCH

import UIKit
import AVFoundation

class Stack3Esp: UIViewController {

    // Variablen
    
    var keysStack: [String] = [ ]
    var valStack: [String] = [ ]
    var woerterBuchWiederhArray: [String] = [ ]
    var woerterImWierterbuch = 0
    var schonGehabt: [String] = []
    var spanischesWortStack = ""
    
    
    // Labels
    @IBOutlet weak var lblBtnStart: UIButton!
    @IBOutlet weak var lblBtnAufdecken: UIButton!
    @IBOutlet weak var vocDeutsch: UILabel!
    @IBOutlet weak var vocEnglisch: UIButton!
    @IBOutlet weak var lblBalken: UILabel!
    @IBOutlet weak var lblBtnGewusst: UIButton!
    @IBOutlet weak var lblBtnNichtgewusst: UIButton!
    @IBOutlet weak var lblAnzKannIchNochNicht: UILabel!
    
    
    // Buttons
    @IBAction func btnStart(_ sender: UIButton) {
        buttonDruckFeedback()
        errorHandlerBeileerenArray()
    }
    
    @IBAction func btnAufdecken(_ sender: UIButton) {
        buttonDruckFeedback()
        vocEnglisch.isHidden = false
        lblBtnAufdecken.isHidden = true
        lblBtnNichtgewusst.isHidden = false
        lblBtnGewusst.isHidden = false
    }
    
    @IBAction func btnSprachausgabe(_ sender: UIButton) {
        buttonDruckFeedback()
        sprachausgabe()
    }
    
    @IBAction func btnGewusst(_ sender: UIButton) {
        hapticFeedback()
        gewusst()
    }

    
    @IBAction func btnNichtgewusst(_ sender: UIButton) {
        animatedButtonNichtGewusst()
        hapticFeedback()
        nichtGewusst()
       // startTest()
      //  lblBtnAufdecken.isHidden = false
      //  lblBtnNichtgewusst.isHidden = true
     //   lblBtnGewusst.isHidden = true
    }
    
    
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        dictInArray()
        lblBtnGewusst.isHidden = true
        lblBtnNichtgewusst.isHidden = true
        showWelcome()
        anzahlKannIchNochNicht = thirdOfFourStacksEsp.count
        lblAnzKannIchNochNicht.text = "\(anzahlKannIchNochNicht) kann ich schon"
    }
    
    
    // Funktionen
    
    
    // Dictionary in Array
    func dictInArray(){
        keysStack.removeAll()
        for key in thirdOfFourStacksEsp.keys{
            keysStack.append(key)
        }
        valStack.removeAll()
        for value in thirdOfFourStacksEsp.values{
            valStack.append(value)
        }
    }
    
    // Nächste Runde
    func startTest(){
        vocEnglisch.isHidden = true
        let randomIndex = Int(arc4random_uniform(UInt32(keysStack.count)))
        globalIndex = randomIndex
        if schonGehabt.contains(keysStack[randomIndex]) {
            vocEnglisch.isHidden = true
            let randomIndex = Int(arc4random_uniform(UInt32(keysStack.count)))
            globalIndex = randomIndex
        }else{
        vocDeutsch.text = keysStack[randomIndex]
        vocEnglisch.setTitle(valStack[randomIndex], for: .normal)
        vocEnglisch.titleLabel?.adjustsFontSizeToFitWidth = true
        spanischesWortStack = valStack[randomIndex]
        }
    }

    
    // Abfänger bei leerem Array
    func errorHandlerBeileerenArray(){
        woerterImWierterbuch = keysStack.count
        if woerterImWierterbuch == 0{
            CreateAlert(title: "Keine Vokabeln vorhanden", message: "In diesem Stapel befinden sich keine Vokabeln.")
        }else{
            fistRound()
        }
    }

    // Aller Erste Runde
    func fistRound(){
        showWelcome()
        vocEnglisch.isHidden = true
        let randomIndex = Int(arc4random_uniform(UInt32(keysStack.count)))
        globalIndex = randomIndex
        if schonGehabt.contains(keysStack[randomIndex]) {
            vocEnglisch.isHidden = true
            let randomIndex = Int(arc4random_uniform(UInt32(keysStack.count)))
            globalIndex = randomIndex
        }else{
            vocDeutsch.text = keysStack[randomIndex]
            vocEnglisch.setTitle(valStack[randomIndex], for: .normal)
            vocEnglisch.titleLabel?.adjustsFontSizeToFitWidth = true
            spanischesWortStack = valStack[randomIndex]
            lblBtnStart.isHidden = true
            lblBalken.isHidden = false
            lblBtnAufdecken.isHidden = false
            lblBtnNichtgewusst.isHidden = true
            lblBtnGewusst.isHidden = true
        }
    }
    
    //  Gewusst Funktion
    func gewusst(){
        passTo4Stack()
        deleteVocabel()
        if tippsEin == "true" {
            CreateAlert(title: "Gewusst", message: "Sehr gut. Diese Vokabel geht nun in den dritten Stapel (Gelb).")
        }
    }
    
    //   nicht Gewusst Funktion
    func nichtGewusst(){
        passTo2Stack()
        deleteVocabel()
        if tippsEin == "true" {
            CreateAlert(title: "Nicht gewusst", message: "Diese Vokabel geht nun in den ersten Stapel (Rot) zurück.")
        }
    }
    
    
    // löschen
    func deleteVocabel(){
                schonGehabt.append(keysStack[globalIndex])
        
                thirdOfFourStacksEsp.removeValue(forKey: vocDeutsch.text!)
                UserDefaults.standard.set(thirdOfFourStacksEsp, forKey: "gespWoerterbuchThirdStackEsp") // Speichern
                startTest()
                lblBtnAufdecken.isHidden = false
                lblBtnNichtgewusst.isHidden = true
                lblBtnGewusst.isHidden = true
                anzahlKannIchNochNicht = thirdOfFourStacksEsp.count
                lblAnzKannIchNochNicht.text = "\(anzahlKannIchNochNicht) kann ich schon"
        
                }
    
    
    // --> An Stack 4 übergeben
    func passTo4Stack(){
        fourOfFourStacksEsp[vocDeutsch.text!] = spanischesWortStack
        UserDefaults.standard.set(fourOfFourStacksEsp, forKey: "gespWoerterbuchFourStackEsp") // Speichern
    }
        
    // --> An Stack 2 übergeben
    func passTo2Stack(){
        secondOfFourStacksEsp[vocDeutsch.text!] = spanischesWortStack
        UserDefaults.standard.set(secondOfFourStacksEsp, forKey: "gespWoerterbuchSecondStackEsp") // Speichern
    }
    
    
    func showWelcome(){
        if tippsEin == "true"{
            CreateAlert(title: "Stapel 2", message: ("Hier werden die Wörter, die du weißt, in den grünen Stapel abgelegt und die, die du nicht kannst, gelangen wieder in den Stapel (Orange). Viel Spass"))
        }else{
            
        }

    }
    
    // Sprachausgabe
    func sprachausgabe(){
            let aussage = AVSpeechUtterance(string: "\(valStack[globalIndex])")
            aussage.voice = AVSpeechSynthesisVoice(language: "\(sprachauswahlEsp)")
            let synth = AVSpeechSynthesizer()
            synth.speak(aussage)
        
        }
    
    
    
    // Eine Message Box erstellen
    func CreateAlert(title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
    }
    
    // Animation
    
    func animatedButtonGewusst(){

    }
    
    func animatedButtonNichtGewusst(){
        let ausschlag: CGFloat = 30.0
        let midx = lblBtnNichtgewusst.center.x
        let midy = lblBtnNichtgewusst.center.y
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midx-ausschlag, y: midy)
        animation.toValue = CGPoint(x: midx + ausschlag, y: midy)
        lblBtnNichtgewusst.layer.add(animation, forKey: "position")
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
    
    // Theme
    func themeColor(){
        if theme == "dark"{
            self.view.backgroundColor = UIColor.init(named: "DarkThemeBack")
        }else{
            self.view.backgroundColor = UIColor.link
        }
    }


}
