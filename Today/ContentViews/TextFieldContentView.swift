//
//  TextFieldContentView.swift
//  Today
//
//  Created by Ricardo on 13/08/24.
//

import Foundation
import UIKit

class TextFieldContentView: UIView, UIContentView {
    // Adopting UIContentView protocol signals that this view renders the content and styling that you define within a configuration
    
    // MARK: Properties
    
    struct Configuration: UIContentConfiguration{
        var text: String? = ""
        var onChange: (String) -> Void = { _ in } //  behavior that you’d like to perform when the user edits the text in the text field.
        func makeContentView() -> any UIView & UIContentView { // UIView that conforms to the UIContentView protocol.
            return TextFieldContentView(self)
        }
    }
    
    let textField = UITextField()
    var configuration: UIContentConfiguration {
        didSet {
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
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        textField.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        textField.clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func configure(configuration: UIContentConfiguration){
        guard let configuration = configuration as? Configuration else {return}
        textField.text = configuration.text
    }
    
    @objc private func didChange(_ sender: UITextField){
        guard let configuration = configuration as? TextFieldContentView.Configuration else {return}
        configuration.onChange(textField.text ?? "")
    }
}

extension UICollectionViewListCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration {
        TextFieldContentView.Configuration()
    }
}
