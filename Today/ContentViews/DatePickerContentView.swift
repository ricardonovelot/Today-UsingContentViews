//
//  DatePickerContentView.swift
//  Today
//
//  Created by Ricardo on 14/08/24.
//

import Foundation
import UIKit

class DatePickerContentView: UIView, UIContentView{
    // MARK: Properties
    struct Configuration: UIContentConfiguration{
        var date = Date.now
        
        func makeContentView() -> any UIView & UIContentView {
            return DatePickerContentView(self)
        }
        var onChange: (Date) -> Void = {_ in}
    }
    
    let datePicker = UIDatePicker()
    var configuration: UIContentConfiguration{
        didSet{
            configure(configuration: configuration)
        }
    }
    
    // MARK: Init
    
    init(_ configuration: UIContentConfiguration){
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(datePicker)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(didChange(_:)) , for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func configure(configuration: UIContentConfiguration){
        guard let configuration = configuration as? Configuration else {return}
        datePicker.date = configuration.date
    }
    
    @objc private func didChange(_ sender: UIDatePicker){
        guard let configuration = configuration as? DatePickerContentView.Configuration else {return}
        configuration.onChange(datePicker.date)
    }
}

extension UICollectionViewListCell {
    func datePickerConfiguration() -> DatePickerContentView.Configuration {
        DatePickerContentView.Configuration()
    }
}
