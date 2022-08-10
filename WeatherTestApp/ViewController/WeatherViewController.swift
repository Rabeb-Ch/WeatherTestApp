//
//  WeatherViewController.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    var currentWeather : CurrentWeather?
    
    override func viewWillAppear(_ animated: Bool) {
        self.customBackBtn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCells()
    }
    
    // MARK: Register tableView cells
    func registerCells(){
        weatherTableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        weatherTableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        weatherTableView.register(UINib(nibName: "HourlyTableViewCell", bundle: nil), forCellReuseIdentifier: "HourlyTableViewCell")
    }
    
    func customBackBtn(){
        let menuItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action:  #selector(self.goBackHome(_:)))
        self.navigationItem.leftBarButtonItem =   menuItem
    }
    
    @objc func goBackHome(_ sender: UIButton!){
        let storyBoard: UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let townListVC = storyBoard.instantiateViewController(withIdentifier: "TownListViewController") as! TownListViewController
        self.navigationController?.pushViewController(townListVC,animated:true)
    }
    
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dailyWeather = currentWeather?.daily ?? []
        return section == 0 ? 1 : dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 230.0 : 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 120 : 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
            cell.headerViewCellVM = HeaderTableViewCellVM(currentWeather: self.currentWeather)
            cell.configureHeaderCell()
            return cell.contentView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell") as! HourlyTableViewCell
            let hourlyWeather = currentWeather?.hourly ?? []
            cell.hourlyWeather = hourlyWeather.array as! [HourlyWeather]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as! WeatherTableViewCell
            let dailyWeatherSet = currentWeather?.daily ?? []
            let dailyWeather = dailyWeatherSet.array as! [DailyWeather]
            cell.weatherCellVM = WeatherTableViewCellVM(dailyWeather[indexPath.row])
            cell.configureWeatherCell()
            return cell
        }
    }
}
