//
//  SubwayWidget.swift
//  SubwayWidget
//
//  Created by 최민한 on 2022/12/07.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: ConfigurationIntent())
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), configuration: configuration)
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, configuration: configuration)
      entries.append(entry)
    }
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationIntent
}

struct SubwayWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    Text(entry.date, style: .time)
  }
}

struct SubwayWidget: Widget {
  let kind: String = "SubwayWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      SubwayWidgetEntryView(entry: entry)
    }
    .supportedFamilies([.accessoryCircular])
    .configurationDisplayName("LifeBetter")
    .description("LifeBetter 앱을 실행합니다.")
  }
}

struct SubwayWidget_Previews: PreviewProvider {
  static var previews: some View {
    SubwayWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
