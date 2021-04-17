//
//  fuenfteViewControllerVocTest.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 28.01.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
// ---  VOKABELTEST

import UIKit
// Globale Variablen
var woerterbuchWiederholen = ["Hallo":"hello"] // Dict für falsche Vokabel die wiederholt werden müssen

class fuenfteViewControllerVocTest: UIViewController {

    var punkte = 0 // Punkte Variable
    var wrongVoc : [String] = [] // Nicht gewusste Voc
    var rightVoc : [String] = [] // Gewusste Voc
    var randNumb : [Int] = [] // Array mit Zufallszahlen abhängig von Wörterbuch größe
    var counter = 0 // Speichert die Anzahl an erzeugten Zufalllszahlen
    var runner = 0  // stellt den Rundendurchlauf da bis max Counter erreicht wird
    var rightAnswer = ""
    var actualVoc = 0
    var dataForArray = ""
    
    
    @IBOutlet weak var txtEnglischeUebersetzung: UITextField!
    @IBOutlet weak var lblPunkte: UILabel!
    @IBOutlet weak var lblKeyWord: UILabel!
    @IBOutlet weak var lblCheck: UIButton!
    @IBOutlet weak var lblStartWeiter: UIButton!
    @IBOutlet weak var lblAnzeige: UILabel!
    @IBOutlet weak var lblEnde: UIButton!
    @IBOutlet weak var lblZurueck: UIButton!
    @IBOutlet weak var lblNext: UIButton!
    @IBOutlet weak var errorHandler: UILabel!
    @IBOutlet weak var lblRight: UILabel!
    @IBOutlet weak var lblWrong: UILabel!
    @IBOutlet weak var boxKannIch: UITextView!
    @IBOutlet weak var boxKannIchNicht: UITextView!
    @IBOutlet weak var lblSkip: UIButton!
    
    func roundedShapes() {
        let shaps = [lblSkip,lblCheck,lblEnde,boxKannIch,boxKannIchNicht]
        for shap in shaps {shap?.layer.cornerRadius = 12}
    }
    
    // Button
    @IBAction func btnStart(_ sender: UIButton) {
        if tippsEin == "true" {
            CreateAlert(title: "Tipp: Vokabeltest", message: "Wilkommen beim Vokabeltest. Hier kannst du dein Wissen testen. Schreibe einfach die Übersetzung des angegebenen Wortes in die Textbox und klicke auf den Haken, die Richtigkeit zu überprüfen. Wenn du das Wort falsch geschrieben hast oder nicht wusstest, und das X gedrückt hast, wird die Vokabel zum Trainer hinzugefügt. Viel Spaß :)")
        }else{
            
        }
        
        buttonSichtbar()
        createRandomNumbers()
        firstRound()
        buttonDruckFeedback()
    }
    
    @IBAction func btnCheck(_ sender: UIButton) {
        hapticFeedback()
        checkingTheAnswer()
    }
    
    @IBAction func btnEnde(_ sender: UIButton) {
        buttonDruckFeedback()
        errorHandler.isHidden = false
        errorHandler.backgroundColor = .link
        errorHandler.text = "Test beendet :)"
        lblAnzeige.isHidden = true
        txtEnglischeUebersetzung.isHidden = true
        lblNext.isHidden = true
        lblKeyWord.isHidden = true
        lblCheck.isHidden = true
        lblEnde.isHidden = true
        lblSkip.isHidden = true
        lblZurueck.isHidden = false
        boxKannIch.isHidden = false
        boxKannIchNicht.isHidden = false
        let joinedR = rightVoc.joined(separator: ", ")
        let joinedW = wrongVoc.joined(separator: ", ")
        boxKannIch.text = joinedR
        boxKannIchNicht.text = joinedW
        
    }
    
    @IBAction func btnNex(_ sender: UIButton) {
        buttonDruckFeedback()
        nextRound()
        lblNext.isHidden = true
    }
    
    @IBAction func btnSkip(_ sender: UIButton) {
        hapticFeedback()
        skip()
    }
    
    
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        themeColor()
        roundedShapes()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Funktionen
    func buttonSichtbar(){ // Button am Anfang einblenen
        lblAnzeige.isHidden = false
        txtEnglischeUebersetzung.isHidden = false
        lblCheck.isHidden = false
        lblZurueck.isHidden = true
        lblEnde.isHidden = false
        lblStartWeiter.isHidden = true
        lblNext.isHidden = true
        lblPunkte.isHidden = false
        lblKeyWord.isHidden = false
    }

    
    func createRandomNumbers(){ // Array mit Zufallszahlen erstellen
        for _ in 1...10{
           let randomIndex = Int(arc4random_uniform(UInt32(keys.count)))
            if randNumb.contains(randomIndex){
                
            }else{
                randNumb.append(randomIndex)}
        }
        counter = randNumb.count }
    
