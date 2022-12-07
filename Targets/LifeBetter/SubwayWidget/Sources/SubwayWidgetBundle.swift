//
//  SubwayWidgetBundle.swift
//  SubwayWidget
//
//  Created by 최민한 on 2022/12/07.
//

import WidgetKit
import SwiftUI

@main
struct SubwayWidgetBundle: WidgetBundle {
    var body: some Widget {
        SubwayWidget()
        SubwayWidgetLiveActivity()
    }
}
