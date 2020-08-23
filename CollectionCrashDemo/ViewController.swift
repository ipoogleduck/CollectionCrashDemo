//
//  ViewController.swift
//  CollectionCrashDemo
//
//READ ME:
//THIS DEMO WAS CREATED FOLLOWING THIS TUTORIAL: https://www.youtube.com/watch?v=VrW_6EixIVQ
//Its a simple collection view using an array or colors, hold on a cell for a second and drag it around on the screen to re-order
//The code will crash on iOS 14 when dragging cells to another position but will not crash on iOS 13 or below
//I made a custom class for the collection view cell to show that it's laying out its subviews differently than in iOS 13
//
//Also another note: I found another tutorial that uses a lot of the same functions for dragging and dropping, except it doesn't use a long press gesture recognizer. This code works on iOS 14 and below, here is the tutorial: https://www.ioscreator.com/tutorials/reorder-collection-view-cells-ios-tutorial
//I included his sample project (Which you can also download at the bottom of the tutorial) in the working sample project folder.
//
//
//If I end up needing to change something in my code please get back to me! Thanks!

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var colors: [UIColor] = [.systemTeal, .systemGreen, .systemBlue, .red, .orange, .black, .systemPurple, .systemYellow, .systemPink]

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        collectionView.addGestureRecognizer(gesture)
    }
    
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        guard let collectionView = collectionView else { return }
        
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView)) //CODE CRASHES HERE
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! demoCell
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = collectionView.frame.size.width/3.2

        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = colors.remove(at: sourceIndexPath.row)
        colors.insert(item, at: destinationIndexPath.row)
    }
}

var layoutNumber = 0

class demoCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        print("Layout: \(layoutNumber)") //NOTICE HERE: On iOS 14 cell lays out subviews whenever you move your finger but on iOS 13 it only lays out when you end dragging. This will just print the number of times it's been layed out
        layoutNumber += 1
    }
    
}
