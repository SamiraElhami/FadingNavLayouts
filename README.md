# H1 FadingNav Layouts on iOS Using Auto Layout

![](fadingNavLayout.gif)

This project is a fork from the [StretchyLayout](https://github.com/TwoLivesLeft/StretchyLayout) repo. 

Just clone the app by the following commands. You'll need Xcode 9 as we're going all-in on iOS 11 for this example.
```
git clone https://github.com/SamiraElhami/FadingNavLayouts.git
cd FadingNavLayouts
```

When the scrollview reach to the top of textview, the header will be brought to the front and likewise.
```
 func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if previousNavBarHidden != shouldHideStatusBar {
            UIView.animate(withDuration: 0.05, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
                //bring navBar to front
                self.view.bringSubview(toFront: self.viewNav)
                self.view.bringSubview(toFront: self.statusBar!)
            })
        } else  if shouldHideStatusBar  == previousNavBarHidden {
            //send navBar to back
            self.view.sendSubview(toBack: self.viewNav)
            self.view.sendSubview(toBack: self.statusBar!)
            
            previousNavBarHidden = shouldHideStatusBar     
        }
        
    }
    
    private var shouldHideStatusBar: Bool {
        let frame = textContainer.convert(textContainer.bounds, to: nil)
        if #available(iOS 11.0, *) {
            return frame.minY < view.safeAreaInsets.top
        } else {
            // Fallback on earlier versions
            return frame.minY < 0
        }
    }
```
