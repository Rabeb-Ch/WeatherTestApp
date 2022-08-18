//
//  TownListViewController.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import UIKit

class TownListViewController: UIViewController {

    @IBOutlet weak var townListTableView : UITableView!
    
    var townList = DataBaseHelper.sharedInstance.fetchTowns()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        townListTableView.register(UINib(nibName: K.Identifiers.townTableViewCell, bundle: nil), forCellReuseIdentifier: K.Identifiers.townTableViewCell)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func refreshData(){
        self.townList = DataBaseHelper.sharedInstance.fetchTowns()
        DispatchQueue.main.async {
            self.townListTableView.reloadData()
        }
    }
    
    @objc func deleteTown(_ sender: UIButton){
        let town = townList[sender.tag]
        DataBaseHelper.sharedInstance.deleteTown(town: town)
        self.refreshData()
    }
}

extension TownListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return townList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.townTableViewCell) as! TownTableViewCell
        cell.townVM = TownTableViewCellVM(townList[indexPath.row].name,withDelete: true)
        cell.configure()
        cell.deleteBtn.addTarget(self, action: #selector(deleteTown), for: .touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: K.Segue.weatherViewController, sender: townList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == K.Segue.weatherViewController){
            let  destinationVC = segue.destination as! WeatherViewController
            let town = sender as? Town
            destinationVC.currentWeather = town?.current
        }
    }
}
