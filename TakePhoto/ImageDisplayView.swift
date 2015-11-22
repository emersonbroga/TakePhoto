//
//  ImageDisplayView.swift
//  TakePhoto
//
//  Created by Emerson Carvalho on 11/21/15.
//  Copyright © 2015 Emerson Carvalho. All rights reserved.
//

import UIKit

class ImageDisplayView : UIViewController {
    
    
    private var Images: [UIImage] = []
    
    private var FirstImageView = UIImageView()
    private var SecondImageView = UIImageView()
    private var ThirdImageView = UIImageView()
    private var FourthImageView = UIImageView()
    private var FifthImageView = UIImageView()
    private var CountLabel = UILabel()
    
    private var padding = CGFloat(10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(FirstImageView)
        self.view.addSubview(SecondImageView)
        self.view.addSubview(ThirdImageView)
        self.view.addSubview(FourthImageView)
        self.view.addSubview(FifthImageView)
        self.view.addSubview(CountLabel)
        
        self.view.backgroundColor = UIColor.grayColor()
        
//        @todo: Better variable names on the display methods.

    }
    
    func setPadding(padding : CGFloat){
    
        self.padding = padding
    }
    
    
    func addImage(image: UIImage) {
        
        self.Images.append(image)
        self.display()
        
    }
    
    private func display() {
    
        switch(Images.count) {
        case 0:
            // do nothing
            break;
        case 1:
            displayFirst()
            break
        case 2:
            displaySecond()
            break
        case 3:
            displayThird()
            break
        case 4:
            displayFourth()
            break
        case 5:
            displayFifth()
            break
        default:
            displayMoreThanFive()
            break
            
        }
    }
    
    
    private func displayFirst(){
        
        /*
        ------
           P
        ------
        */
        
        self.defaults()
        let frame = self.view.frame
        let height = frame.size.height - (padding * 2)
        let width = height
        
        let x = (frame.size.width / 2) - (width/2)
        let y = padding
        
        FirstImageView.frame = CGRectMake(x, y, width, height)
        FirstImageView.image = Images[0]
        
    }
    
    private func displaySecond(){
        
        /*
        ---------
          P  P
        ---------
        */
        self.defaults()
        let frame = self.view.frame
        let width = (frame.size.width / 2) - (padding * 1.5)
        let height = width
        
        let x = padding
        let y = padding
        
        FirstImageView.frame = CGRectMake(x, y, width, height)
        FirstImageView.image = Images[1]
        
        SecondImageView.frame = CGRectMake((frame.width / 2) + ( padding / 2), y, width, height)
        SecondImageView.image = Images[0]

    }
    
    
    private func displayThird(){
        
        /*
        ---------
          P  P
             P
        ---------
        */
        self.defaults()
        let frame = self.view.frame
        let width = (frame.size.width / 2) - (padding / 2)
        let height = width
        

        let halfHeight = height / 2 - (padding / 2)
        let halfWidth = width / 2 - (padding / 2)
        
        let x = (padding + (halfWidth / 2))
        let y = padding
        
        FirstImageView.frame = CGRectMake(x, y, width, height)
        FirstImageView.image = Images[2]
        
        
        SecondImageView.frame = CGRectMake((x + width + padding), y, halfWidth, halfHeight)
        SecondImageView.image = Images[1]
        
        ThirdImageView.frame = CGRectMake((x + width + padding), (y + halfHeight + padding), halfWidth, halfHeight)
        ThirdImageView.image = Images[0]
        
    }
    
