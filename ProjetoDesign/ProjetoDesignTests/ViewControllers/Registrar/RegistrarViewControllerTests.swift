//
//  RegistrarViewControllerTests.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 02/02/21.
//

@testable import ProjetoDesign
import Nimble
import Nimble_Snapshots
import XCTest
import KIF

final class RegistrarViewControllerTests: XCTestCase {
    private lazy var storyboard = UIStoryboard(name: "Registrar", bundle: nil)

    func testInitialStateShouldMatchSnapshot() throws {
        let sut = try getSut()

        expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
    }

    func testInitialStateShouldOnlyCallViewModelTextFieldAppearanceFunction() throws {
        let viewController = try XCTUnwrap(storyboard.instantiateInitialViewController())
        let sut = try XCTUnwrap(viewController as? RegistrarViewController)
        let registerViewModelSpy = RegisterViewModelSpy()
        sut.viewModel = registerViewModelSpy

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        XCTAssertTrue(registerViewModelSpy.invokedTextFieldAppearance)
        XCTAssertEqual(registerViewModelSpy.invokedTextFieldAppearanceCount, 1)

        XCTAssertFalse(registerViewModelSpy.invokedClick)
        XCTAssertFalse(registerViewModelSpy.invokedRegisterNewUser)
    }

    func testImageButtonTapped() throws {
        let sut = try getSut()
        let registerViewModelSpy = RegisterViewModelSpy()
        sut.viewModel = registerViewModelSpy

        let imageButton: UIButton = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "image_button"))
        imageButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(registerViewModelSpy.invokedClick)
        XCTAssertEqual(registerViewModelSpy.invokedClickCount, 1)
    }

    func testRegisterButtonTapped() throws {
        let sut = try getSut()
        let registerViewModelSpy = RegisterViewModelSpy()
        sut.viewModel = registerViewModelSpy

        let imageButton: UIButton = try XCTUnwrap(sut.view.findBy(acessibilityIdentifier: "signup_button"))
        imageButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(registerViewModelSpy.invokedRegisterNewUser)
        XCTAssertEqual(registerViewModelSpy.invokedRegisterNewUserCount, 1)
    }

    func testSelectedTextFieldShouldMatchSnapshot() throws {
        let registerViewModelSpy = RegisterViewModelSpy()
        registerViewModelSpy.stubbedRegisterNewUserCompletionHandlerResult = ((true, nil), ())

        let sut = try getSut()
        sut.viewModel = registerViewModelSpy

        tester().set(rootViewController: sut)
        tester().tapView(withAccessibilityIdentifier: "name_textfield")

        let nameTextfield = try XCTUnwrap(tester().waitForView(withAccessibilityIdentifier: "name_textfield"))

        expect(nameTextfield).to(haveValidDeviceAgnosticSnapshot())

        tester().resetRootViewController()
    }

    func testRegisterButtonShouldRedirect() throws {
        let registerViewModelSpy = RegisterViewModelSpy()
        registerViewModelSpy.stubbedRegisterNewUserCompletionHandlerResult = ((true, nil), ())

        let sut = try getSut()
        sut.viewModel = registerViewModelSpy

        let givenPassword = Int.random(in: 1...9)
        let randomPassword = String(repeating: "\(givenPassword)", count: Int.random(in: 8...20))

        tester().set(rootViewController: sut)
        tester().enterText("Cleís Aurora Silveira Pereira", intoViewWithAccessibilityIdentifier: "name_textfield")
        tester().enterText("cleis_aurora@yahoo.com.br", intoViewWithAccessibilityIdentifier: "email_textfield")
        tester().enterText("@Cleis", intoViewWithAccessibilityIdentifier: "nickname_textfield")
        tester().enterText(randomPassword, intoViewWithAccessibilityIdentifier: "password_textfield")
        tester().enterText(randomPassword, intoViewWithAccessibilityIdentifier: "secure_textfield")

        tester().tapView(withAccessibilityIdentifier: "signup_button")

        tester().waitForAnimationsToFinish()

        tester().waitForView(withAccessibilityIdentifier: "feed_root_view")

        tester().resetRootViewController()
    }

    // MARK: - Private functions

    private func getSut() throws -> RegistrarViewController {
        let viewController = try XCTUnwrap(storyboard.instantiateInitialViewController())
        let sut = try XCTUnwrap(viewController as? RegistrarViewController)

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        return sut
    }
}
