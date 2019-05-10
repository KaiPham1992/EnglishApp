//
//  SideMenuViewController.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit


protocol MenuProtocol: class {
    func openViewController(presentingController: UIViewController)
    func pushViewController(presentingController: UIViewController)
}


open class SideMenuViewController: UIViewController, UIGestureRecognizerDelegate {
    
    /**************************************************************************/
    // MARK: - Types
    /**************************************************************************/
    
    @objc public enum DrawerDirection: Int {
        case left, right
    }
    
    @objc public enum DrawerState: Int {
        case opened, closed
    }
    
    /**************************************************************************/
    // MARK: - Properties
    /**************************************************************************/
    
    @IBInspectable public var containerViewMaxAlpha: CGFloat = 0.2
    
    @IBInspectable public var drawerAnimationDuration: TimeInterval = 0.25
    
    @IBInspectable public var mainSegueIdentifier: String?
    
    @IBInspectable public var drawerSegueIdentifier: String?
    
    private var _drawerConstraint: NSLayoutConstraint!
    
    private var _drawerWidthConstraint: NSLayoutConstraint!
    
    private var _panStartLocation = CGPoint.zero
    
    private var _panDelta: CGFloat = 0
    
    lazy private var _containerView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.0, alpha: 0)
        view.addGestureRecognizer(self.containerViewTapGesture)
        return view
    }()
    
    private var _isAppearing: Bool?
    
    public var screenEdgePanGestureEnabled = true
    
    public private(set) lazy var screenEdgePanGesture: UIScreenEdgePanGestureRecognizer = {
        let gesture = UIScreenEdgePanGestureRecognizer(
            target: self,
            action: #selector(SideMenuViewController.handlePanGesture(_:))
        )
        switch self.drawerDirection {
        case .left:     gesture.edges = .left
        case .right:    gesture.edges = .right
        }
        gesture.delegate = self
        return gesture
    }()
    
    public private(set) lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(SideMenuViewController.handlePanGesture(_:))
        )
        gesture.delegate = self
        return gesture
    }()
    
    public private(set) lazy var containerViewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(SideMenuViewController.didtapContainerView(_:))
        )
        gesture.delegate = self
        return gesture
    }()
    
    public var drawerDirection: DrawerDirection = .left {
        didSet {
            switch drawerDirection {
            case .left:  screenEdgePanGesture.edges = .left
            case .right: screenEdgePanGesture.edges = .right
            }
        }
    }
    
    public var drawerState: DrawerState {
        get { return _containerView.isHidden ? .closed : .opened }
        set { setDrawerState(drawerState) }
    }
    
    @IBInspectable public var drawerWidth: CGFloat = 280 {
        didSet { _drawerWidthConstraint?.constant = drawerWidth }
    }
    
    public var displayingViewController: UIViewController? {
        switch drawerState {
        case .closed:
            return mainViewController
        case .opened:
            return menuViewController
        }
    }
    
    public var mainViewController: UIViewController! {
        didSet {
            if let oldController = oldValue {
                oldController.willMove(toParent: nil)
                oldController.view.removeFromSuperview()
                oldController.removeFromParent()
            }
            
            guard let mainViewController = mainViewController else { return }
            addChild(mainViewController)
            
            mainViewController.view.translatesAutoresizingMaskIntoConstraints = false
            view.insertSubview(mainViewController.view, at: 0)
            
            let viewDictionary = ["mainView": mainViewController.view!]
            view.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|-0-[mainView]-0-|",
                    options: [],
                    metrics: nil,
                    views: viewDictionary
                )
            )
            view.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|-0-[mainView]-0-|",
                    options: [],
                    metrics: nil,
                    views: viewDictionary
                )
            )
            
            mainViewController.didMove(toParent: self)
        }
    }
    
    var menuViewController: UIViewController?
    var rootNavigation: UINavigationController?
    
    /**************************************************************************/
    // MARK: - initialize
    /**************************************************************************/
    
    public init(drawerDirection: DrawerDirection, drawerWidth: CGFloat, menuViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.drawerDirection = drawerDirection
        self.drawerWidth     = drawerWidth
        self.menuViewController = menuViewController
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**************************************************************************/
    // MARK: - Life Cycle
    /**************************************************************************/
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let viewDictionary = ["_containerView": _containerView]
        
        view.addGestureRecognizer(screenEdgePanGesture)
        view.addGestureRecognizer(panGesture)
        view.addSubview(_containerView)
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[_containerView]-0-|",
                options: [],
                metrics: nil,
                views: viewDictionary
            )
        )
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[_containerView]-0-|",
                options: [],
                metrics: nil,
                views: viewDictionary
            )
        )
        _containerView.isHidden = true
        
        if let mainSegueID = mainSegueIdentifier {
            performSegue(withIdentifier: mainSegueID, sender: self)
        }
        if let drawerSegueID = drawerSegueIdentifier {
            performSegue(withIdentifier: drawerSegueID, sender: self)
        }
        
        setLayoutForMenu()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayingViewController?.beginAppearanceTransition(true, animated: animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayingViewController?.endAppearanceTransition()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        displayingViewController?.beginAppearanceTransition(false, animated: animated)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        displayingViewController?.endAppearanceTransition()
    }
    
    //
    func setLayoutForMenu() {
        guard let menuViewController = menuViewController else { return }
        addChild(menuViewController)
        
        menuViewController.view.layer.shadowColor   = UIColor.black.cgColor
        menuViewController.view.layer.shadowOpacity = 0.4
        menuViewController.view.layer.shadowRadius  = 5.0
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        _containerView.addSubview(menuViewController.view)
        
        let itemAttribute: NSLayoutConstraint.Attribute
        let toItemAttribute: NSLayoutConstraint.Attribute
        switch drawerDirection {
        case .left:
            itemAttribute   = .right
            toItemAttribute = .left
        case .right:
            itemAttribute   = .left
            toItemAttribute = .right
        }
        
        _drawerWidthConstraint = NSLayoutConstraint(
            item: menuViewController.view,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.width,
            multiplier: 1,
            constant: drawerWidth
        )
        menuViewController.view.addConstraint(_drawerWidthConstraint)
        
        _drawerConstraint = NSLayoutConstraint(
            item: menuViewController.view,
            attribute: itemAttribute,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: _containerView,
            attribute: toItemAttribute,
            multiplier: 1,
            constant: 0
        )
        _containerView.addConstraint(_drawerConstraint)
        
        let viewDictionary = ["drawerView": menuViewController.view!]
        _containerView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[drawerView]-0-|",
                options: [],
                metrics: nil,
                views: viewDictionary
            )
        )
        
        _containerView.layoutIfNeeded()
        menuViewController.didMove(toParent: self)
    }
    
    // We will manually call `mainViewController` or `menuViewController`'s
    // view appearance methods.
    override open var shouldAutomaticallyForwardAppearanceMethods: Bool {
        get {
            return false
        }
    }
    
    /**************************************************************************/
    // MARK: - Public Method
    /**************************************************************************/
    public func toggleLeftPanel() {
        let toggleState: DrawerState = _containerView.isHidden ? .opened : .closed
        setDrawerState(toggleState)
    }
    
    public func setDrawerState(_ state: DrawerState) {
        
        _containerView.isHidden = false
        let duration: TimeInterval = drawerAnimationDuration
        
        let isAppearing = state == .opened
        if _isAppearing != isAppearing {
            _isAppearing = isAppearing
            menuViewController?.beginAppearanceTransition(isAppearing, animated: true)
            mainViewController?.beginAppearanceTransition(!isAppearing, animated: true)
        }
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { () -> Void in
                        switch state {
                        case .closed:
                            self._drawerConstraint.constant     = 0
                            self._containerView.backgroundColor = UIColor(white: 0, alpha: 0)
                        case .opened:
                            let constant: CGFloat
                            switch self.drawerDirection {
                            case .left:
                                constant = self.drawerWidth
                            case .right:
                                constant = -self.drawerWidth
                            }
                            self._drawerConstraint.constant     = constant
                            self._containerView.backgroundColor = UIColor(
                                white: 0, alpha: self.containerViewMaxAlpha
                            )
                        }
                        self._containerView.layoutIfNeeded()
        }) { (finished: Bool) -> Void in
            if state == .closed {
                self._containerView.isHidden = true
            }
            self.menuViewController?.endAppearanceTransition()
            self.mainViewController?.endAppearanceTransition()
            self._isAppearing = nil
        }
    }
    
    /**************************************************************************/
    // MARK: - Private Method
    /**************************************************************************/
    
    @objc final func handlePanGesture(_ sender: UIGestureRecognizer) {
        _containerView.isHidden = false
        if sender.state == .began {
            _panStartLocation = sender.location(in: view)
        }
        
        let delta = CGFloat(sender.location(in: view).x - _panStartLocation.x)
        let constant: CGFloat
        let backGroundAlpha: CGFloat
        let drawerState: DrawerState
        
        switch drawerDirection {
        case .left:
            drawerState     = _panDelta <= 0 ? .closed : .opened
            constant        = min(_drawerConstraint.constant + delta, drawerWidth)
            backGroundAlpha = min(
                containerViewMaxAlpha,
                containerViewMaxAlpha*(abs(constant)/drawerWidth)
            )
        case .right:
            drawerState     = _panDelta >= 0 ? .closed : .opened
            constant        = max(_drawerConstraint.constant + delta, -drawerWidth)
            backGroundAlpha = min(
                containerViewMaxAlpha,
                containerViewMaxAlpha*(abs(constant)/drawerWidth)
            )
        }
        
        _drawerConstraint.constant = constant
        _containerView.backgroundColor = UIColor(
            white: 0,
            alpha: backGroundAlpha
        )
        
        switch sender.state {
        case .changed:
            let isAppearing = drawerState != .opened
            if _isAppearing == nil {
                _isAppearing = isAppearing
                menuViewController?.beginAppearanceTransition(isAppearing, animated: true)
                mainViewController?.beginAppearanceTransition(!isAppearing, animated: true)
            }
            
            _panStartLocation = sender.location(in: view)
            _panDelta         = delta
        case .ended, .cancelled:
            setDrawerState(drawerState)
        default:
            break
        }
    }
    
    @objc final func didtapContainerView(_ gesture: UITapGestureRecognizer) {
        setDrawerState(.closed)
    }
    
    /**************************************************************************/
    // MARK: - UIGestureRecognizerDelegate
    /**************************************************************************/
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        switch gestureRecognizer {
        case panGesture:
            return drawerState == .opened
        case screenEdgePanGesture:
            return screenEdgePanGestureEnabled ? drawerState == .closed : false
        default:
            return touch.view == gestureRecognizer.view
        }
    }
    
}

extension SideMenuViewController: MenuProtocol {
    func openViewController(presentingController: UIViewController) {
        self.mainViewController = UINavigationController(rootViewController: presentingController)
        rootNavigation = presentingController.navigationController
        self.setDrawerState(.closed)
    }
    
    func pushViewController(presentingController: UIViewController) {
        self.push(controller: presentingController)
        rootNavigation?.pushViewController(presentingController, animated: true)
        self.setDrawerState(.closed)
    }
}

