//
//  BoxView.swift
//  OWLML
//
//  Created by Tyler Milner on 5/18/19.
//  Copyright © 2019 Tyler Milner. All rights reserved.
//

import UIKit

class BoxView: UIView {
    
    // MARK: - Static
    
    static var defaultStrokeWidth: CGFloat = 1.0
    static var defaultSelectedStrokeWidth: CGFloat = defaultStrokeWidth * 2
    static var defaultStrokeColor: UIColor = .red
    
    // MARK: - Properties
    
    var strokeWidth: CGFloat = defaultStrokeWidth {
        didSet {
            updateStroke()
        }
    }
    
    var selectedStrokeWidth: CGFloat = defaultSelectedStrokeWidth {
        didSet {
            updateStroke()
        }
    }
    
    var strokeColor: UIColor = defaultStrokeColor {
        didSet {
            updateStroke()
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            updateStroke()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        updateStroke()
    }
    
    // MARK: - Private
    
    private func updateStroke() {
        layer.borderWidth = isSelected ? selectedStrokeWidth : strokeWidth
        layer.borderColor = strokeColor.cgColor
    }
}
