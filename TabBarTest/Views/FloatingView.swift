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
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        view.alpha = 0.8
        return view
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "new-york")
        return imageView
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
            animateInputView(targetPosition: UIScreen.main.bounds.height/6*4, state: .PatriallyExpanded)
        }
    }
    
    func hideFloatingView() {
        switch expansionState {
        case .FullyExpanded:
            animateInputView(targetPosition: UIScreen.main.bounds.height, state: .NotExpanded)
            delegate?.floatingPanelIsHidden()
        case .PatriallyExpanded:
            animateInputView(targetPosition: UIScreen.main.bounds.height, state: .NotExpanded)
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
            animateInputView(targetPosition: UIScreen.main.bounds.height/6*2, state: .FullyExpanded)
        }
    }
    
    @objc func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            if expansionState == .NotExpanded {
                animateInputView(targetPosition: UIScreen.main.bounds.height/6*4, state: .PatriallyExpanded)
            } else if expansionState == .PatriallyExpanded {
                animateInputView(targetPosition: UIScreen.main.bounds.height/6*2,state: .FullyExpanded)
            }
            
        case .down:
            if expansionState == .FullyExpanded {
                animateInputView(targetPosition: UIScreen.main.bounds.height/6*4, state: .PatriallyExpanded)
            } else if expansionState == .PatriallyExpanded {
                animateInputView(targetPosition: UIScreen.main.bounds.height,state: .NotExpanded)
                delegate?.floatingPanelIsHidden()
            }
            
        default:
            break
        }
    }
    
    // MARK: - Helpers function
    
    func animateInputView(targetPosition: CGFloat, state: ExpansionState) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.frame.origin.y = targetPosition
                if state == .FullyExpanded {
                    self.imageView.frame.origin.y = -300
                } else if state == .NotExpanded {
                    self.imageView.frame.origin.y = UIScreen.main.bounds.height
                } else {
                    self.imageView.frame.origin.y = -180
                }
                
            })
        }
        self.expansionState = state
    }
    
    func configureViewComponents() {
        backgroundColor = .clear
        addSubview(imageView)
        addSubview(mainView)
        mainView.addSubview(indicatorView)
//        insertSubview(imageView, belowSubview: mainView)
        
        mainView.addConstraintsToFillView(view: self)
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: 250)
        indicatorView.anchor(top: topAnchor,
                             left: nil,
                             bottom: nil,
                             right: nil,
                             paddingTop: 8,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 80,
                             height: 6)
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
