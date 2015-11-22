//
//  ViewController.swift
//  TakePhoto
//
//  Created by Emerson Carvalho on 11/21/15.
//  Copyright © 2015 Emerson Carvalho. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var TakePhotoButton = UIButton()
    var UploadFromPhotos = UIButton()
    var ImageView = ImageDisplayView()
    var PickerController = UIImagePickerController()
    var CameraController = UIImagePickerController()
    var SmileButton = UIButton()
    var CancelButton = UIButton()
    
    var isTakePhotoEnabled = false
    var isUploadPhotoEnabled = false
    
    let kTakePhotoButtonTag = 1
    let kUploadFromPhotosTag = 2
    let kSmileButtonTag = 3
    let kCancelButtonTag = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TakePhotoButton.frame = CGRectMake(50, 50, 200, 30)
        TakePhotoButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        TakePhotoButton.setTitle("Take Photo", forState: UIControlState.Normal)
        TakePhotoButton.tag = kTakePhotoButtonTag
        TakePhotoButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        UploadFromPhotos.frame = CGRectMake(50, 100, 200, 30)
        UploadFromPhotos.setTitle("Upload Photo", forState: UIControlState.Normal)
        UploadFromPhotos.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        UploadFromPhotos.tag = kUploadFromPhotosTag
        UploadFromPhotos.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)

        
        ImageView.view.frame = CGRectMake(0, 150, self.view.frame.size.width, 200)
        

        SmileButton.frame = CGRectMake(100, self.view.frame.size.height - 50, self.view.frame.size.width - 100, 50)
        SmileButton.setTitle("Smile =)", forState: UIControlState.Normal)
        SmileButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        SmileButton.tag = kSmileButtonTag
        SmileButton.alpha = 0.8
        SmileButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        SmileButton.hidden = true
        
        CancelButton.frame = CGRectMake(0, self.view.frame.size.height - 50, 100, 50)
        CancelButton.setTitle("=( Cancel", forState: UIControlState.Normal)
        CancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        CancelButton.tag = kCancelButtonTag
        CancelButton.alpha = 0.8
        CancelButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        CancelButton.hidden = true
        
        PickerController.delegate = self
        PickerController.sourceType = UIImagePickerControllerSourceType.Camera
        PickerController.mediaTypes = [kUTTypeImage as String]
        PickerController.allowsEditing = false
        PickerController.showsCameraControls = false

        CameraController.delegate = self
        CameraController.sourceType = UIImagePickerControllerSourceType.Camera
        CameraController.mediaTypes = [kUTTypeImage as String]
        CameraController.allowsEditing = false
        CameraController.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo;
        CameraController.showsCameraControls = false
        CameraController.view.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 250)
        CameraController.view.hidden = true

        self.view.addSubview(TakePhotoButton)
        self.view.addSubview(UploadFromPhotos)
        self.view.addSubview(ImageView.view)
        self.view.addSubview(CameraController.view)
        self.view.addSubview(SmileButton)
        self.view.addSubview(CancelButton)
    }
    
    func buttonClicked(sender: UIButton!) {
        
        switch sender.tag {
        
            case kTakePhotoButtonTag:
                print("Take Photos clicked")
                
                if isTakePhotoEnabled == false {
                    CameraController.view.hidden = false
                    SmileButton.hidden = false
                    CancelButton.hidden = false
                    isTakePhotoEnabled = true
                    
                }
                
                if isUploadPhotoEnabled == true {
                    self.dismissViewControllerAnimated(true, completion: nil)
                    isUploadPhotoEnabled = false
                }
                break
            
            case kUploadFromPhotosTag:
                print("Upload Photos clicked")
                
                if isUploadPhotoEnabled == false {
                    PickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                    self.presentViewController(PickerController, animated: true, completion: nil)
                    isUploadPhotoEnabled = true
                }
                
                if isTakePhotoEnabled == true {
                    CameraController.view.hidden = true
                    SmileButton.hidden = true
                    CancelButton.hidden = true
                    
                    isTakePhotoEnabled = false
                    
                }
                break
            
            case kSmileButtonTag:
                print("Upload Photos clicked")
                
                if isTakePhotoEnabled == true {
                    CameraController.takePicture()
                    SmileButton.setTitle("Loading...", forState: UIControlState.Normal)
                }
                
                break
            case kCancelButtonTag:
                print("Cancel Button clicked")
                
                if isTakePhotoEnabled == true {
                    CameraController.view.hidden = true
                    SmileButton.hidden = true
                    CancelButton.hidden = true
                    
                    isTakePhotoEnabled = false
                    
                }
                
                break
            default:
                print("Which button is this?")
                break
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("didFinishPickingMediaWithInfo", picker.sourceType)
        
        let _image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
        
        
        if picker.sourceType == UIImagePickerControllerSourceType.Camera {
        
            let image = imageByCroppingImage(_image, _size: CGSize(width: 600,height: 800))

            ImageView.addImage(image)
        
            SmileButton.setTitle("Smile =)", forState: UIControlState.Normal)
            
        }else if picker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary {
        
            self.dismissViewControllerAnimated(true, completion: nil)
            isUploadPhotoEnabled = false

            ImageView.addImage(_image)
            
        }
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("CANCEL \(picker.sourceType.rawValue)")
        
        if picker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func imageByCroppingImage(image : UIImage, _size : CGSize) -> UIImage {

        //@ref: http://stackoverflow.com/questions/158914/cropping-an-uiimage
        
        
        // step 1: Scale from the original size to a smaller size.
        let newHeight = CGFloat(800.0)
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print("WIDTH: \(image.size.width) HEIGHT: \(image.size.width) NEWWIDTH: \(newWidth) NEWHEIGHT: \(newHeight)")
        
        // step 3: crop obttom
        return croppIngimage(scaledImage, toRect:  CGRectMake(0, 0, newWidth, newHeight / 2 ))
    }

    
    func croppIngimage(imageToCrop:UIImage, toRect rect:CGRect) -> UIImage{
        
        let imageRef:CGImageRef = CGImageCreateWithImageInRect(imageToCrop.CGImage, rect)!
        let cropped:UIImage = UIImage(CGImage:imageRef)
        return cropped
    }

}

