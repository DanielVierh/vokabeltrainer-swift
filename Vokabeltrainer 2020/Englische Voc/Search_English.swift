//
//  Search_English.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 27.09.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//

import UIKit

class Search_English: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

  var searchingWord = [String()]
  var searching = false
  var selectedVoc = ""
  var isDeutscheSuche = true
  var inBearbeitung = false
    
    @IBOutlet weak var lblBtnSearch: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSwitch: UISwitch!
    
    @IBOutlet weak var lblWhichSearch: UILabel!
    @IBOutlet weak var lblBtnEngl: UIButton!
    @IBOutlet weak var lbltext: UILabel!
    
    // Bearbeiten
    @IBOutlet weak var lblDeWort: UILabel!
    @IBOutlet weak var lblEngWort: UILabel!
    @IBOutlet weak var txtDeutsch: UITextField!
    @IBOutlet weak var txtEnglisch: UITextField!
    @IBOutlet weak var lblBtnSave: UIButton!
    @IBOutlet weak var lblErrorHandler: UILabel!
    @IBOutlet weak var lblBtnTrash: UIButton!
    @IBOutlet weak var lblBtnLeeren: UIButton!
    
    var deutschesWort = ""
    var englischesWort = ""
    
    // Button
    
    @IBAction func btnLeeren(_ sender: Any) {
        deleteTextfields()
    }
    
    
    @IBAction func btn_Delete(_ sender: Any) {
        deleteVocabel()
        tblView.reloadData()
    }
    
    @IBAction func btnBearbeiten(_ sender: Any) {
        toggleBearbeiten()
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        if txtEnglisch.text!.isEmpty || txtDeutsch.text!.isEmpty{
            lblErrorHandler.isHidden = false
            lblErrorHandler.text = "Error 0815: Beide Textfelder ausfüllen"
        }else{
            lblErrorHandler.isHidden = true
            deutschesWort = txtDeutsch.text!
            englischesWort = txtEnglisch.text!
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
                }
            }
    }
    
    func toggleBearbeiten(){
        if inBearbeitung == false {
            inBearbeitung = true
            lblDeWort.isHidden = false
            lblEngWort.isHidden = false
            txtDeutsch.isHidden = false
            txtEnglisch.isHidden = false
            lblBtnSave.isHidden = false
            lblBtnTrash.isHidden = false
            lblBtnLeeren.isHidden = false
            
        }else{
            inBearbeitung = false
            lblDeWort.isHidden = true
            lblEngWort.isHidden = true
            txtDeutsch.isHidden = true
            txtEnglisch.isHidden = true
            lblBtnSave.isHidden = true
            lblBtnTrash.isHidden = true
            lblBtnLeeren.isHidden = true
        }
    }
    
    func saveDictionary (){
        UserDefaults.standard.set(woerterBuch, forKey: "gespWoerterbuch") // Speichert Wort in Wörterbuch
        UserDefaults.standard.set(firstOfFourStacks, forKey: "gespWoerterbuchFirstStack") // Speichert Wort in First Stack
    }
    
    func deleteTextfields(){
        txtEnglisch.text = ""
        txtDeutsch.text = ""
        txtDeutsch.becomeFirstResponder()
        lblErrorHandler.isHidden = true
        buttonDruckFeedback()
    }
    
    // löschen
    func deleteVocabel(){
            if txtEnglisch.text!.isEmpty || txtDeutsch.text!.isEmpty{
                lblErrorHandler.isHidden = false
                lblErrorHandler.text = "Error 0815: Beide Textfelder ausfüllen"
            }else{
                CreateAlert(title: "Gelöscht", message: "Das Wort \(txtDeutsch.text!) wurde gelöscht")
                
                woerterBuch.removeValue(forKey: txtDeutsch.text!)
                firstOfFourStacks.removeValue(forKey: txtDeutsch.text!)
                secondOfFourStacks.removeValue(forKey: txtDeutsch.text!)
                thirdOfFourStacks.removeValue(forKey: txtDeutsch.text!)
                fourOfFourStacks.removeValue(forKey: txtDeutsch.text!)
                saveDictionary ()
                txtDeutsch.text = ""
                 txtEnglisch.text = ""
                }

        }
    
    // Button Suche
    @IBAction func btnSearch(_ sender: Any) {
        buttonDruckFeedback()
    }
    
    @IBAction func listenToEnglishVoc(_ sender: Any) {
        buttonDruckFeedback()
    }
    
    @IBAction func switchDEEN(_ sender: Any) {
        if lblSwitch.isOn{
            isDeutscheSuche = true
            tblView.reloadData()
            lblWhichSearch.text = "Deutsches Suchwort"
            
        }else{
            isDeutscheSuche = false
            tblView.reloadData()
            lblWhichSearch.text = "Englisches Suchwort"
        }
    }
    
    
    
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        isDeutscheSuche = true
        inBearbeitung = true
        toggleBearbeiten()

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    // Funktionen
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searching {
                return searchingWord.count
            }else{
                if isDeutscheSuche == true{
                    return keys.count
                }else{
                    return values.count
                }
               
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if searching{
                cell?.textLabel?.text = searchingWord[indexPath.row]
            }else{
                if isDeutscheSuche == true{
                    cell?.textLabel?.text = keys[indexPath.row]
                }else{
                    cell?.textLabel?.text = values[indexPath.row]
                }
                
            }
            return cell!
        }
        
        // Funktion bei ausgewählter Vokabel
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //buttonDruckFeedback()
            if searching{
                if isDeutscheSuche == true{
                    selectedVoc = searchingWord[indexPath.row]
                    let englishWord = woerterBuch[selectedVoc]
                    lbltext.text = "\(selectedVoc) - \(englishWord!)"
                    txtDeutsch.text = "\(selectedVoc)"
                    txtEnglisch.text = "\(englishWord!)"
                }else{
                    selectedVoc = searchingWord[indexPath.row]
                    if let deWort = woerterBuch.first(where: { $0.value == selectedVoc })?.key {
                        lbltext.text = "\(selectedVoc) - \(deWort)"
                        txtDeutsch.text = "\(deWort)"
                        txtEnglisch.text = "\(selectedVoc)"
                    }
                    
                }

            }else{
                if isDeutscheSuche == true{
                    selectedVoc = keys[indexPath.row]
                    let englishWord = woerterBuch[selectedVoc]
                    lbltext.text = "\(selectedVoc) - \(englishWord!)"
                    txtDeutsch.text = "\(selectedVoc)"
                    txtEnglisch.text = "\(englishWord!)"
                }else{
                    selectedVoc = values[indexPath.row]
                    if let deWort = woerterBuch.first(where: { $0.value == selectedVoc })?.key {
                        lbltext.text = "\(selectedVoc) - \(deWort)"
                        txtDeutsch.text = "\(deWort)"
                        txtEnglisch.text = "\(selectedVoc)"
                }
                

                }
        
            }
        }
        

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if isDeutscheSuche == true{
                searchingWord = keys.filter({$0.lowercased().contains(searchText.lowercased())})
                searching = true
                tblView.reloadData()
            }else{
                searchingWord = values.filter({$0.lowercased().contains(searchText.lowercased())})
                searching = true
                tblView.reloadData()
            }

        }
    
    
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searching = false
            searchBar.text = ""
            tblView.reloadData()
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
    
    
    
// Ende
}
