//
//  LegendViewController.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 21/10/20.
//

import UIKit
import CoreLocation

class LegendViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - IBOutlets
    var imagemProfile: UIImage?
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var legendTextField: UITextField!
    @IBOutlet weak var postButton: RoundedButton!
    @IBOutlet weak var localSwitch: UISwitch!
    @IBOutlet weak var weatherSwitch: UISwitch!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!

    //Constants
    let locationManager = CLLocationManager()
       
    //Variables
    var currentWeather: CurrentWeather = CurrentWeather()
    var currentLocation: CLLocation!
    
    // MARK: - Proprierts
    var upload: Upload?
    var postagem = [PostUser]()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callDelegate()
        self.setupLocation()
        
        if imagemProfile != nil {
            imageSelected.image = imagemProfile
        }
//        if let upload = upload {
//            imageSelected.image = UIImage(named: upload.image)
//        }

        imageSelected.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
        postButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)

    }
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        locationAutoCheck()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func callDelegate(){
        locationManager.delegate = self
    }
    
    func setupLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // take permission from user.
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationAutoCheck() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //get the location from device
            currentLocation = locationManager.location
            //pass the location coord to our API
            Locations.sharedInstance.latitude = currentLocation.coordinate.latitude
            Locations.sharedInstance.longitude = currentLocation.coordinate.longitude
            // download API data
            currentWeather.downloadCurrentWeather {
                self.setupUI()
            // update the UI after download is completed
            }
            
        } else{ // user did not allow
            locationManager.requestWhenInUseAuthorization() //take permission from the user
            locationAutoCheck()
            
        }
    }
    func setupUI(){
        //setup labels using MVVM Archictecture
        localLabel.text = currentWeather.cityName
        weatherLabel.text = String(format: "%.0fºC", arguments: [currentWeather.currentTemp])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Methods
    func infoText(){
        if let image = upload?.image {
            if let tabBarController = tabBarController, let viewControllers = tabBarController.viewControllers,
               let navController = viewControllers.first as? UINavigationController,
               let feedViewController = navController.viewControllers.first as? FeedViewController {
                tabBarController.selectedIndex = 0
                feedViewController.postagem.insert(
                    PostUser(
                        name: "Melissa",
                        city: localSwitch.isOn ? currentWeather.cityName : nil,
                        temperature: weatherSwitch.isOn ? currentWeather.currentTemp : nil,
                        imageProfile: "mel0.jpg",
                        imagePost: image,
                        comments: legendTextField.text ?? "",
                        allImages: ["",""]
                    )
                    , at: 0
                )
                feedViewController.feedTableView.reloadData()
            }

            if let tabBarController = tabBarController, let profileViewController = tabBarController.viewControllers?.last as? ProfileViewController {
                profileViewController.imagensArray.append(ImagensProfile(imagens: image, weatherImage: currentWeather.weatherType.lowercased()))
                profileViewController.profileCollectionView?.reloadData()
            }

            navigationController?.popViewController(animated: true)
        }
    }

    // MARK: - IBActions 
    @IBAction func postButtonTapped() {
       // navigationController?.popViewController(animated: true)
        infoText()
    }

    @IBAction func localSwitchChanged(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.6) {
            self.localLabel.isHidden = !sender.isOn
        }
    }

    @IBAction func weatherSwitchChanged(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.6) {
            self.weatherLabel.isHidden = !sender.isOn
        }
    }
}
