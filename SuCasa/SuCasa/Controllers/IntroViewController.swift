//
//  IntroViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 05/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializes page control
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.hidesForSinglePage = true
           
        //scroll view delegate
        scrollView.delegate = self
               
    }
}

extension IntroViewController: UIScrollViewDelegate {
    
    //ScrollView page control
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // calcula o numero da página baseado no quanto o scrollview está deslocado em X
        let page = floor(scrollView.contentOffset.x / self.view.frame.width)
        
        // Para atualizar o current page é necessário converter o float para Int
        pageControl.currentPage = Int(page)
        
     }
}
