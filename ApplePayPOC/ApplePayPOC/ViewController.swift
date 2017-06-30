//
//  ViewController.swift
//  ApplePayPOC
//
//  Created by Lesly Sandoval on 6/20/17.
//  Copyright © 2017 LeslySandoval. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController { //, PKPaymentAuthorizationViewControllerDelegate {

    @IBOutlet weak var applePayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if !isApplePaySupported() && !isAnyCardConfigured() {
            applePayButton.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /** 
     Determines if apple pay is supported by device hardware and parental control
     */
    private func isApplePaySupported() -> Bool{
        return PKPaymentAuthorizationViewController.canMakePayments()
    }
    
    /**
     Determines if a payment can be made with apple pay.
     In otherwords, returns if a card is registered in Apple Pay
     */
    private func isAnyCardConfigured() -> Bool {
        return PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [PKPaymentNetwork.amex, PKPaymentNetwork.discover, PKPaymentNetwork.visa, PKPaymentNetwork.masterCard])
    }

    /**
     send payment request to Apple Pay
     */
    @IBAction func didSelectBuyWithApplePay(_ sender: Any) {
        let paymentRequest = createPaymentRequest()
        
        if let paymentSheet = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) as PKPaymentAuthorizationViewController? {
//            paymentSheet.delegate = self
            present(paymentSheet, animated: true, completion: nil)
        } else {
            print("Error: Payment request is invalid.")
        }
        
    }
    
    /**
     Create Payment request by defining the required display data
     */
    private func createPaymentRequest() -> PKPaymentRequest {
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = "xzy";
        paymentRequest.supportedNetworks = [PKPaymentNetwork.amex, PKPaymentNetwork.visa, PKPaymentNetwork.masterCard];
        paymentRequest.merchantCapabilities = PKMerchantCapability.capability3DS;
        paymentRequest.countryCode = "US";
        paymentRequest.currencyCode = "USD";
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "McDonald's", amount: NSDecimalNumber(string: "10.00"))
        ]
        return paymentRequest
    }
    
//    func paymentAuthorizationViewControllerWillAuthorizePayment(_ controller: PKPaymentAuthorizationViewController) {
//        
//    }
    
//    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect paymentMethod: PKPaymentMethod, completion: @escaping ([PKPaymentSummaryItem]) -> Void) {
//        completion([])
//    }
    
//    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler: @escaping (PKPaymentAuthorizationResult) -> Void) {
//        
//    }
//    
//    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
//        
//    }
    
}

