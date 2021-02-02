//
//  LoginViewModelSpy.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 02/02/21.
//

@testable import ProjetoDesign

final class LoginViewModelSpy: LoginViewModelProtocol {
    var invokedTitleBtnLoginGetter = false
    var invokedTitleBtnLoginGetterCount = 0
    var stubbedTitleBtnLogin: String! = ""

    var titleBtnLogin: String {
        invokedTitleBtnLoginGetter = true
        invokedTitleBtnLoginGetterCount += 1
        return stubbedTitleBtnLogin
    }

    var invokedTitleBtnRegisterGetter = false
    var invokedTitleBtnRegisterGetterCount = 0
    var stubbedTitleBtnRegister: String! = ""

    var titleBtnRegister: String {
        invokedTitleBtnRegisterGetter = true
        invokedTitleBtnRegisterGetterCount += 1
        return stubbedTitleBtnRegister
    }

    var invokedImageBtnInstagramGetter = false
    var invokedImageBtnInstagramGetterCount = 0
    var stubbedImageBtnInstagram: String! = ""

    var imageBtnInstagram: String {
        invokedImageBtnInstagramGetter = true
        invokedImageBtnInstagramGetterCount += 1
        return stubbedImageBtnInstagram
    }

    var invokedImageBtnFaceBookGetter = false
    var invokedImageBtnFaceBookGetterCount = 0
    var stubbedImageBtnFaceBook: String! = ""

    var imageBtnFaceBook: String {
        invokedImageBtnFaceBookGetter = true
        invokedImageBtnFaceBookGetterCount += 1
        return stubbedImageBtnFaceBook
    }

    var invokedDoLogin = false
    var invokedDoLoginCount = 0
    var invokedDoLoginParameters: (email: String?, password: String?)?
    var invokedDoLoginParametersList = [(email: String?, password: String?)]()
    var stubbedDoLoginCompletionHandlerResult: (Result<Bool, Error>, Void)?

    func doLogin(email: String?, password: String?, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        invokedDoLogin = true
        invokedDoLoginCount += 1
        invokedDoLoginParameters = (email, password)
        invokedDoLoginParametersList.append((email, password))

        if let result = stubbedDoLoginCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
