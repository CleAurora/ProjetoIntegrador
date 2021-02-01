//
//  SignInViewControllerTests.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 01/02/21.
//

@testable import ProjetoDesign
import Nimble
import Nimble_Snapshots
import XCTest

final class SignInViewControllerTests: XCTestCase {
    private lazy var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    // MARK: - Test Functions

    func testInitialStateShouldMatchSnapshot() throws {
        let viewController = try XCTUnwrap(storyboard.instantiateInitialViewController())
        let sut: SignInViewController = try XCTUnwrap(viewController as? SignInViewController)

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
    }
}
