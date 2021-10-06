//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//


import UIKit

protocol FloatingViewDelegate {
    func floatingPanelIsHidden()
}

class FloatingView: UIView {
    
    // MARK: - Properties
    
    enum ExpansionState {
        case NotExpanded
        case PatriallyExpanded
        case FullyExpanded
    }
    var expansionState: ExpansionState!
    var delegate: FloatingViewDelegate?
    // MARK: - Properties UI
    
    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        view.alpha = 0.8
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
        expansionState = .NotExpanded
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    func showFloatingView() {
        switch expansionState {
        case .FullyExpanded, .PatriallyExpanded, .none:
            break
        case .NotExpanded:
            animateInputView(targetPosition: self.frame.origin.y - 250) { (_) in
                self.expansionState = .PatriallyExpanded
            }
        }
    }
    func hideFloatingView() {
        switch expansionState {
        case .FullyExpanded:
            animateInputView(targetPosition: UIScreen.main.bounds.height) { (_) in
                self.expansionState = .NotExpanded
            }
            delegate?.floatingPanelIsHidden()
        case .PatriallyExpanded:
            animateInputView(targetPosition: self.frame.origin.y + 250) { (_) in
                self.expansionState = .NotExpanded
            }
            delegate?.floatingPanelIsHidden()
        case .none, .NotExpanded:
            break
            
        }
    }
    
    @objc func handleTapGesture() {
        switch expansionState {
        case .FullyExpanded, .none, .NotExpanded:
            break
        case .PatriallyExpanded:
            animateInputView(targetPosition: self.frame.origin.y - 410) { (_) in
                self.expansionState = .FullyExpanded
            }

        
        }
    }
    
    @objc func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            if expansionState == .NotExpanded {
                animateInputView(targetPosition: self.frame.origin.y - 250) { (_) in
                    self.expansionState = .PatriallyExpanded
                }
            }
            if expansionState == .PatriallyExpanded {
                animateInputView(targetPosition: self.frame.origin.y - 410) { (_) in
                    self.expansionState = .FullyExpanded
                }
            }
            
        case .down:
            if expansionState == .FullyExpanded {
                animateInputView(targetPosition: self.frame.origin.y + 410) { (_) in
                    self.expansionState = .PatriallyExpanded
                }
            }
            if expansionState == .PatriallyExpanded {
                animateInputView(targetPosition: self.frame.origin.y + 250) { (_) in
                    self.expansionState = .NotExpanded
                }
                delegate?.floatingPanelIsHidden()
            }
            
        default:
            break
        }
    }
    
    // MARK: - Helpers function
    
    
    
    func animateInputView(targetPosition: CGFloat, completion: @escaping(Bool) -> ()) {
        DispatchQueue.main.async {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
                self.frame.origin.y = targetPosition
            
            
        }, completion: completion)
        }
    }
    
    func configureViewComponents() {
        backgroundColor = .white
        addSubview(indicatorView)
        indicatorView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 6)
        indicatorView.centerX(inView: self)
        configureGestureRecognizer()
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
