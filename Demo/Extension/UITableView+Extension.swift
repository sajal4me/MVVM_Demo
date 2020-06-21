//
//  UITableView+Extension.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import UIKit

typealias CellRegisterProtocol = NibLoadableView & ReusableView

extension UITableViewCell: CellRegisterProtocol {}

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {

    private func register<T: UITableViewCell>(cell: T.Type) {
        let nibName = cell.nibName
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.defaultReuseIdentifier)
    }

    func register<T: UITableViewCell>(with cells: [T.Type]) {

        cells.forEach { cell in
            register(cell: cell)
        }
    }
}
