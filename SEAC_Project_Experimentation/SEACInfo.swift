//
//  SEACInfo.swift
//  SEAC_Project_Experimentation
//
//  Created by Student on 7/15/19.
//  Copyright © 2019 SEAC_Organization. All rights reserved.
//

import UIKit

private(set) var pageViews: [UIViewController] = {
    return [newViewController(number: "1"), newViewController(number: "2")]
}()

private func newViewController(number: String) -> UIViewController {
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page \(number)")
}

class SEACInfo: UIPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstPage = pageViews.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension SEACInfo: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = pageViews.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousPage = pageIndex - 1
        
        guard previousPage >= 0 else {
            return pageViews.last
        }
        
        guard pageViews.count > previousPage else {
            return nil
        }
        
        return pageViews[previousPage]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = pageViews.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextPage = pageIndex + 1
        let numPages = pageViews.count
        
        guard numPages != nextPage else {
            return pageViews.first
        }
        
        guard numPages > nextPage else {
            return nil
        }
        
        return pageViews[nextPage]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViews.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstPage = viewControllers?.first,
            let firstIndex = pageViews.firstIndex(of: firstPage) else {
                return 0
        }
        
        return firstIndex
    }
}
