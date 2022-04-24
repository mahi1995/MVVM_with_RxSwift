//
//  SearchProductViewController.swift
//  SearchProductProject
//
//  Created by Mahika on 23/04/2022.
//

import Foundation
import UIKit

class SearchProductViewController: UIViewController {
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    
    required init() {
        super.init(nibName: SearchProductViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textfield.becomeFirstResponder()
    }
    
    func setupView() {
        searchImageView.image = UIImage(named: "searchIcon")?.withRenderingMode(.alwaysTemplate)
        searchImageView.tintColor = .lightBlue
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.grey60.cgColor
        searchButton.layer.cornerRadius = 5
        searchButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        closeImageView.isHidden = true
        shadowView.addBottomShadow()
    }
}
