//
//  LegendViewControllerTests.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 04/02/21.
//

@testable import ProjetoDesign
import KIF
import Nimble
import Nimble_Snapshots
import XCTest

final class LegendViewControllerTests: XCTestCase {
    private lazy var storyboard = UIStoryboard(name: "Legend", bundle: nil)
    private lazy var navigationController = NavigationControllerSpy()

    // MARK: - Test functions

    func testInitialStateShouldMatchSnapshot() throws {
        let sut = try getSut()

        expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
    }

    func testInitialStateShouldShowNavigationBar() throws {
        _ = try getSut()
        let expectedAnimation = false

        let params = try XCTUnwrap(navigationController.invokedSetNavigationBarParameters)

        XCTAssertTrue(navigationController.invokedSetNavigationBarHidden)
        XCTAssertEqual(navigationController.invokedSetNavigationBarHiddenCount, 1)
        XCTAssertEqual(params.animated, expectedAnimation)
        XCTAssertFalse(params.hidden)
    }

    func testLocalSwitchOn() throws {
        let sut = try getSut()
        let viewModel = LegendViewModelSpy()
        sut.viewModel = viewModel
        viewModel.stubbedCurrentWeather = WeatherViewModel(
            cityName: "Cupertino", weatherType: "Clouds", currentTemperature: 4
        )
        viewModel.stubbedGetCurrentTemperatureHandlerResult = (.success(()), ())

        let localSwitch: UISwitch = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "local_switch"))
        localSwitch.sendActions(for: .valueChanged)

        expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
    }

    func testLocalSwitchOnWhenLocationIsNotAuthorized() throws {
        let sut = try getSut()
        let viewModel = LegendViewModelSpy()
        sut.viewModel = viewModel
        viewModel.stubbedCurrentWeather = nil
        viewModel.stubbedGetCurrentTemperatureHandlerResult = (.failure(LegendViewModel.LocationError.notAuthorized), ())

        let localSwitch: UISwitch = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "local_switch"))
        localSwitch.sendActions(for: .valueChanged)

        expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
    }

    func testWeatherSwitchOn() throws {
        let sut = try getSut()
        let viewModel = LegendViewModelSpy()
        sut.viewModel = viewModel
        viewModel.stubbedCurrentWeather = WeatherViewModel(
            cityName: "Cupertino", weatherType: "Clouds", currentTemperature: 4
        )
        viewModel.stubbedGetCurrentTemperatureHandlerResult = (.success(()), ())

        let localSwitch: UISwitch = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "weather_switch"))
        localSwitch.sendActions(for: .valueChanged)

        expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
    }

    func testWeatherSwitchOnWhenLocationIsNotAuthorized() throws {
        let sut = try getSut()
        let viewModel = LegendViewModelSpy()
        sut.viewModel = viewModel
        viewModel.stubbedCurrentWeather = nil
        viewModel.stubbedGetCurrentTemperatureHandlerResult = (.failure(LegendViewModel.LocationError.notAuthorized), ())

        let localSwitch: UISwitch = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "weather_switch"))
        localSwitch.sendActions(for: .valueChanged)

        expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
    }

    func testLocalSwitchAndWeatherSwitchOn() throws {
        let sut = try getSut()
        let viewModel = LegendViewModelSpy()
        sut.viewModel = viewModel
        viewModel.stubbedCurrentWeather = WeatherViewModel(
            cityName: "Cupertino", weatherType: "Clouds", currentTemperature: 4
        )
        viewModel.stubbedGetCurrentTemperatureHandlerResult = (.success(()), ())

        let localSwitch: UISwitch = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "local_switch"))
        localSwitch.sendActions(for: .valueChanged)

        let weatherSwitch: UISwitch = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "weather_switch"))
        localSwitch.sendActions(for: .valueChanged)

        expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
    }

    func testViewWillDisappearShouldHideNavigationBar() throws {
        let sut = try getSut()
        let expectedAnimation = false

        sut.viewWillDisappear(expectedAnimation)

        let params = try XCTUnwrap(navigationController.invokedSetNavigationBarParameters)

        XCTAssertTrue(navigationController.invokedSetNavigationBarHidden)
        XCTAssertEqual(navigationController.invokedSetNavigationBarHiddenCount, 2)
        XCTAssertEqual(params.animated, expectedAnimation)
        XCTAssertTrue(params.hidden)
    }

    func testInitialStateShouldNotCallViewModel() throws {
        let viewController = try XCTUnwrap(storyboard.instantiateInitialViewController())
        let sut = try XCTUnwrap(viewController as? LegendViewController)
        let viewModel = LegendViewModelSpy()
        sut.viewModel = viewModel

        navigationController.setViewControllers([sut], animated: false)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        XCTAssertFalse(viewModel.invokedPost)
        XCTAssertFalse(viewModel.invokedCurrentWeatherGetter)
        XCTAssertFalse(viewModel.invokedGetCurrentTemperature)
    }

    // MARK: - Private functions

    private func getSut() throws -> LegendViewController {
        let viewController = try XCTUnwrap(storyboard.instantiateInitialViewController())
        let sut = try XCTUnwrap(viewController as? LegendViewController)

        navigationController.setViewControllers([sut], animated: false)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        return sut
    }
}



