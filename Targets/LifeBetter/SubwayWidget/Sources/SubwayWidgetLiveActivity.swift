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
          arrivalTimerListVStack(context: context)
        }
      }
      .padding(.horizontal, 16)
    } dynamicIsland: { context in
      DynamicIsland {
        // Expanded UI goes here.  Compose the expanded UI through
        // various regions, like leading/trailing/center/bottom
        DynamicIslandExpandedRegion(.leading) {
          VStack {
            Spacer()
            Text(context.attributes.stationName)
            Spacer()
          }
          .dynamicIsland(verticalPlacement: .belowIfTooWide)
        }
        DynamicIslandExpandedRegion(.trailing) {
          VStack {
            Spacer()
            arrivalTimerListVStack(context: context)
          }
            .dynamicIsland(verticalPlacement: .belowIfTooWide)
        }
      } compactLeading: {
        Image(systemName: "tram.fill")
      } compactTrailing: {
        ZStack {}
      } minimal: {
        Image(systemName: "tram.fill")
      }
      .widgetURL(URL(string: "//"))
      .keylineTint(.white)
    }
  }
  
  @ViewBuilder
  func arrivalTimerListVStack(context: ActivityViewContext<SubwayWidgetAttributes>) -> some View {
    VStack {
      Spacer()
      ForEach(context.state.arrivalData, id: \.self) { time in
        HStack {
          Text(Date().addingTimeInterval(TimeInterval(time)), style: .timer)
            .monospacedDigit()
            .frame(width: 60)
          Text("남음")
        }
      }
      Spacer()
    }
  }
}