    func nextRound(){ // kreiert die nächste Runde
        lblRight.isHidden = true
        lblWrong.isHidden = true
        lblCheck.isHidden = false
        lblSkip.isHidden = false
        txtEnglischeUebersetzung.isHidden = false
        runner += 1
        if runner < counter{
            actualVoc = randNumb[runner]
                   lblKeyWord.text = keys[actualVoc]
                   rightAnswer = values[actualVoc]
            
        }else{
            errorHandler.isHidden = false
            errorHandler.text = "Test beendet :)"
            lblAnzeige.isHidden = true
            txtEnglischeUebersetzung.isHidden = true
            lblNext.isHidden = true
            lblKeyWord.isHidden = true
            lblCheck.isHidden = true
            lblEnde.isHidden = true
            lblSkip.isHidden = true
            lblZurueck.isHidden = false
            boxKannIch.isHidden = false
            boxKannIchNicht.isHidden = false
            let joinedR = rightVoc.joined(separator: ", ")
            let joinedW = wrongVoc.joined(separator: ", ")
            boxKannIch.text = joinedR
            boxKannIchNicht.text = joinedW
            //print(woerterbuchWiederholen)
        }
    }
    
    func firstRound(){ // kreiert die erste Runde
        lblSkip.isHidden = false
        actualVoc = randNumb[runner]
        lblKeyWord.text = keys[actualVoc]
        rightAnswer = values[actualVoc]
        txtEnglischeUebersetzung.becomeFirstResponder()
    }
    
    func checkingTheAnswer(){ // Nach Eingabe Button klick Ant checken
        // Textfeld ausgefüllt?
        animatedButtonCheck()
        if txtEnglischeUebersetzung.text!.isEmpty{
            errorHandler.isHidden = false
            errorHandler.text = "Error: Bitte die Übersetzung eingeben"
        }else{
            
            errorHandler.isHidden = true // Richtig
            if txtEnglischeUebersetzung.text == rightAnswer{
                punkte += 1
                lblPunkte.text = ("\(punkte) / \(counter) Richtig")
                lblCheck.isHidden = true
                lblSkip.isHidden = true
                lblNext.isHidden = false
                rightVoc.append(rightAnswer)
                txtEnglischeUebersetzung.text = ""
                txtEnglischeUebersetzung.isHidden = true
                lblRight.isHidden = false
            }else{ // Falsch
                fillInFalseWoerterbuch()
                lblCheck.isHidden = true
                lblSkip.isHidden = true
                lblNext.isHidden = false
                dataForArray = ("\(txtEnglischeUebersetzung.text!) / \(rightAnswer) = \(lblKeyWord.text!)  |  ")
                wrongVoc.append(dataForArray)
                lblWrong.isHidden = false
                txtEnglischeUebersetzung.text = ""
                txtEnglischeUebersetzung.isHidden = true
            }
        }
        
    }
    
    func skip(){
        txtEnglischeUebersetzung.text = "Nicht Gewusst"
        checkingTheAnswer()
        animatedButtonSkip()
    }
    
    
    // Füllt das Dict mit den nicht gewussten Wörtern
    func fillInFalseWoerterbuch(){
        if woerterbuchWiederholen[lblKeyWord.text!] != nil {
            
        }else{
            woerterbuchWiederholen[lblKeyWord.text!] = rightAnswer  // Zuweisung
            UserDefaults.standard.set(woerterbuchWiederholen, forKey: "gespWoerterbuchWied") // Speichern
        }
    }
    
    // Eine Message Box erstellen
    func CreateAlert(title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
    }
    
    // Animationen
    func animatedButtonCheck(){
        let ausschlag: CGFloat = 30.0
        let midx = lblCheck.center.x
        let midy = lblCheck.center.y
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midx-ausschlag, y: midy)
        animation.toValue = CGPoint(x: midx + ausschlag, y: midy)
        lblCheck.layer.add(animation, forKey: "position")
    }
    
    func animatedButtonSkip(){
        let ausschlag: CGFloat = 30.0
        let midx = lblSkip.center.x
        let midy = lblSkip.center.y
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midx-ausschlag, y: midy)
        animation.toValue = CGPoint(x: midx + ausschlag, y: midy)
        lblSkip.layer.add(animation, forKey: "position")
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


