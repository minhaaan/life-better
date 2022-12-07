import Foundation
import ActivityKit

public final class SubwayLiveActivityManager {
  
  public typealias State = SubwayWidgetAttributes.ContentState
  
  // MARK: Properties
  
  public static let shared = SubwayLiveActivityManager()
  
  public var activity: Activity<SubwayWidgetAttributes>?
  public var state: State?
  
  // MARK: init
  
  private init() {}
  
  // MARK: Method
  
  public func addSubwayLiveActivity(state: State) {
    // 라이브 액티비티 권한 없으면 추가안함.
    guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }
    
    let arrtibutes = SubwayWidgetAttributes(name: "123")
    self.state = state
    
    do {
      activity = try Activity<SubwayWidgetAttributes>.request(
        attributes: arrtibutes,
        contentState: state,
        pushType: .none
      )
    } catch {
    }
  }
  
  public func removeAllActivities() {
    let activities = Activity<SubwayWidgetAttributes>.activities // 현재 표시중인 액티비티들
    if activities.count < 1 { // 표시중인 액티비티가 있는지 검사.
      return // 액티비티가 없으면 그냥 return
    }
    Task {
      // 액티비티 다 제거
      for activity in activities {
        await activity.end(dismissalPolicy: .immediate)
      }
    }
  }
  
}
