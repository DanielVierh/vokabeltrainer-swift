//
//  ThirtViewControllerTest.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 24.01.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//          VOKABELTEST KARTEIKARTEN
import UIKit
import AVFoundation


class ThirtViewControllerTest: UIViewController {
    
    @IBOutlet weak var vocDeutsch: UILabel!
    @IBOutlet weak var vocEnglisch: UIButton!
    @IBOutlet weak var lblnaechste: UIButton!
    @IBOutlet weak var lblAufdecken: UIButton!
    @IBOutlet weak var lblBtnStart: UIButton!
    @IBOutlet weak var lblBalken: UILabel!
    @IBOutlet weak var lblBtnTrainer: UIButton!
    
    
    // Button
    
    // Erste Runde
    @IBAction func btnStart(_ sender: UIButton) {
        buttonDruckFeedback()
        fistRound()
    }

    @IBAction func btnTrain(_ sender: UIButton) {
        buttonDruckFeedback()
    }
    
    
    @IBAction func btnTest_Starten(_ sender: UIButton) {
        //dictInArray()
        buttonDruckFeedback()
        startTest()
        lblAufdecken.isHidden = false
        lblnaechste.isHidden = true
    }
    
    @IBAction func btnAufdecken(_ sender: UIButton) {
        buttonDruckFeedback()
        vocEnglisch.isHidden = false
        lblAufdecken.isHidden = true
        lblnaechste.isHidden = false
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
    }
    
    @IBAction func btnSprachausgabe(_ sender: UIButton) {
        buttonDruckFeedback()
        sprachausgabe()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeColor()

    }
    
    func startTest(){
        vocEnglisch.isHidden = true
        let randomIndex = Int(arc4random_uniform(UInt32(keys.count)))
        globalIndex = randomIndex
        vocDeutsch.text = keys[randomIndex]
        vocEnglisch.setTitle(values[randomIndex], for: .normal)
        vocEnglisch.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    
    func sprachausgabe(){
            let aussage = AVSpeechUtterance(string: "\(values[globalIndex])")
            aussage.voice = AVSpeechSynthesisVoice(language: "\(sprachauswahl)")
            let synth = AVSpeechSynthesizer()
            synth.speak(aussage)
        
        }
    
    func fistRound(){
        // Tipps anzeigen wenn aktiviert
        if tippsEin == "true"{
                            CreateAlert(title: "Karteikartentest", message: ("Dieser Vokabeltest gibt Dir per Zufallswert Vokabeln aus. Klicke auf das Fragezeichen, um die englische Vokabel aufzudecken. Viel Spass"))
        }else{
            
        }

        
        vocEnglisch.isHidden = true
        let randomIndex = Int(arc4random_uniform(UInt32(keys.count)))
        globalIndex = randomIndex
        vocDeutsch.text = keys[randomIndex]
        vocEnglisch.setTitle(values[randomIndex], for: .normal)
        vocEnglisch.titleLabel?.adjustsFontSizeToFitWidth = true
        lblBtnStart.isHidden = true
        lblBalken.isHidden = false
        lblAufdecken.isHidden = false
        lblnaechste.isHidden = true
        lblBtnTrainer.isHidden = true
    }

    // Eine Message Box erstellen
    func CreateAlert(title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
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
    
    /*
     let array = ["Frodo", "sam", "wise", "gamgee"]
     let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
     print(array[randomIndex])
    */
    /*
      var keys: [String] = [ ]
      var values: [String] = [ ]
      */
    /*
     func dictInArray(){
         for key in woerterBuch.keys{
             keys.append(key)
         }
         for value in woerterBuch.values{
             values.append(value)
         }
             print(keys)
             print(values)
     }
     */
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
