//
//  AchteViewControllerSearch.swift
//  Vokabeltrainer 2020
//
//  Created by Daniel Vierheilig on 20.02.20.
//  Copyright © 2020 Daniel Vierheilig. All rights reserved.
//

import UIKit

class AchteViewControllerSearch: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // Var and Label
    
    var searchedVok = [String()]
    var searching = false
    var testArray = ["Käse","Milch","Eier","Speck","Öl","Avocado"]
    
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    // Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
          return searchedVok.count
        }else{
            return(testArray.count)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = UITableViewCell(style: .default, reuseIdentifier: "cell2")
        if searching == true {
            cell2.textLabel?.text = searchedVok[indexPath.row]
        }else{
            cell2.textLabel?.text = testArray[indexPath.row]
            print("Error")
        }
        return cell2
    }
}

extension AchteViewControllerSearch: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedVok = testArray.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tblView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tblView.reloadData()
        print("Cancel")
    }
}
