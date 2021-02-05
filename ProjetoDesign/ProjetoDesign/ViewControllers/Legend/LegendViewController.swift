//
//  LegendViewController.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 21/10/20.
//

import PKHUD
import UIKit

final class LegendViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var legendTextField: UITextField!
    @IBOutlet weak var postButton: RoundedButton!
    @IBOutlet weak var localSwitch: UISwitch!
    @IBOutlet weak var weatherSwitch: UISwitch!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!

    // MARK: - Lazy variables

    lazy var viewModel: LegendViewModelProtocol = LegendViewModel(for: self)

    // MARK: - Variables

    var imagemProfile: UIImage?

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        imageSelected.image = imagemProfile

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deactivateTab"), object: .none)
        tabBarController?.tabBar.isHidden = true

        imageSelected.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )

        postButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Override functions

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Private functions

    private func infoText() {
        viewModel.post(
            NewPostViewModel(
                hasPlace: localSwitch.isOn,
                hasTemperature: weatherSwitch.isOn,
                image: imagemProfile,
                comment: legendTextField.text
            )
        )
    }

    private func updateWeatherUI() {
        if let weather = viewModel.currentWeather {
            localLabel.text = weather.cityName
            weatherLabel.text = String(format: "%.0fºC", arguments: [weather.currentTemperature])
        } else {
            localLabel.text = "Não disponível"
            weatherLabel.text = "Não disponível"
            localSwitch.isOn = false
            weatherSwitch.isOn = false
            localLabel.isHidden = false
            weatherLabel.isHidden = false
        }
    }

    private func getWeather() {
        viewModel.getCurrentTemperature { [self] result in
            do {
                try result.get()

                updateWeatherUI()
            } catch LegendViewModel.LocationError.notAuthorized {
                updateWeatherUI()
                localSwitch.isEnabled = false
                weatherSwitch.isEnabled = false
            } catch {
                updateWeatherUI()
                HUD.flash(
                    .labeledError(
                        title: "Falha ao carregar temperatura atual",
                        subtitle: error.localizedDescription
                    )
                )
            }
        }
    }

    // MARK: - IBActions

    @IBAction private func postButtonTapped() {
        infoText()
    }

    @IBAction private func localSwitchChanged(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.35) { [self] in
            localLabel.isHidden = !sender.isOn
        }

        getWeather()
    }

    @IBAction private func weatherSwitchChanged(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.35) { [self] in
            weatherLabel.isHidden = !sender.isOn
        }

        getWeather()
    }
}
