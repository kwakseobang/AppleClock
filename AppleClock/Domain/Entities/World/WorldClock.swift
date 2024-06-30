//
//  WorldClock.swift
//  AppleClock
//
//  Created by 곽서방 on 6/30/24.
//

import Foundation

struct WorldClock: Hashable{
    var region: String
    var date: Date
    var id = UUID()
//    var convertedDayAndTime: String {
//        //오늘 - 오후 3:00에 알림
//        return String("\(day.formattedDay) - \(time.formattedTime)에 알림") //Extensions으로 정의 해놓은 것들 사용
//    }
    
}
