//
//  SearchProductViewController.swift
//  SearchProductProject
//
//  Created by Mahika on 23/04/2022.
//

import Foundation
import RxSwift
import UIKit

class SearchProductViewController: UIViewController {
    @IBOutlet weak var textfield: UITextField! {
        didSet {
            textfield.delegate = self
        }
    }
    @IBOutlet weak var closeImageView: UIImageView! {
        didSet {
            closeImageView.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCloseTapped))
            closeImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "SearchResultCell", bundle: .main), forCellWithReuseIdentifier: "resultCell")
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var emptyResultView: UIView!
    private let viewModel = SearchProductViewModel()
    private var viewModelInput: SearchProductViewModel.Input!
    private let disposeBag = DisposeBag()
    
    required init() {
        super.init(nibName: SearchProductViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
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
        collectionView.isHidden = true
        shadowView.addBottomShadow()
    }
    
    func setupViewModel() {
        viewModelInput = SearchProductViewModel.Input()
        let output = viewModel.transform(input: viewModelInput)
        
        output.state.drive(onNext: { [weak self] state in
            switch state {
            case .emptyView:
                self?.collectionView.isHidden = true
                self?.closeImageView.isHidden = true
                self?.emptyResultView.isHidden = false
                self?.feedbackLabel.text = "Start typing now to search for products"
                self?.textfield.text = ""
            case .editMode:
                self?.closeImageView.isHidden = false
                self?.emptyResultView.isHidden = true
            default: break
            }
        }).disposed(by: disposeBag)
    }
    
    @objc
    func onCloseTapped(_ sender: UITapGestureRecognizer) {
        viewModelInput.searchTerm.accept("")
    }
}

extension SearchProductViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text as? NSString {
            let updatedString = currentText.replacingCharacters(in: range, with: string as String)
            viewModelInput.searchTerm.accept(updatedString)
        }
        return true;
    }
}

extension SearchProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: view.frame.width, height: 100))
    }
}
