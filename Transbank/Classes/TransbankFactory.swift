//
//  TransbankFactor.swift
//  Transbank
//
//  Created by Kevin on 6/27/20.
//

import BasicCommons
import BasicUIElements

/// Class for the TransbankFactory
public class TransbankFactory {
    /// Init for the TransbankFactory
    public init() { }

    /// Func getRootViewController for the TransbankFactory
    public func getRootViewController() -> UIViewController {
        TransbankMainNavigationController()
    }

    /// Func getExampleRootViewController for the TransbankFactory
    public func getExampleRootViewController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [TransbankMainNavigationController()]
        tabBarController.tabBar.isTranslucent = false
        return tabBarController
    }
}

private class TransbankMainNavigationController: UINavigationController {

    let viewController = TransbankLandingViewController()

    init() {
        viewController.tabBarItem = UITabBarItem(
            title: "Transbank",
            image: MainAsset.tabHome.image,
            tag: 0
        )
        let bundleToUse = Utils.bundle(forClass: TransbankLandingViewController.classForCoder())
        super.init(nibName: "TransbankLandingViewController", bundle: bundleToUse)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        navigationBar.isHidden = true
        viewController.extendedLayoutIncludesOpaqueBars = true
        viewControllers = [viewController]
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }
}
