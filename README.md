# swift-adaptive-imageviewer
_An adaptive solution to fit an image within the screen using a UIScrollView and AutoLayout, programatically._

![adaptive-imageviewer](https://i.imgur.com/eI7pQaE.gif)

There are lots of other similar projects on the internet, I did another one, why not?

The way it works is simple, creates an `UIScrollView` programmatically, disables its autoresize, adds necessary constrains to fill the parent view. In the next step, in `viewWillLayoutSubviews` update the scroll views content size, and calculates insets to fit it into the screen and after a short delay calls `setZoomScale` method of scroll view. 

```swift
override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if let image = UIImage(named: "image.jpg") {
        scrollView.contentSize = image.size
        imageView.image = image
        let minZoom = min(self.view.bounds.size.width / image.size.width, self.view.bounds.size.height / image.size.height)
        self.scrollView.minimumZoomScale = minZoom
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vertical = (self.view.bounds.size.height - (image.size.height * minZoom)) / 2
            self.scrollView.contentInset = UIEdgeInsets(top: vertical, left: 0, bottom: vertical, right: 0)
            self.scrollView.setZoomScale(minZoom, animated: true)
        }
    }
}
```
for the rest of the code, read it yourself.
