//
//  SearchProduct.swift
//  SearchProductProject
//
//  Created by Mahika on 23/04/2022.
//

import Foundation
import SwiftUI

struct SearchProduct: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return SearchProductViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
