import UIKit
import PlaygroundSupport

class CustomProgressView: UIView {
    var borderWidth: CGFloat?
    let bgView = UIView()
    let fgView = UIView()
    var currentProgress: CGFloat = 0.4
    var total: CGFloat = 1
    
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
        bgView.backgroundColor = UIColor.systemGray5
        
        fgView.translatesAutoresizingMaskIntoConstraints = false
        fgView.backgroundColor = UIColor(named: "AccentColor")

        self.addSubview(bgView)
        bgView.addSubview(fgView)
        fgView.clipsToBounds = true
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth ?? CGFloat(1)
        self.layer.borderColor = UIColor.systemGray3.cgColor
        
        progressConstraint = fgView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -(borderWidth ?? 1) + (self.frame.width * (currentProgress / total)))

        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: borderWidth ?? 1),
            bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(borderWidth ?? 1)),
            bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: borderWidth ?? 1),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(borderWidth ?? 1)),
            fgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: borderWidth ?? 1),
//            fgView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset + (self.frame.width * (currentProgress / total))),
            progressConstraint,
            fgView.topAnchor.constraint(equalTo: self.topAnchor, constant: borderWidth ?? 1),
            fgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(borderWidth ?? 1)),

        ])
    }
    
    func setProgress(currentProgress: CGFloat) {
        UIView.animate(withDuration: 0.25) {
//            NSLayoutConstraint.deactivate([
//                self.progressConstraint
//            ])
            
//            self.progressConstraint = self.fgView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -(self.borderWidth ?? 1) + (self.frame.width * (currentProgress / self.total)))
//
//            NSLayoutConstraint.activate([
//                self.progressConstraint
//            ])
            self.progressConstraint.constant = -(self.borderWidth ?? 1) + (self.frame.width * (currentProgress / self.total))
        }
    }
}

let customView = CustomProgressView(frame: CGRect(x: 0, y: 0, width: 256, height: 48), borderWidth: 1)
PlaygroundPage.current.liveView = customView

customView.setProgress(currentProgress: 0.5)
customView.setProgress(currentProgress: 0.8)
customView.setProgress(currentProgress: 0.2)
customView.setProgress(currentProgress: 0.1)
customView.setProgress(currentProgress: 0.0)
customView.setProgress(currentProgress: 1.0)




