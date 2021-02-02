//
//  SignInViewControllerTests.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 01/02/21.
//

@testable import ProjetoDesign
import KIF
import Nimble
import Nimble_Snapshots
import XCTest

final class SignInViewControllerTests: XCTestCase {
    private lazy var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    // MARK: - Test functions

    func testInitialStateShouldMatchSnapshot() throws {
        let sut = try getSut()

        expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
    }

    func testInitialStateShouldNotInvokeLoginViewModel() throws {
        let loginViewModelSpy = LoginViewModelSpy()
        let sut = try getSut()
        sut.loginModel = loginViewModelSpy

        XCTAssertFalse(loginViewModelSpy.invokedDoLogin)
        XCTAssertNil(loginViewModelSpy.invokedDoLoginParameters)
    }

    func testLoginButtonTapped() throws {
        let loginViewModelSpy = LoginViewModelSpy()
        let sut = try getSut()
        sut.loginModel = loginViewModelSpy

        let loginButton: UIButton = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "login_button"))
        loginButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(loginViewModelSpy.invokedDoLogin)
        XCTAssertEqual(loginViewModelSpy.invokedDoLoginCount, 1)

        let parameters = try XCTUnwrap(loginViewModelSpy.invokedDoLoginParameters)

        XCTAssertEqual(parameters.email, "")
        XCTAssertEqual(parameters.password, "")
    }

    func testGoogleButtonTapped() throws {
        let signInViewModelSpy = SignInViewModelSpy()
        let sut = try getSut()
        sut.signInViewModel = signInViewModelSpy

        let googleButton: UIButton = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "google_button"))
        googleButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(signInViewModelSpy.invokedSignInWithGoogle)
        XCTAssertEqual(signInViewModelSpy.invokedSignInWithGoogleCount, 1)
    }

    func testFacebookButtonTapped() throws {
        let signInViewModelSpy = SignInViewModelSpy()
        let sut = try getSut()
        sut.signInViewModel = signInViewModelSpy

        let facebookButton: UIButton = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "facebook_button"))
        facebookButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(signInViewModelSpy.invokedSignInWithFacebook)
        XCTAssertEqual(signInViewModelSpy.invokedSignInWithFacebookCount, 1)

        let parameters = try XCTUnwrap(signInViewModelSpy.invokedSignInWithFacebookParameters)

        XCTAssertNotNil(parameters.viewController)
        expect(parameters.viewController).to(beAnInstanceOf(SignInViewController.self))
        expect(parameters.viewController).to(equal(sut))
    }

    // MARK: - Private functions

    private func getSut() throws -> SignInViewController {
        let viewController = try XCTUnwrap(storyboard.instantiateInitialViewController())
        let sut: SignInViewController = try XCTUnwrap(viewController as? SignInViewController)

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        return sut
    }
}
