//
//  TableViewController.swift
//  JankyTable
//
//  Created by Thomas Vandegriff on 5/28/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var photosDict: [String: String] = [:]
    lazy var photos = NSDictionary(dictionary: photosDict)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let plist = Bundle.main.url(forResource: "PhotosDictionary", withExtension: "plist"),
            let contents = try? Data(contentsOf: plist),
            let serializedPlist = try? PropertyListSerialization.propertyList(from: contents, format: nil),
            let serialUrls = serializedPlist as? [String: String] else {
                print("error with serializedPlist")
                return
        }
        photosDict = serialUrls
        
        print(photosDict)  // "Rome": "https://www.freeimages.com/pic/m/w/wo/wooglin/542791_rome.jpg"
        print(photos) // "Big Fella" = "https://www.freeimages.com/pic/m/n/ng/ngould/325616_big_fella.jpg"
        
    }
    
    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return photosDict.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        // TODO: move this out of cellForRowAt
        let rowKey = photos.allKeys[indexPath.row] as! String
        
        // should be on background thread
        DispatchQueue.global(qos: .background).async {
            guard let imageURL = URL(string:self.photos[rowKey] as! String),
                let imageData = try? Data(contentsOf: imageURL) else {
                    return
            }
            
            let unfilteredImage = UIImage(data:imageData)
            let image = self.applySepiaFilter(unfilteredImage!)

            // Configuring the cell... UI stuff should be pushed back on the main thread
            DispatchQueue.main.async {
                cell.textLabel?.text = rowKey
                if image != nil {
                    cell.imageView?.image = image!
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    // MARK: - image processing
    
    func applySepiaFilter(_ image:UIImage) -> UIImage? {
        let inputImage = CIImage(data:image.pngData()!)
        let context = CIContext(options:nil)
        let filter = CIFilter(name:"CISepiaTone")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter!.setValue(0.8, forKey: "inputIntensity")
        
        guard let outputImage = filter!.outputImage,
            let outImage = context.createCGImage(outputImage, from: outputImage.extent) else {
                return nil
        }
        return UIImage(cgImage: outImage)
    }
}


