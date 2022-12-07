//
//  SubwayWidgetLiveActivity.swift
//  SubwayWidget
//
//  Created by 최민한 on 2022/12/07.
//

import ActivityKit
import WidgetKit
import SwiftUI
import SubwayWidgetCore
import Foundation

struct SubwayWidgetLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: SubwayWidgetAttributes.self) { context in
      // Lock screen/banner UI goes here
      HStack {
        Text(context.attributes.stationName)
        Spacer()
        VStack(alignment: .trailing) {
          ForEach(context.state.arrivalData, id: \.self) { time in
            HStack {
              Text(Date().addingTimeInterval(TimeInterval(time)), style: .timer)
                .monospacedDigit()
                .frame(width: 40)
              Text("남음")
            }
          }
        }
      }
      .padding(.horizontal, 16)
    } dynamicIsland: { context in
      DynamicIsland {
        // Expanded UI goes here.  Compose the expanded UI through
        // various regions, like leading/trailing/center/bottom
        DynamicIslandExpandedRegion(.leading) {
          Text("Leading")
        }
        DynamicIslandExpandedRegion(.trailing) {
          Text("Trailing")
        }
        DynamicIslandExpandedRegion(.bottom) {
          Text("Bottom")
          // more content
        }
      } compactLeading: {
        Text("L")
      } compactTrailing: {
        Text("T")
      } minimal: {
        Text("Min")
      }
      .widgetURL(URL(string: "//"))
    }
  }
}
