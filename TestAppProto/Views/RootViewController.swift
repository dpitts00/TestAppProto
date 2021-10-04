//
//  RootViewController.swift
//  TestAppProto
//
//  Created by Daniel Pitts on 10/3/21.
//

import UIKit

class RootViewController: UIViewController, UINavigationBarDelegate, DonationViewControllerDelegate {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var donationTotalLabel: UILabel!
    @IBOutlet weak var startProgressLabel: UILabel!
    @IBOutlet weak var endProgressLabel: UILabel!
    @IBOutlet weak var customProgressView: CustomProgressView!
    
    @IBOutlet weak var horizontalRule: UIView!
    @IBOutlet weak var giveButtonBackground: UIView!
    @IBOutlet weak var giveButton: UIButton!
    @IBAction func giveButtonTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DonationFormView") as? DonationViewController {
            vc.delegate = self
           present(vc, animated: true)
        }
        
        // ALTERNATE: Alert Controller, for testing
        /*
        let alert = UIAlertController(title: "Donate Now", message: "Please enter the amount that you would like to donate.", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?[0].keyboardType = .decimalPad // error with kybd type?
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            let text = alert.textFields?[0].text ?? ""
            let donationAmount = CGFloat(Float(text) ?? 0)
            guard donationAmount > 0 else {
                return
            }
            self?.donationTotalAmount += donationAmount
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
        */
    }
    
    var goalAmount: CGFloat = 12000.0
    var currentAmount: CGFloat = 0.0 {
        didSet {
            setDonationText()
            
            if currentAmount <= goalAmount {
                customProgressView.setProgress(currentAmount / goalAmount)
            } else {
                customProgressView.setProgress(1.0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.delegate = self
        
        setCustomFonts()
        setDonationText()
    }
    
    func setCustomFonts() {
        let buttonFont = UIFont(name: "Avenir-Heavy", size: 18)!
        let customButtonFont = UIFontMetrics(forTextStyle: .headline).scaledFont(for: buttonFont)
        giveButton.layer.cornerRadius = 8.0
        let attributedTitle = NSAttributedString(string: "Give Now!", attributes: [.font: customButtonFont])
        giveButton.setAttributedTitle(attributedTitle, for: .normal)
        giveButton.titleLabel?.adjustsFontForContentSizeCategory = true
        giveButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let headlineFont = UIFont(name: "Avenir-Heavy", size: UIFont.systemFontSize)!
        let customHeadlineFont = UIFontMetrics(forTextStyle: .headline).scaledFont(for: headlineFont)
        descriptionTitleLabel.font = customHeadlineFont
        descriptionTitleLabel.adjustsFontForContentSizeCategory = true
        descriptionTitleLabel.adjustsFontSizeToFitWidth = true
        
        donationTotalLabel.adjustsFontForContentSizeCategory = true
        donationTotalLabel.adjustsFontSizeToFitWidth = true
        
        let bodyFont = UIFont(name: "Avenir", size: UIFont.systemFontSize)!
        let customBodyFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: bodyFont)
        projectTitleLabel.font = customBodyFont
        projectTitleLabel.adjustsFontForContentSizeCategory = true
        projectTitleLabel.adjustsFontSizeToFitWidth = true
        projectTitleLabel.numberOfLines = 2
        
        descriptionTextLabel.adjustsFontForContentSizeCategory = true
        descriptionTextLabel.font = customBodyFont
        
//        startProgressLabel.adjustsFontForContentSizeCategory = true
        startProgressLabel.font = customBodyFont
        
//        endProgressLabel.adjustsFontForContentSizeCategory = true
        endProgressLabel.font = customBodyFont
        
        // keep or toss?
        if traitCollection.userInterfaceStyle == .light {
            giveButtonBackground.layer.shadowRadius = 12.0
            giveButtonBackground.layer.shadowColor = UIColor.opaqueSeparator.cgColor
            giveButtonBackground.layer.shadowOpacity = 0.5
            horizontalRule.layer.opacity = 0.25
        }
    }
    
    func setDonationText() {
        let donationTotalString = CurrencyNumberFormatter.currencyString(amount: currentAmount) ?? "0.00"
        let font = UIFont.systemFont(ofSize: 24, weight: .bold)
        let customFont = UIFontMetrics(forTextStyle: .title1).scaledFont(for: font)
        let donationTotalAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "AccentColor")?.cgColor ?? UIColor.systemPurple,
            .font: customFont,
        ]
        let donationAttrString = NSMutableAttributedString(string: donationTotalString, attributes: donationTotalAttrs)
        
        let fontPlain = UIFont(name: "Avenir", size: UIFont.systemFontSize)!
        let customFontPlain = UIFontMetrics(forTextStyle: .body).scaledFont(for: fontPlain)
        
        let donationTextAttrs: [NSAttributedString.Key: Any] = [
            .font: customFontPlain
        ]
        let donationText = NSAttributedString(string: "  raised", attributes: donationTextAttrs)
        donationAttrString.append(donationText)
        donationTotalLabel.attributedText = donationAttrString
    }

    func updateDonations(donationAmount: CGFloat) {
        currentAmount += donationAmount
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
        
    }
}
