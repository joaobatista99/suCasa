//
//  CarouselPageViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 21/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

protocol CarouselPageViewControllerDelegate: class {

    /**
     Called when the number of pages is updated.

     - parameter tutorialPageViewController: the CarouselPageViewControllerDelegate instance
     - parameter count: the total number of pages.
     */
    func carouselPageViewController(carouselPageViewController: CarouselPageViewController,
        didUpdatePageCount count: Int)

    /**
     Called when the current index is updated.

     - parameter tutorialPageViewController: the CarouselPageViewControllerDelegate instance
     - parameter index: the index of the currently visible page.
     */
    func carouselPageViewController(carouselPageViewController: CarouselPageViewController,
        didUpdatePageIndex index: Int)

}

class CarouselPageViewController: UIPageViewController {

    //items that will be presented by carousel
    fileprivate var items: [UIViewController] = []
    
    //delegate for passing information for customized pagecontrol
    weak var carouselDelegate : CarouselPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        //populate items that will be showed
        populateItems()
        
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        carouselDelegate?.carouselPageViewController(carouselPageViewController: self, didUpdatePageCount: items.count)
    }
    
    fileprivate func populateItems() {
        
        let photoAssets:[UIImage] = [UIImage(named: "casa1")!, UIImage(named: "casa3")!, UIImage(named: "casa2")!]
        
        for i in 0 ..< photoAssets.count {
            let newController = createCarouselItemControler(image: photoAssets[i])
            items.append(newController)
        }
    }
    
    fileprivate func createCarouselItemControler(image: UIImage) -> UIViewController {
        
        let newController = UIViewController()
        newController.view = CarouselItem(image: image)

        return newController
    }
    

}

extension CarouselPageViewController: UIPageViewControllerDataSource {
    
    //func to define item view befored tha actual one
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
        
    }
    
    //func to define item view afet tha actual one
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard items.count != nextIndex else {
            return nil
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
}

extension CarouselPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = items.firstIndex(of: firstViewController) {
                carouselDelegate?.carouselPageViewController(carouselPageViewController: self, didUpdatePageIndex: index)
        }
    }
}

