//
//  TextViewContentView.swift
//  Today
//
//  Created by Ricardo on 14/08/24.
//

import Foundation
import UIKit

class TextViewContentView: UIView, UIContentView {
    
    // MARK: Properties
    struct Configuration: UIContentConfiguration{
        var text: String? = ""
        
        func makeContentView() -> any UIView & UIContentView {
            return TextViewContentView(self)
        }
    }
    
    let textView = UITextView()
    var configuration: UIContentConfiguration{
        didSet{
            configure(configuration: configuration)
        }
    }
    
    //Setting this property allows a custom view to communicate its preferred size to the layout system.
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    // MARK: Init
    
    init(_ configuration: UIContentConfiguration){
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textView, height: 200)
        textView.backgroundColor = nil
        textView.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func configure(configuration: UIContentConfiguration){
        guard let configuration = configuration as? Configuration else {return}
        textView.text = configuration.text
    }
}

extension UICollectionViewListCell {
    func textViewConfiguration() -> TextViewContentView.Configuration {
        TextViewContentView.Configuration()
    }
}
