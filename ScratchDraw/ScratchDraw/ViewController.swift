//
//  ViewController.swift
//  ScratchDraw
//
//  Created by James Williams on 5/14/15.
//  Copyright (c) 2015 James Williams. All rights reserved.
//

import UIKit

var fillColors: [UIColor] = [
    UIColor.blackColor(),
    UIColor.cyanColor(),
    UIColor.yellowColor(),
    UIColor.magentaColor(),
    UIColor.whiteColor(),
    UIColor.blueColor(),
    UIColor.orangeColor(),
    UIColor.brownColor()
]



class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var viewBottomContraint: NSLayoutConstraint!
    
    @IBOutlet weak var fillColorCollectionView: UICollectionView!
    
    
    @IBAction func clearScratches(sender: AnyObject) {
        scratchPad.scratches = []
        scratchPad.setNeedsDisplay()
        
    }
    
    @IBOutlet weak var scratchPad:
    ScratchView!
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return fillColors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("colorCell", forIndexPath: indexPath) as! ColorCell
    
        cell.backgroundColor = fillColors[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ColorCell
        
        if let color = cell.backgroundColor {
        
        scratchPad.currentColor = color
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillColorCollectionView.dataSource = self
        fillColorCollectionView.delegate = self
        
        viewBottomContraint.constant = -300
        
        //view.addSubview(scratchPad)
        //scratchPad.frame = view.frame
        //scratchPad.backgroundColor = UIColor.whiteColor()
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let touch = touches.first as? UITouch {
            
            let location = touch.locationInView(scratchPad)
            
            scratchPad.newScratchWithStartPoint(location)
        }
        
        
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let location = touch.locationInView(scratchPad)
            scratchPad.updateCurrentScratchLastPoint(location)
            
            
            //scratchPad.addPointToCurrentScratch(location)
        }
        
    }
    
    @IBAction func changeColor(sender: UIButton) {
        
            }
    
    @IBAction func showHide(sender: AnyObject) {
        
        viewBottomContraint.constant = (viewBottomContraint.constant == 0) ? -300 : 0
        UIView.animateWithDuration(0.4, animations: { () -> Void in
    
        })

    
    
    }




}
