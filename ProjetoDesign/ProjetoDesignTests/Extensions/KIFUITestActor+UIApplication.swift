//
//  KIFUITestActor+UIApplication.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 02/02/21.
//

import KIF

extension KIFUITestActor {
    func set(rootViewController: UIViewController) {
        setupAnimationsSpeed()
        resetLastRootViewController()

        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.rootViewController = rootViewController
            keyWindow.makeKeyAndVisible()
        } else {
            XCTFail("keyWindow is required")
        }

        rootViewController.beginAppearanceTransition(true, animated: false)
        rootViewController.endAppearanceTransition()
    }

    func resetRootViewController() {
        resetLastRootViewController()
    }

    // MARK: Private functions

    func setupAnimationsSpeed() {
        let expectedMainThreadStabilizationTimeout: Double = 2

        if KIFUITestActor.defaultMainThreadDispatchStabilizationTimeout() != expectedMainThreadStabilizationTimeout {
            UIApplication.shared.animationSpeed = 4.0
            KIFTestActor.setDefaultAnimationStabilizationTimeout(0.1)
            KIFUITestActor.setDefaultAnimationWaitingTimeout(2)
            KIFUITestActor.setDefaultMainThreadDispatchStabilizationTimeout(expectedMainThreadStabilizationTimeout)
        }
    }

    private func resetLastRootViewController() {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return XCTFail("keyWindow is required")
        }

        keyWindow.rootViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        keyWindow.rootViewController?.dismiss(animated: false, completion: nil)

        removeAllViewsFromAllWindows()

        keyWindow.rootViewController = UIViewController()
        keyWindow.makeKeyAndVisible()
    }

    private func removeAllViewsFromAllWindows() {
        UIApplication.shared.windows.flatMap({ window in window.subviews }).forEach { view in
            view.removeFromSuperview()
        }
    }
}
