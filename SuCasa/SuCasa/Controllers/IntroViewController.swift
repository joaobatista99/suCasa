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
    
    //labels
    @IBOutlet weak var aboutOneLabel: UILabel! //Somos a SuCasa
    @IBOutlet weak var tutorialOneLabel: UILabel! //Encontre propostas de aluguel com um valor acessível.
    
    @IBOutlet weak var aboutTwoLabel: UILabel! //Somos a SuCasa
    @IBOutlet weak var tutorialTwoLabel: UILabel! //Compartilhe experiências e viva novas culturas.
    
    @IBOutlet weak var aboutThreeLabel: UILabel! //Somos a SuCasa
    @IBOutlet weak var tutorialThreeLabel: UILabel! //Flexibilidade e segurança para ambas as partes.
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var pageThreeImage: UIImageView!
    @IBOutlet weak var pageTwoImage: UIImageView!
    @IBOutlet weak var pageOneImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializes page control
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.hidesForSinglePage = true
           
        //scroll view delegate
        scrollView.delegate = self
               
        LocalizationIntroVewController()
        
    }
    
    @IBAction func startApp(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "tutorialSeen")
        performSegue(withIdentifier: "startApp", sender: self)
    }
    
    
    fileprivate func LocalizationIntroVewController() {
        self.aboutOneLabel.text = NSLocalizedString("Somos a SuCasa", comment: "")
        self.aboutTwoLabel.text = NSLocalizedString("Somos a SuCasa", comment: "")
        self.aboutThreeLabel.text = NSLocalizedString("Somos a SuCasa", comment: "")
        
        self.tutorialOneLabel.text = NSLocalizedString("Encontre propostas de aluguel com um valor acessível", comment: "")
        self.tutorialTwoLabel.text = NSLocalizedString("Compartilhe experiências e viva novas culturas", comment: "")
        self.tutorialThreeLabel.text = NSLocalizedString("Flexibilidade e segurança para ambas as partes", comment: "")
        
        self.signInButton.setTitle(NSLocalizedString("Entrar", comment: ""), for: .normal)
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
