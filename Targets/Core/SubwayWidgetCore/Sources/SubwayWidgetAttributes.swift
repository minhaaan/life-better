import Foundation
import ActivityKit

public struct SubwayWidgetAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
      // Dynamic stateful properties about your activity go here!
      var value: Int
  }

  // Fixed non-changing properties about your activity go here!
  var name: String
}
