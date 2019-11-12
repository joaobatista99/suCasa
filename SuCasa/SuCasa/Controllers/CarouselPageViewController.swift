//
//  CarouselPageViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 11/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class CarouselPageViewController: UIPageViewController {

    private var items: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        decoratePageControl()
        
        populateItems()
        
        if let firstViewController = items.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    
    private func populateItems() {
        
        let houseImages = [ UIImage(named:"standarddinning20190905-41"), UIImage(named: "standarddinning20190905-128") ]
        
        for (t) in houseImages {
            let c = createCarouselItemControler(with: t!)
            items.append(c)
        }
    }

    
    private func createCarouselItemControler(with image: UIImage) -> UIViewController {
        let c = UIViewController()
        c.view = HousePhotoItem(image: image)
        return c
    }
    
    private func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselPageViewController.self])
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = .gray
    }
   

}

extension CarouselPageViewController :  UIPageViewControllerDataSource {
    
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    
}
