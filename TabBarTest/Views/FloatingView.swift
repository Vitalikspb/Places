//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//


import UIKit

protocol FloatingViewDelegate {
    func floatingPanelIsHidden()
    func floatingPanelFullScreen()
    func floatingPanelPatriallyScreen()
}

class FloatingView: UIView {
    
    var delegate: FloatingViewDelegate?
    
    // MARK: - Properties
    
    enum ExpansionState {
        case NotExpanded
        case PatriallyExpanded
        case FullyExpanded
    }
    private var expansionState: ExpansionState!
    
    private  let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    // MARK: - Properties UI
    
    private let mainView = MainFloatingView(frame: .zero)
    
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        expansionState = .NotExpanded
        isUserInteractionEnabled = true
        mainView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleTapGesture() {
        switch expansionState {
        case .FullyExpanded, .none, .NotExpanded:
            print("Patrially?")
        case .PatriallyExpanded:
            delegate?.floatingPanelFullScreen()
            animateInputView(targetPosition: 0, state: .FullyExpanded)
        }
    }
    
    @objc func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            if expansionState == .NotExpanded {
                animateInputView(targetPosition: screenHeight/2, state: .PatriallyExpanded)
                delegate?.floatingPanelPatriallyScreen()
            } else if expansionState == .PatriallyExpanded {
                delegate?.floatingPanelFullScreen()
                animateInputView(targetPosition: 0, state: .FullyExpanded)
            }
            
        case .down:
            if expansionState == .FullyExpanded {
                animateInputView(targetPosition: screenHeight/2, state: .PatriallyExpanded)
                delegate?.floatingPanelPatriallyScreen()
            } else if expansionState == .PatriallyExpanded {
                animateInputView(targetPosition: screenHeight, state: .NotExpanded)
                delegate?.floatingPanelIsHidden()
            }
            
        default:
            break
        }
    }
    
    // MARK: - Helpers function
    
    func showFloatingView() {
        switch expansionState {
        case .FullyExpanded, .PatriallyExpanded, .none:
            break
        case .NotExpanded:
            animateInputView(targetPosition: screenHeight/2, state: .PatriallyExpanded)
        }
    }
    
    func hideFloatingView() {
        switch expansionState {
        case .FullyExpanded:
            animateInputView(targetPosition: screenHeight, state: .NotExpanded)
            delegate?.floatingPanelIsHidden()
        case .PatriallyExpanded:
            animateInputView(targetPosition: screenHeight, state: .NotExpanded)
            delegate?.floatingPanelIsHidden()
        case .none, .NotExpanded:
            break
            
        }
    }
    
    func cornerRadii(with radii: Int) {
        let layer = CAShapeLayer()
        let cornerPath = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: [.topLeft, .topRight],
                                      cornerRadii: CGSize(width: radii,
                                                          height: radii))
        layer.path = cornerPath.cgPath
        self.mainView.layer.mask = layer
        layoutIfNeeded()
    }
    
    func animateInputView(targetPosition: CGFloat, state: ExpansionState) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.frame.origin.y = targetPosition
                if state == .FullyExpanded {
                    self.cornerRadii(with: 0)
                } else if state == .NotExpanded {
                } else {
                    self.cornerRadii(with: 16)
                }
            })
        }
        self.expansionState = state
    }
    
    func configureUI() {
        backgroundColor = .clear
        addSubview(mainView)
        
        
        mainView.anchor(top: topAnchor,
                        left: leftAnchor,
                        bottom: bottomAnchor,
                        right: rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 0,
                        paddingBottom: 0,
                        paddingRight: 0,
                        width: 0,
                        height: 0)
        
        configureGestureRecognizer()
        
        self.standartShadow(view: self)
    }
    
    
    func configureGestureRecognizer() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeUp.direction = .up
        addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeDown.direction = .down
        addGestureRecognizer(swipeDown)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
    }
    
}

// MARK: - MainFloatingViewDelegate

extension FloatingView: MainFloatingViewDelegate {
    func closeFloatingView() {
        animateInputView(targetPosition: screenHeight, state: .NotExpanded)
        delegate?.floatingPanelIsHidden()
    }
    
    
}
