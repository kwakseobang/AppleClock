//
//  Date+Extensions.swift
//  AppleClock
//
//  Created by 곽서방 on 6/30/24.
//

import Foundation
extension Date {
  var formattedTime: String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")  // 설정
    formatter.dateFormat = "a hh:mm"
    return formatter.string(from: self) // 해당 객체가 들어오면 위에 설정으로 맞춘 후 문자열로 변환해서 반환
  }
  
  var formattedDay: String {
    let now = Date()
    let calendar = Calendar.current
    
    let nowStartOfDay = calendar.startOfDay(for: now) //현재시간
    let dateStartOfDay = calendar.startOfDay(for: self) // 객체로 들어온 시간
    let numOfDaysDifference = calendar.dateComponents([.day], from: nowStartOfDay, to: dateStartOfDay).day! //차이
    
    if numOfDaysDifference == 0 {
      return "오늘"
    } else {
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "ko_KR")
      formatter.dateFormat = "M월 d일 E요일"
      return formatter.string(from: self)
    }
  }
  
  var fomattedVoiceRecorderTime: String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy.M.d"
    return formatter.string(from: self)
  }
    
    var formattedSettingTime: String  {
        let date = DateFormatter()
        date.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        date.dateFormat = "HH:mm"
        
        return date.string(from: Date())
    }
}
