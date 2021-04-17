//
//  sechsterViewControllerTrainer.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 09.02.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//      VOKABELTRAINING WIEDERHOLUNG

import UIKit
import AVFoundation

class sechsterViewControllerTrainer: UIViewController {

    
    // Variablen
    
    var keysWdh: [String] = [ ]
    var valWdh: [String] = [ ]
    var woerterBuchWiederhArray: [String] = [ ]
    var woerterImWierterbuch = 0
    var schonGehabt: [String] = []
    
    
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
    /*
    UIView.animate(withDuration: 3.0,
                   delay: 0.2,
                   options: options,
                   animations: { [weak self] in
                    self?.cloud2ImageView.frame.size.height *= 1.28
                    self?.cloud2ImageView.frame.size.width *= 1.28
    }, completion: nil)
    */
    
    @IBAction func btnNichtgewusst(_ sender: UIButton) {
        animatedButtonNichtGewusst()
        hapticFeedback()
        startTest()
        lblBtnAufdecken.isHidden = false
        lblBtnNichtgewusst.isHidden = true
        lblBtnGewusst.isHidden = true
    }
    
    
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        dictInArray()
        lblBtnGewusst.isHidden = true
        lblBtnNichtgewusst.isHidden = true
        showWelcome()
        anzahlKannIchNochNicht = woerterbuchWiederholen.count
        lblAnzKannIchNochNicht.text = "\(anzahlKannIchNochNicht) kann ich noch nicht"
        themeColor()
        
    }
    
    
    // Funktionen
    
    
    // Dictionary in Array
    func dictInArray(){
        for key in woerterbuchWiederholen.keys{
            keysWdh.append(key)
        }
        for value in woerterbuchWiederholen.values{
            valWdh.append(value)
        }
        for (key,value) in woerterBuch{
            woerterBuchWiederhArray.append(("\(key) - \(value)"))
        }
    }
    
    // Nächste Runde
    func startTest(){
        vocEnglisch.isHidden = true
        let randomIndex = Int(arc4random_uniform(UInt32(keysWdh.count)))
        globalIndex = randomIndex
        if schonGehabt.contains(keysWdh[randomIndex]) {
            vocEnglisch.isHidden = true
            let randomIndex = Int(arc4random_uniform(UInt32(keysWdh.count)))
            globalIndex = randomIndex
        }else{
        vocDeutsch.text = keysWdh[randomIndex]
        vocEnglisch.setTitle(valWdh[randomIndex], for: .normal)
        vocEnglisch.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }

    
    // Abfänger bei leerem Array
    func errorHandlerBeileerenArray(){
        woerterImWierterbuch = keysWdh.count
        if woerterImWierterbuch == 0{
            CreateAlert(title: "Keine Vokabeln vorhanden", message: "Sehr gut. Noch gibt es keine Vokabeln, die du nicht kannst. Mache den Vokabeltest. Wenn du dort eine Vokabel nicht weißt, landet sie hier.")
        }else{
            fistRound()
        }
    }

    
    func fistRound(){
        showWelcome()
        vocEnglisch.isHidden = true
        let randomIndex = Int(arc4random_uniform(UInt32(keysWdh.count)))
        globalIndex = randomIndex
        if schonGehabt.contains(keysWdh[randomIndex]) {
            vocEnglisch.isHidden = true
            let randomIndex = Int(arc4random_uniform(UInt32(keysWdh.count)))
            globalIndex = randomIndex
        }else{
            vocDeutsch.text = keysWdh[randomIndex]
            vocEnglisch.setTitle(valWdh[randomIndex], for: .normal)
            vocEnglisch.titleLabel?.adjustsFontSizeToFitWidth = true
            lblBtnStart.isHidden = true
            lblBalken.isHidden = false
            lblBtnAufdecken.isHidden = false
            lblBtnNichtgewusst.isHidden = true
            lblBtnGewusst.isHidden = true
        }
        
    }
    
    
    func gewusst(){
        deleteVocabel()
        CreateAlert(title: "Gewusst", message: "Sehr gut. Wieder eine Vokabel mehr, die du kannst.")
        
    }
    
    // löschen
    func deleteVocabel(){
                schonGehabt.append(keysWdh[globalIndex])
                woerterbuchWiederholen.removeValue(forKey: vocDeutsch.text!)
                UserDefaults.standard.set(woerterbuchWiederholen, forKey: "gespWoerterbuchWied") // Speichern
                startTest()
                lblBtnAufdecken.isHidden = false
                lblBtnNichtgewusst.isHidden = true
                lblBtnGewusst.isHidden = true
                anzahlKannIchNochNicht = woerterbuchWiederholen.count
                lblAnzKannIchNochNicht.text = "\(anzahlKannIchNochNicht) kann ich noch nicht"
        
                }
        
    
    func showWelcome(){
        if tippsEin == "true"{
            CreateAlert(title: "Vokabeltrainer", message: ("Hier werden nur Vokabeln angezeigt, die du noch nicht kannst. Immer wenn du eine Vokabel weißt und den Button mit dem Häckchen auswählst, wird die Vokabel aus dieser Liste herausgenommen. Viel Spass"))
        }else{
            
        }

    }
    
    // Sprachausgabe
    func sprachausgabe(){
            let aussage = AVSpeechUtterance(string: "\(valWdh[globalIndex])")
            aussage.voice = AVSpeechSynthesisVoice(language: "\(sprachauswahl)")
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
    
    func themeColor(){
        if theme == "dark"{
            self.view.backgroundColor = UIColor.init(named: "DarkThemeBack")
        }else{
            self.view.backgroundColor = UIColor.link
        }
    }

}





