//
//  DonationViewController.swift
//  TestAppProto
//
//  Created by Daniel Pitts on 10/3/21.
//

import UIKit

protocol DonationViewControllerDelegate {
    func updateDonations(donationAmount: CGFloat)
}

class DonationViewController: UIViewController {
    var delegate: DonationViewControllerDelegate?
    
    @IBOutlet weak var donationFormTitleLabel: UILabel!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var donationAmountField: UITextField!
    @IBOutlet weak var donationButton: UIButton!
    @IBAction func donationButtonTapped(_ sender: Any) {
        guard Double(donationAmountField.text ?? "0") ?? 0 > 0 else { return }
        print(firstNameField.text ?? "", lastNameField.text ?? "", donationAmountField.text ?? "")
        delegate?.updateDonations(donationAmount: CGFloat(Double(donationAmountField.text ?? "0") ?? 0))
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomFonts()
        
        firstNameField.textContentType = .givenName
        lastNameField.textContentType = .familyName
        donationAmountField.keyboardType = .decimalPad
    }
    
    func setCustomFonts() {
        let buttonFont = UIFont(name: "Avenir-Heavy", size: 18)!
        let customButtonFont = UIFontMetrics(forTextStyle: .headline).scaledFont(for: buttonFont)
        let attributedTitle = NSAttributedString(string: "Donate Now!", attributes: [.font: customButtonFont])
        donationButton.setAttributedTitle(attributedTitle, for: .normal)
        donationButton.backgroundColor = UIColor(named: "AccentColor") ?? .systemPurple
        donationButton.layer.cornerRadius = 8
        donationButton.titleLabel?.adjustsFontForContentSizeCategory = true
        donationButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let bodyFont = UIFont(name: "Avenir", size: UIFont.systemFontSize)!
        let customBodyFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: bodyFont)
        
        let attributedFirstNamePlaceholder = NSAttributedString(string: "First Name", attributes: [.font: customBodyFont])
        firstNameField.attributedPlaceholder = attributedFirstNamePlaceholder
        firstNameField.font = customBodyFont
        
        let attributedLastNamePlaceholder = NSAttributedString(string: "Last Name", attributes: [.font: customBodyFont])
        lastNameField.attributedPlaceholder = attributedLastNamePlaceholder
        lastNameField.font = customBodyFont
        
        let attributedDonationAmountPlaceholder = NSAttributedString(string: "$0.00", attributes: [.font: customBodyFont])
        donationAmountField.attributedPlaceholder = attributedDonationAmountPlaceholder
        donationAmountField.font = customBodyFont
        
        let headlineFont = UIFont(name: "Avenir-Heavy", size: 18)!
        let customHeadlineFont = UIFontMetrics(forTextStyle: .headline).scaledFont(for: headlineFont)
        donationFormTitleLabel.font = customHeadlineFont
        donationFormTitleLabel.adjustsFontForContentSizeCategory = true
        donationFormTitleLabel.adjustsFontSizeToFitWidth = true
    }

    

}
