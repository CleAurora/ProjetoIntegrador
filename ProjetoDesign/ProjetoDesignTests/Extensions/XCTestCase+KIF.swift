//
//  XCTestCase+KIF.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 02/02/21.
//

import KIF
import class XCTest.XCTestCase

extension XCTestCase {
    func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        KIFEnableAccessibility()

        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func viewTester(file: String = #file, _ line: Int = #line) -> KIFUIViewTestActor {
        KIFEnableAccessibility()

        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }
}
