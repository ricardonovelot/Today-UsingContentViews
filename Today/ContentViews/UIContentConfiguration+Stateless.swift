//
//  UIContentConfiguration+Stateless.swift
//  Today
//
//  Created by Ricardo on 14/08/24.
//

import Foundation
import UIKit

extension UIContentConfiguration{
    func updated(for state: UIConfigurationState) -> Self { // provide a specialized configuration for a given state.
        return self
    }
}
