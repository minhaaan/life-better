import Foundation
import ActivityKit

public struct SubwayWidgetAttributes: ActivityAttributes {
  var stationName: String
  
  public init(stationName: String) {
    self.stationName = stationName
  }
}

// MARK: ContentState

extension SubwayWidgetAttributes {
  public struct ContentState: Codable, Hashable {
      // Dynamic stateful properties about your activity go here!
    let arrivalData: [Int]
    
    public init(
      arrivalData: [Int]
    ) {
      self.arrivalData = arrivalData
    }
  }
}
