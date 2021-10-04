//
//  CustomProgressView.swift
//  TestAppProto
//
//  Created by Daniel Pitts on 10/2/21.
//

import UIKit

class CustomProgressView: UIView {
    var borderWidth: CGFloat?
    let bgView = UIView()
    let fgView = UIView()
    var currentProgress: CGFloat = 0.0
    var total: CGFloat = 1.0
    
    init(frame: CGRect, borderWidth: CGFloat) {
        self.borderWidth = borderWidth
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    var progressConstraint = NSLayoutConstraint()
    
    func setupView() {
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = UIColor.systemGroupedBackground
        
        fgView.translatesAutoresizingMaskIntoConstraints = false
        fgView.backgroundColor = UIColor(named: "AccentColor")

        self.addSubview(bgView)
        bgView.addSubview(fgView)
        fgView.clipsToBounds = true
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth ?? CGFloat(1)
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        progressConstraint = fgView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: (borderWidth ?? 1) + (self.frame.width * (currentProgress / total)))

        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: borderWidth ?? 1),
            bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(borderWidth ?? 1)),
            bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: borderWidth ?? 1),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(borderWidth ?? 1)),
            fgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: borderWidth ?? 1),
            progressConstraint,
            fgView.topAnchor.constraint(equalTo: self.topAnchor, constant: borderWidth ?? 1),
            fgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(borderWidth ?? 1)),
        ])
    }
    
    func setProgress(_ currentProgress: CGFloat) {
        self.progressConstraint.constant = -(self.borderWidth ?? 1) + (self.frame.width * (currentProgress / self.total))
            
        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseInOut) {
            self.layoutIfNeeded()
        }
    }
    
}
