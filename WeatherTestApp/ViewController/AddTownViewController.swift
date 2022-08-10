//
//  AddTownViewController.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import UIKit

class AddTownViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var townListTableView : UITableView!
    
    private var townList : [String] = []
    private var isSelected : Bool = false
    
    private let addTownVM : AddTownViewModel? = AddTownViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        townListTableView.register(UINib(nibName: "TownTableViewCell", bundle: nil), forCellReuseIdentifier: "TownTableViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "WeatherViewController"){
            let  destinationVC = segue.destination as! WeatherViewController
            //Get last added town to show its data
            let town = DataBaseHelper.sharedInstance.fetchTowns().last!
            destinationVC.currentWeather = town.current
        }
    }
}

// MARK: -  UISearchBarDelegate
extension AddTownViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTownWith(prefix: searchText)
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchTownWith(prefix:String){
        townList = addTownVM?.searchTownWith(prefix: prefix) ?? []
        updateTableView()
    }
}

extension AddTownViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return townList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownTableViewCell") as! TownTableViewCell
        cell.townVM = TownTableViewCellVM(townList[indexPath.row],withDelete: false)
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !isSelected else {
            return
        }
        isSelected = true
        self.addTownVM?.addTown(townList[indexPath.row]){ [weak self] succ in
            if succ {
                DispatchQueue.main.async {
                    self?.performSegue(withIdentifier: "WeatherViewController", sender: nil)
                }
            }else{
                self?.isSelected = false
            }
        }
    }
    
    func updateTableView(){
        townListTableView.isHidden = townList.isEmpty
        townListTableView.reloadData()
    }
}
