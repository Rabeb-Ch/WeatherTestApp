//
//  AddTownViewController.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import UIKit
import Combine

class AddTownViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var townListTableView : UITableView!
    
    private var townList : [String] = [K.Titles.currentLocation]
    private var isSelected : Bool = false
    
    private let addTownVM : AddTownViewModel? = AddTownViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        townListTableView.register(UINib(nibName: K.Identifiers.townTableViewCell, bundle: nil), forCellReuseIdentifier: K.Identifiers.townTableViewCell)
        
        addTownVM?.$isNewTownAdded
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isNewTownAdded in
                if let _isNewTownAdded = isNewTownAdded {
                    if _isNewTownAdded {
                        self?.performSegue(withIdentifier: K.Segue.weatherViewController, sender: nil)
                    }else{
                        self?.showAlertWith(msg: "Location already added")
                    }
                    
                    self?.isSelected = false
                }
            }
            .store(in: &subscriptions)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == K.Segue.weatherViewController){
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
        townList = [K.Titles.currentLocation]
        townList.append(contentsOf: addTownVM?.searchTownWith(prefix: prefix) ?? [])
        updateTableView()
    }
}

extension AddTownViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return townList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.townTableViewCell) as! TownTableViewCell
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
        if indexPath.row == 0 {
            self.addTownVM?.getCurrentLocation()
        }else{
            self.addTownVM?.addTown(townList[indexPath.row]){ [weak self] succ in
                if !succ {
                    self?.isSelected = false
                    self?.showAlertWith(msg: "Town already added")
                }
            }
        }
    }
    
    func updateTableView(){
        townListTableView.isHidden = townList.isEmpty
        townListTableView.reloadData()
    }
}
