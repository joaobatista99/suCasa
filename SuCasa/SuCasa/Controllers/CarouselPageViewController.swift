//
//  CarouselPageViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 21/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    //variables that are used to populate the carrousel
    var property: Property!
    var placeHolderImage = UIImage(named: "waiting")
    var imageUrl: [URL] = []
    var photo: [UIImage] = []
    //delegate for passing information for customized pagecontrol
    weak var carouselDelegate : CarouselPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        //populate items that will be showed
        
        for i in 0 ..< property.urls.count {
            
            self.imageUrl.append(URL(string: property.urls[i])!)
            
            populateItems(imageUrl: imageUrl[i]) { (photo) in
                
                let newController = self.createCarouselItemControler(image: photo.image!)
                self.items.append(newController)
                
                if self.items.count == self.property.urls.count {
                
                    if let firstViewController = self.items.first {
                        self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
                    }
                }
            }
        }
        self.carouselDelegate?.carouselPageViewController(carouselPageViewController: self, didUpdatePageCount: self.property.urls.count)

    }
    
    fileprivate func populateItems(imageUrl: URL, completionHandler: @escaping(_ photos: UIImageView) -> Void) {
        
        let image = UIImageView()
            
            image.sd_setImage(with: imageUrl,
                              placeholderImage: placeHolderImage,
                              options: SDWebImageOptions.lowPriority,
                              context: nil,
                              progress: nil) { (downloadedImage, error, cacheType, downloadURL) in
                                if let error = error {
                                    print("Error downloading the image: \(error.localizedDescription)")
                                } else {
                                    //print("Successfully downloaded image detail: \(imageUrl)")
                                    completionHandler(image)
                                }
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
    
    
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = items.firstIndex(of: firstViewController) {
                carouselDelegate?.carouselPageViewController(carouselPageViewController: self, didUpdatePageIndex: index)
        }
    }
    
    
}

