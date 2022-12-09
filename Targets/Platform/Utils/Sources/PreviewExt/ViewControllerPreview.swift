import UIKit
import SwiftUI

public struct ViewControllerPreview: UIViewControllerRepresentable {
  
  let viewControllerGenerator: () -> UIViewController
  
  init(_ viewControllerGenerator: @escaping () -> UIViewController) {
    self.viewControllerGenerator = viewControllerGenerator
  }
  
  public func makeUIViewController(context: Context) -> some UIViewController {
    return viewControllerGenerator()
  }
  
  public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}
