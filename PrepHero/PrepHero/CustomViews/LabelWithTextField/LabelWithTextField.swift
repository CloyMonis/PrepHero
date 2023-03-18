//
//  LabelWithTextField.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit

class LabelWithTextField: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var label: UILabel?
    @IBInspectable public var labelText: String = "" {
        didSet {
            if !labelText.isEmpty {
                label?.text = labelText
            }
        }
    }
    @IBInspectable public var textFieldText: String = "" {
        didSet {
            if !textFieldText.isEmpty {
                textField?.placeholder = textFieldText
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNibs()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initNibs()
    }
    //convenience init(frame: CGRect, skipOffest: UInt? = nil) {
    //    self.init(frame: frame)
    //}
    private func initNibs() {
        let nibName = String(describing: type(of: self))
        guard Bundle(for: type(of: self)).path(forResource: nibName, ofType: "nib") != nil else {
            return
        }
        Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)
        guard let contentView = self.contentView else {
            return
        }
        addSubview(contentView)
        contentView.frame = bounds
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor =  AppColors.viewBorder
        contentView.layer.cornerRadius = 10
        textField?.borderStyle = .none
        textField?.addTarget(self, action: #selector(textDidChanged), for: .allEditingEvents)
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    func validationsFailed(){
        contentView.layer.borderColor = UIColor.red.cgColor
    }
    @objc func textDidChanged(){
        guard let textField = textField, let text = textField.text else {
            return
        }
        if text.count > 0 {
            contentView.layer.borderColor =  AppColors.viewBorder
        }
    }
}
