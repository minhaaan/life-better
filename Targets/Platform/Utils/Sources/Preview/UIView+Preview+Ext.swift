import UIKit
import SwiftUI

extension UIView {
  public struct Preview: UIViewRepresentable {
    
    let view: UIView
    
    public func makeUIView(context: Context) -> UIView {
      return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
  }
  
  public func showPreview() -> some View {
    Preview(view: self)
  }
}

