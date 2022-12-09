import UIKit
import SwiftUI

extension UIViewController {
  public struct Preview: UIViewControllerRepresentable {
    
    let viewController: UIViewController
    
    public func makeUIViewController(context: Context) -> UIViewController {
      return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
  }
  
  public func showPreview() -> some View {
    Preview(viewController: self)
  }
}
