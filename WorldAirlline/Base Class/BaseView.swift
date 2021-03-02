//
//  BaseView.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//

import UIKit

class BaseView: UIViewController {

    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func startActivityIndicatory(uiView: UIView) {
        uiView.isUserInteractionEnabled = false
        let loadingView: UIView = UIView()
        loadingView.frame =  CGRect(x: 0, y: 0, width: 80.0, height: 80.0)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 0.8)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 15
        actInd.frame = CGRect(x: 0, y: 0, width: 40.0, height: 40.0)
        if #available(iOS 13.0, *) {
            actInd.style = UIActivityIndicatorView.Style.large
        } else {
            actInd.style = UIActivityIndicatorView.Style.whiteLarge
        }
        actInd.color = .white
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        self.view.addSubview(loadingView)
        actInd.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.view.isUserInteractionEnabled = true
        actInd.stopAnimating()
        let view = actInd.superview
        view?.removeFromSuperview()
    }
    
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            var items = [UIBarButtonItem]()
            if previousNextable {
                let imgDown : UIImage = UIImage()
                let previousButton = UIBarButtonItem(image: imgDown, style: .plain, target: nil, action: nil)
                previousButton.width = 30
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                let imgUp : UIImage = UIImage()
                let nextButton = UIBarButtonItem(image: imgUp, style: .plain, target: nil, action: nil)
                nextButton.width = 30
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                items.append(contentsOf: [previousButton, nextButton])
            }
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let label = UILabel(frame: CGRect.zero)
            label.text = ""//textField.placeholder
            let toolbarTitle = UIBarButtonItem(customView: label)
            items.append(contentsOf: [spacer, toolbarTitle])
            let spacer1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem:.done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer1, doneButton])
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
}
