//
//  HourlyTableViewCell.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import UIKit

class HourlyTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    var hourlyWeather : [HourlyWeather] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCollectionView(){
        hourlyCollectionView.register(UINib(nibName: K.Identifiers.hourlyCollectionCellIdentifier, bundle: nil), forCellWithReuseIdentifier: K.Identifiers.hourlyCollectionCellIdentifier)
        hourlyCollectionView.delegate = self
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.backgroundColor = .clear
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = 70.0
        let height : CGFloat = 120
        return CGSize(width: widht, height: height )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Identifiers.hourlyCollectionCellIdentifier, for: indexPath) as! HourlyCollectionViewCell
        cell.configure(hourlyWeather[indexPath.row])
        return cell
    }
    
}
