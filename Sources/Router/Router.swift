import UIKit

// MARK: - It is responsible for creating navigation in App
final public class RouterService {
    
    // MARK: - VC
    private var newNavigationVC: UINavigationController?
    private var currentWindow: UIWindow?? {
        if #available(iOS 13, *) {
            UIApplication.shared.windows.first
        } else {
            UIApplication.shared.delegate?.window
        }
    }
    
    private var tabBarController: UITabBarController?
    
    public var dismiss: () -> () = {}
    public var currentVC: UIViewController? {
        self.currentWindow??.visibleViewController()
    }
    
    private var navigationViewController: UINavigationController?{
        if let navigationController = self.currentWindow??.visibleViewController() as? UINavigationController {
            return navigationController
        } else {
            return self.currentWindow??.visibleViewController()?.navigationController as? UINavigationController
        }
    }
    
    // MARK: - Логика переключения в навигационном контроллере
    public func pushMainNavigation(
        to viewController: UIViewController,
        animated: Bool = false
    ) {
        self.navigationViewController?.pushViewController(viewController, animated: animated)
    }
    
    public func setupTabBarControllerVC(with tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    public func switchTabBar(with selectedIndex: Int){
        self.tabBarController?.selectedIndex = selectedIndex
    }
    
    public func popMainNavigation(
        to viewController: UIViewController,
        animated: Bool
    ) {
        self.navigationViewController?.popToViewController(viewController, animated: animated)
    }
    
    public func popMainNavigation(animated: Bool){
        self.navigationViewController?.popViewController(animated: true)
    }
    
    public func popToRoot(animated: Bool){
        self.navigationViewController?.popToRootViewController(animated: animated)
    }
    
    public func setRightLeftButton(
        rightBarButtonItem: UIBarButtonItem?,
        leftBarButtonItem: UIBarButtonItem?
    ){
        self.navigationViewController?.setRightLeftButton(
            rightBarButtonItem: rightBarButtonItem,
            leftBarButtonItem: leftBarButtonItem
        )
    }
    
    public func navBarSetTitle(title: String) {
        self.navigationViewController?.setTitle(
            title: title
        )
    }
    
    public func navBarBackButton(title: String) {
        self.navigationViewController?.setBackButtonTitle(
            title: title)
    }
    
    public func backButtonTintColor(
        tintColor: UIColor
    ) {
        self.navigationViewController?.setBackButtonTintColor(
            tintColor: tintColor
        )
    }
    
    public func navBarBackButtonHidden() {
        self.navigationViewController?.hiddenBackButton()
    }
    
    @available(iOS, deprecated, message: "Используй раздельные методы")
    public func setupMainNavigationVC(
        isNavigationBarHidden: Bool = false,
        animatedHidden: Bool = false,
        tintColor: UIColor = .blue,
        backButtonTitle: String = "",
        title: String = "",
        backgroundColor: UIColor = .clear
    ) {
        self.navigationViewController?.setColor(
            tintColor: tintColor,
            backgroundColor: backgroundColor
        )
        self.navigationViewController?.setTitle(
            title: title
        )
        self.navigationViewController?.setBackButtonTitle(
            title: backButtonTitle
        )
        self.navigationViewController?.setHidden(
            isNavigationBarHidden: isNavigationBarHidden,
            animatedHidden: animatedHidden
        )
    }
    
    // MARK: - Логика установки рутового контроллера
    public func setRootViewController(
        viewController rootViewController: UIViewController
    ) {
        //создаем рутовый контроллер
        currentWindow??.rootViewController = rootViewController
        currentWindow??.makeKeyAndVisible()
    }
    
    // MARK: - Логика отображения в контроле другой контроллер
    public func present(
        with presentType: PresentType,
        animation: Bool = false,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        presentationStyle: UIModalPresentationStyle = .fullScreen,
        isSetCurrent: Bool = false,
        completion: @escaping () -> Void = {}
    ) {
        switch presentType {
            case .viewController(let viewController):
                present(
                    with: viewController,
                    animation: animation,
                    transitionStyle: transitionStyle,
                    presentationStyle: presentationStyle,
                    completion: completion
                )
            case .onTabBar(let viewController):
                presentOnTabBar(
                    with: viewController,
                    animation: animation,
                    transitionStyle: transitionStyle,
                    presentationStyle: presentationStyle,
                    completion: completion
                )
            case .system(let system):
                systemPush(with: system)
        }
    }
    
    // MARK: - Логика возврата
    public func dismiss(
        animated: Bool,
        completion: @escaping (() -> Void) = {}
    ) {
        self.currentVC?.dismiss(
            animated: animated,
            completion: {
                completion()
                self.dismiss()
            }
        )
    }
    
    // MARK: - Проверка
    private func isEqualTopVC(with presentVC: UIViewController) -> Bool {
        guard let topViewController = self.navigationViewController?.topViewController else { return false }
        let viewController  = String(describing: Mirror(reflecting: topViewController).subjectType)
        let presentVCString = String(describing: Mirror(reflecting: presentVC).subjectType)
        let isEqual         = viewController.contains(presentVCString)
        return isEqual
    }
    
    private func isEqualNextVC(with nextVC: UIViewController) -> Bool {
        guard let currentVC = self.currentVC else { return false }
        let currentController = String(describing: Mirror(reflecting: currentVC).subjectType)
        let nextController    = String(describing: Mirror(reflecting: nextVC).subjectType)
        let isEqual           = currentController.contains(nextController)
        return isEqual
    }
    
    private func present(
        with presentVC: UIViewController?,
        animation: Bool = true,
        transitionStyle: UIModalTransitionStyle,
        presentationStyle: UIModalPresentationStyle,
        completion: @escaping () -> Void
    ) {
        guard let presentVC = presentVC else { return }
        currentVC?.present(
            with: presentVC,
            with: animation,
            with: transitionStyle,
            with: presentationStyle,
            completion: completion
        )
    }
    
    private func presentOnTabBar(
        with presentVC: UIViewController?,
        animation: Bool = true,
        transitionStyle: UIModalTransitionStyle,
        presentationStyle: UIModalPresentationStyle,
        completion: @escaping () -> Void
    ) {
        guard let presentVC = presentVC else { return }
        tabBarController?.present(
            with: presentVC,
            with: animation,
            with: transitionStyle,
            with: presentationStyle,
            completion: completion
        )
    }
    
    // MARK: - Тип перехода
    public enum PresentType {
        case system(Systems)
        case viewController(UIViewController)
        case onTabBar(UIViewController)
    }
    
    public func systemPush(with systems: Systems){
        switch systems {
            case .setting:
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(
                        url,
                        options: [:],
                        completionHandler: nil
                    )
                }
        }
    }
    
    public enum Systems {
        case setting
    }
    
    public init() {}
}

