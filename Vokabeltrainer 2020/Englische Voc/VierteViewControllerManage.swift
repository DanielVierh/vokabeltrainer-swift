//
//  VierteViewControllerManage.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 24.01.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//

import UIKit
import AVFoundation

class VierteViewControllerManage: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate {

     // ---------------------------------------------------------------------------------------
    // Variablen
var searchedWord = ""
var foundedWord = ""
var deutschesWort = ""
var englischesWort = ""
    
    @IBOutlet weak var textAnzeigebereich: UITextView!
    @IBOutlet weak var textSuchbegriff: UITextField!
    @IBOutlet weak var lblSearch: UIButton!
    @IBOutlet weak var lblLoeschen: UIButton!
    @IBOutlet weak var textGefundenerBegriff: UIButton!
    @IBOutlet weak var lblErrorHandler: UILabel!
    @IBOutlet weak var pickerViewEng: UIPickerView!
    @IBOutlet weak var txtChangeDe: UITextField!
    @IBOutlet weak var txtChangeEng: UITextField!
    @IBOutlet weak var changeSwitch: UISwitch!
    @IBOutlet weak var chngSpeichern: UIButton!
    @IBOutlet weak var lblTableView: UITableView!
    
    
     // ---------------------------------------------------------------------------------------
    // Button
    @IBAction func btnVokabelLoeschen(_ sender: UIButton) {
        deleteVocabel()
        hapticFeedback()
        animatedButton()
    }
    
    @IBAction func btnSuchen(_ sender: UIButton) {
        searchVokabel()
        hapticFeedback()
    }
    
    @IBAction func btnSprachausgabe(_ sender: UIButton) {
        sprachausgabe()
    }
    
    @IBAction func aenderungSpeichern(_ sender: UIButton) {
        saveChangedVoc()
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {
        if changeSwitch.isOn{
            txtChangeDe.isHidden = false
            txtChangeEng.isHidden = false
            chngSpeichern.isHidden = false
            pickerViewEng.isHidden = false
            textSuchbegriff.isHidden = true
            lblSearch.isHidden = true
            lblTableView.isHidden = true
            textGefundenerBegriff.isHidden = true
        }else{
            txtChangeDe.isHidden = true
            txtChangeEng.isHidden = true
            chngSpeichern.isHidden = true
            pickerViewEng.isHidden = true
            textSuchbegriff.isHidden = false
            lblSearch.isHidden = false
            lblTableView.isHidden = false
            lblLoeschen.isHidden = true
            //textGefundenerBegriff.isHidden = false
        }
    }
    
    // ---------------------------------------------------------------------------------------
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        lblErrorHandler.isHidden = true
        showVoc()
        textGefundenerBegriff.isHidden = true
        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // ---------------------------------------------------------------------------------------
    // Dictionary in String in Textbox
    func showVoc(){
        for (key,value) in woerterBuch{
            dictString = dictString + " / " + ("\(key) - \(value)")
            textAnzeigebereich.text = ""
            textAnzeigebereich.text = dictString
        }
    }
    
    // Suchen
    func searchVokabel(){
        searchedWord = textSuchbegriff.text!
        if woerterBuch[searchedWord] != nil{
            textGefundenerBegriff.isHidden = false
        textGefundenerBegriff.setTitle(woerterBuch[searchedWord], for: .normal)
            //lblLoeschen.isHidden = false
            lblErrorHandler.isHidden = true
        }else{
            lblErrorHandler.isHidden = false
            lblErrorHandler.text = "Error 0815: Suchbegriff existiert nicht"
            textGefundenerBegriff.isHidden = true
            //lblLoeschen.isHidden = true
        }
    }
    
    // löschen
    func deleteVocabel(){
            if txtChangeEng.text!.isEmpty || txtChangeDe.text!.isEmpty{
                lblErrorHandler.isHidden = false
                lblErrorHandler.text = "Error 0815: Beide Textfelder ausfüllen"
            }else{
                woerterBuch.removeValue(forKey: txtChangeDe.text!)
                firstOfFourStacks.removeValue(forKey: txtChangeDe.text!)
                secondOfFourStacks.removeValue(forKey: txtChangeDe.text!)
                thirdOfFourStacks.removeValue(forKey: txtChangeDe.text!)
                fourOfFourStacks.removeValue(forKey: txtChangeDe.text!)
                saveDictionary ()
                 txtChangeDe.text = ""
                 txtChangeEng.text = ""
                }
        }

    func saveDictionary (){
        UserDefaults.standard.set(woerterBuch, forKey: "gespWoerterbuch")
        UserDefaults.standard.set(secondOfFourStacks, forKey: "gespWoerterbuchSecondStack")
        UserDefaults.standard.set(firstOfFourStacks, forKey: "gespWoerterbuchFirstStack")
        UserDefaults.standard.set(thirdOfFourStacks, forKey: "gespWoerterbuchThirdStack")
        UserDefaults.standard.set(thirdOfFourStacks, forKey: "gespWoerterbuchThirdStack")
        
        
        
        
    }

    
    // ---------------------------------------------------------------------------------------
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(woerterBuchArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = woerterBuchArray[indexPath.row]
        return(cell)
    }
    
    // ---------------------------------------------------------------------------------------
    // Vokabeln ändern
    // Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtChangeEng.text = values[row]
        txtChangeDe.text = keys[row]
        lblLoeschen.isHidden = false
    }
    
    func saveChangedVoc(){
        if txtChangeEng.text!.isEmpty || txtChangeDe.text!.isEmpty{
            lblErrorHandler.isHidden = false
            lblErrorHandler.text = "Error 0815: Beide Textfelder ausfüllen"
        }else{
            lblErrorHandler.isHidden = true
            deutschesWort = txtChangeDe.text!
            englischesWort = txtChangeEng.text!
                    woerterBuch[deutschesWort] = englischesWort
                    saveDictionary()
                    deleteTextfields()
                    hapticFeedback()
            }
    }
    
    
    func deleteTextfields(){
        txtChangeDe.text = ""
        txtChangeEng.text = ""
    }
    
    // ---------------------------------------------------------------------------------------
    
    // Button Feedback & Animation
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
        let midx = lblLoeschen.center.x
        let midy = lblLoeschen.center.y
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midx-ausschlag, y: midy)
        animation.toValue = CGPoint(x: midx + ausschlag, y: midy)
        lblLoeschen.layer.add(animation, forKey: "position")
    }
    
    func sprachausgabe(){
        let aussage = AVSpeechUtterance(string: "\(String(describing: woerterBuch[searchedWord]!))")
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
    


}
