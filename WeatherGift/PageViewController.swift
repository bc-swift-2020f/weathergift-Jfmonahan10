//
//  PageViewController.swift
//  WeatherGift
//
//  Created by James Monahan on 10/13/20.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var weatherLocations: [WeatherLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        loadLocations()
        setViewControllers([createLocationDetailViewController(forPage: 0)], direction: .forward, animated: false, completion: nil)
    }
    
    func loadLocations(){
        guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherlocations") as? Data else {
            print("Warning: Could not load weatherlocations data from Userdefaults. This would occur the first time that an app is installed, so if that's the case, ignore this warning.")
            weatherLocations.append(WeatherLocation(name: "Current Location", latitude: 20.20, longitude: 20.20))
            return
        }
        let decoder = JSONDecoder()
        if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as [WeatherLocation]{
            self.weatherLocations = weatherLocations
        } else {
            print("Error: Could not decode data from read from UserDefaults")
        }
        if weatherLocations.isEmpty{
            weatherLocations.append(WeatherLocation(name: "Current Location", latitude: 20.20, longitude: 20.20))
        }
    }
    
    func createLocationDetailViewController(forPage page: Int) -> LocationDetailViewController {
        let detailViewController = storyboard!.instantiateViewController(identifier: "LocationDetailViewController") as! LocationDetailViewController
        detailViewController.locationIndex = page
        return detailViewController
    }

}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? LocationDetailViewController{
            if currentViewController.locationIndex > 0{
                return createLocationDetailViewController(forPage: currentViewController.locationIndex - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? LocationDetailViewController{
            if currentViewController.locationIndex < weatherLocations.count - 1{
                return createLocationDetailViewController(forPage: currentViewController.locationIndex + 1)
            }
        }
        return nil
    }
    
    
}