    private func displayFourth(){
        
        /*
        ---------
          P  P
          P  P
        ---------
        */
        self.defaults()
        let frame = self.view.frame
        let height = (frame.height / 2) - (padding * 1.5)
        let width = height
        
        let x =  (frame.width / 2) - width - (padding * 0.5)
        let y = padding
        
        FirstImageView.frame = CGRectMake(x, y, width, height)
        FirstImageView.image = Images[3]
        
        SecondImageView.frame = CGRectMake((frame.width / 2) + (padding * 0.5) , y, width, height)
        SecondImageView.image = Images[2]
        
        ThirdImageView.frame = CGRectMake(x, ((padding * 2) + height), width, height)
        ThirdImageView.image = Images[1]
        
        FourthImageView.frame = CGRectMake((frame.width / 2) + (padding * 0.5), ((padding * 2) + height), width, height)
        FourthImageView.image = Images[0]
        
    }
    
    private func displayFifth(){
        
        /*
        ---------
        P  P  P
           P  P
        ---------
        */
        self.defaults()
        let frame = self.view.frame
        let height = (frame.height / 2) - (padding * 1.5)
        let width = height
        
        let x = (frame.width/2) - (width * 2) - (padding * 1.5)
        let y = padding
        
        FirstImageView.frame = CGRectMake(x, y, (width * 2) + padding, (height * 2) + padding)
        FirstImageView.image = Images[4]
        
        SecondImageView.frame = CGRectMake((frame.width / 2) + (padding * 0.5), y, width, height)
        SecondImageView.image = Images[3]
        
        ThirdImageView.frame = CGRectMake((frame.width / 2) + width + (padding * 1.5), y, width, height)
        ThirdImageView.image = Images[2]
        
        FourthImageView.frame = CGRectMake((frame.width / 2) + (padding * 0.5), (padding * 2) + height, width, height)
        FourthImageView.image = Images[1]
        
        FifthImageView.frame = CGRectMake((frame.width / 2) + width + (padding * 1.5),  (padding * 2) + height, width, height)
        FifthImageView.image = Images[0]
        
        
        
    }
    
    private func displayMoreThanFive(){
        
        /*
        ---------
        P  P  P
           P  N
        ---------
        */
        self.defaults()
        let frame = self.view.frame
        let height = (frame.height / 2) - (padding * 1.5)
        let width = height
        
        let x = (frame.width/2) - (width * 2) - (padding * 1.5)
        let y = padding
        
        let n = Images.count
        
        FirstImageView.frame = CGRectMake(x, y, (width * 2) + padding, (height * 2) + padding)
        FirstImageView.image = Images[n-1]
        
        SecondImageView.frame = CGRectMake((frame.width / 2) + (padding * 0.5), y, width, height)
        SecondImageView.image = Images[n-2]
        
        ThirdImageView.frame = CGRectMake((frame.width / 2) + width + (padding * 1.5), y, width, height)
        ThirdImageView.image = Images[n-3]
        
        FourthImageView.frame = CGRectMake((frame.width / 2) + (padding * 0.5), (padding * 2) + height, width, height)
        FourthImageView.image = Images[n-4]
        
        FifthImageView.frame = CGRectMake((frame.width / 2) + width + (padding * 1.5),  (padding * 2) + height, width, height)
        FifthImageView.image = Images[n-5]
        
        CountLabel.frame = CGRectMake((frame.width / 2) + width + (padding * 1.5),  (padding * 2) + height, width, height)
        
        CountLabel.text = "+ \(Images.count - 5)"
        
    }
    
    private func defaults() {
        
        FirstImageView.opaque = true
        FirstImageView.frame = CGRectZero
        
        SecondImageView.opaque = true
        SecondImageView.frame = CGRectZero
        
        ThirdImageView.opaque = true
        ThirdImageView.frame = CGRectZero
        
        FourthImageView.opaque = true
        FourthImageView.frame = CGRectZero
        
        FifthImageView.opaque = true
        FifthImageView.frame = CGRectZero
        
        CountLabel.textColor = UIColor.redColor()
        CountLabel.backgroundColor = UIColor.blackColor()
        CountLabel.alpha = 0.5
        CountLabel.textAlignment = .Center
        CountLabel.frame = CGRectZero
    }

}
