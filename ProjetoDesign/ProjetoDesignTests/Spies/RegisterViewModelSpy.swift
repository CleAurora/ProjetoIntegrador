//
//  RegisterViewModelSpy.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 02/02/21.
//

@testable import ProjetoDesign

final class RegisterViewModelSpy: RegisterViewModelProtocol {
    var invokedClick = false
    var invokedClickCount = 0

    func click() {
        invokedClick = true
        invokedClickCount += 1
    }

    var invokedTextFieldAppearance = false
    var invokedTextFieldAppearanceCount = 0

    func textFieldAppearance() {
        invokedTextFieldAppearance = true
        invokedTextFieldAppearanceCount += 1
    }

    var invokedRegisterNewUser = false
    var invokedRegisterNewUserCount = 0
    var stubbedRegisterNewUserCompletionHandlerResult: ((result: Bool, error: Error?), Void)?

    func registerNewUser(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        invokedRegisterNewUser = true
        invokedRegisterNewUserCount += 1

        if let result = stubbedRegisterNewUserCompletionHandlerResult {
            let (result, error) = result.0

            completionHandler(result, error)
        }
    }
}
