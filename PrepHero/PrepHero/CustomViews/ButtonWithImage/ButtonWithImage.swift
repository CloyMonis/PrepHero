//
//  LabelWithImage.swift
//  PrepHero
//
//  Created by Cloy Vserv on 18/02/23.
//

import UIKit

protocol ButtonWithImageDelegate {
    func buttonClicked(tag: Int)
}

class ButtonWithImage: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    var delegate: ButtonWithImageDelegate?
    @IBInspectable public var leftImageName: String = "" {
        didSet {
            if !leftImageName.isEmpty {
                leftImageView.image = UIImage(named: leftImageName)
            }
        }
    }
    @IBInspectable public var buttonText: String = "" {
        didSet {
            if !buttonText.isEmpty {
                button.setTitle(buttonText, for: .normal)
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
        contentView.layer.borderColor =  UIColor(hex: "#ada4a5")?.cgColor
        contentView.layer.cornerRadius = 10
        button.setTitleColor(UIColor(hex: "#ada4a5"), for: .normal)
        if let font = UIFont(name: CustomFonts.regular.rawValue, size: 15) {
            button.titleLabel?.font = font
        }
        button.contentHorizontalAlignment = .left
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    func validationsFailed(){
        contentView.layer.borderColor = UIColor.red.cgColor
    }
    @IBAction func buttonClicked(_ sender: Any){
        delegate?.buttonClicked(tag: self.tag)
    }
}
