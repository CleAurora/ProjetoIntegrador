//
//  SignInViewModelSpy.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 02/02/21.
//

@testable import ProjetoDesign
import UIKit

final class SignInViewModelSpy: SignInViewModelProtocol {
    var invokedSignInWithFacebook = false
    var invokedSignInWithFacebookCount = 0
    var invokedSignInWithFacebookParameters: (viewController: UIViewController, Void)?
    var invokedSignInWithFacebookParametersList = [(viewController: UIViewController, Void)]()

    func signInWithFacebook(on viewController: UIViewController) {
        invokedSignInWithFacebook = true
        invokedSignInWithFacebookCount += 1
        invokedSignInWithFacebookParameters = (viewController, ())
        invokedSignInWithFacebookParametersList.append((viewController, ()))
    }

    var invokedSet = false
    var invokedSetCount = 0
    var invokedSetParameters: (presentingViewController: UIViewController?, Void)?
    var invokedSetParametersList = [(presentingViewController: UIViewController?, Void)]()

    func set(presentingViewController: UIViewController?) {
        invokedSet = true
        invokedSetCount += 1
        invokedSetParameters = (presentingViewController, ())
        invokedSetParametersList.append((presentingViewController, ()))
    }

    var invokedReSignInWithGoogle = false
    var invokedReSignInWithGoogleCount = 0

    func reSignInWithGoogle() {
        invokedReSignInWithGoogle = true
        invokedReSignInWithGoogleCount += 1
    }

    var invokedSignInWithGoogle = false
    var invokedSignInWithGoogleCount = 0

    func signInWithGoogle() {
        invokedSignInWithGoogle = true
        invokedSignInWithGoogleCount += 1
    }
}

