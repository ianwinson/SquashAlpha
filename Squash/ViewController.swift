// Project: Squash
// Course: CS371L

import UIKit

// Initial View Controller: VC that animates logo on LaunchScreen
class ViewController: UIViewController {
    
    // Create an image view to make this VC identical to LaunchScreen
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 414, height: 414))
        imageView.image = UIImage(named: "SquashIconStatic")
        return imageView
    } ()

    // After loading the view add the logo
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    // Executed after viewDidLoad to animate icon
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        // Wait half second then animate
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.animate()
        })
    }
    
    // Animate logo to get larger and disappear
    private func animate() {
        
        // Calculate dimensions of larger logo
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        })
        
        // Make logo fade into LoginVC
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                // Segue from this VC to LoginVC
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    self.performSegue(withIdentifier: "LogoSegueIdentifier", sender: nil)
                })
            }
        })
    }
}
