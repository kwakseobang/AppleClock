//
//  MainView.swift
//  AppleClock
//
//  Created by 곽서방 on 6/30/24.
//

import SwiftUI
import UIKit

struct MainView: View {
   
    var body: some View {
        TabView {
            WorldClockListView()
                .tabItem {
                        Image(systemName: "globe")
                        Text("세계 시계")
                }
            AlertView()
                .tabItem {
                    Image(systemName: "alarm.fill")
                    Text("알람")
                }
            StopWatchView()
                .tabItem {
                    Image(systemName: "stopwatch.fill")
                    Text("스톱워치")
                }
            TimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("타이머")
                }
        }
        .tint(.orange)
    }
}

#Preview {
    MainView()
}
