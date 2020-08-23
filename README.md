# CollectionCrashDemo
Demo Repo to show collection view drag and drop crash in iOS 14

THIS DEMO WAS CREATED FOLLOWING THIS TUTORIAL: https://www.youtube.com/watch?v=VrW_6EixIVQ
Its a simple collection view using an array or colors, hold on a cell for a second and drag it around on the screen to re-order.
The code will crash on iOS 14 when dragging cells to another position but will not crash on iOS 13 or below.
I made a custom class for the collection view cell to show that it's laying out its subviews differently than in iOS 13.

Also another note: I found another tutorial that uses a lot of the same functions for dragging and dropping, except it doesn't use a long press gesture recognizer. This code DOES NOT crash on iOS 14 and below, here is the tutorial: https://www.ioscreator.com/tutorials/reorder-collection-view-cells-ios-tutorial
I included his sample project (Which you can also download at the bottom of the tutorial) in the working sample project folder.
