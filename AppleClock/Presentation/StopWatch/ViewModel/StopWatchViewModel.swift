//
//  StopWatchViewModel.swift
//  AppleClock
//
//  Created by 곽서방 on 7/1/24.
//
//의문
import Foundation
import UIKit
import Combine
import SwiftUI

enum mode {
    case isAction
    case isPaused
    case isStop
    
}
class StopWatchViewModel: ObservableObject {
    @Published var mode: mode = .isStop
    @Published var stopWatch: StopWatch = .init(millisecondElapsed: 0.00,lapElapsed: 0.00, lapTimes: [])
    @Published var isEmptylaptimes: Bool = true
    
    private var cancellable: AnyCancellable?
    private var maxIndex: Int?
    private var minIndex: Int?
    private var maxlaptimeElapsed: Double = -999
    private var minlaptimeElapsed: Double = 999
    
    var secondsElapsed: Double {
        stopWatch.millisecondElapsed
    }
    
    var laptimeElapsed: Double {
        stopWatch.lapElapsed
    }
    var laptimes: [String] {
        stopWatch.lapTimes
    }
    var laptimesCount: Int {
        stopWatch.lapTimes.count
    }
    
    var maxLapTime: Double? {
        maxlaptimeElapsed
    }
    
    var minLapTime: Double? {
        minlaptimeElapsed
    }
    
    var maxLapTimeIndex: Int? {
        maxIndex
    }
    
    var minLapTimeIndex: Int? {
        minIndex
    }
    
    
}
extension StopWatchViewModel {
    // 시작 버튼
    func startBtnTapped() {
        self.isEmptylaptimes = false
        // start
        self.start()
        mode = .isAction
        
    }
    
    //재시작 및  일시정지
    func pauseOrRestartBtnTapped() {
        // if 재시작 else 일시정지
        if mode == .isPaused {
            self.start()
            self.mode = .isAction
        } else {
            self.stop()
            self.mode = .isPaused
        }
    }
    
    //초기화 및 랩타임
    func initOrRecordBtnTapped() {
        if mode == .isPaused {
            self.stop()
            self.mode = .isStop
            self.reset()
            
        } else {
            self.lap()
            self.stopWatch.lapElapsed = 0.0
        }
    }
    // timeToString
    func formatTime(seconds: Double) -> String {
        let totalSeconds = Int(seconds)
        let minutes = totalSeconds / 60
        let remainingSeconds = totalSeconds % 60
        let milliseconds = Int((seconds - Double(totalSeconds)) * 100)
        
        return String(format: "%02d:%02d.%02d", minutes, remainingSeconds, milliseconds)
    }
}

//내부에서만 사용 예정
private extension StopWatchViewModel {
    //시작
    func start() {
        guard cancellable == nil else {return} //nil이어야 설정
        
        // TODO: - 세분화 및 수정 예정
        //        var backgroundTaskID: UIBackgroundTaskIdentifier? //백그라운드 작업 아이디를 저장할 변수 초기값 nil
        //        //앱이 백그라운드로 전환되었을 때 일부 작업을 계속 수행할수있게 해주는 코드
        //        //UIBackgroundTaskIdentifier 값을 반환하며 이 값은 나중에 백그라운드 작업을 종료시키는데 사용된다.
        //        backgroundTaskID = UIApplication.shared.beginBackgroundTask {
        //            if let task = backgroundTaskID {
        //                //ID가 없으면 백그라운드 작업 종료
        //                UIApplication.shared.endBackgroundTask(task)
        //                backgroundTaskID = .invalid
        //            }
        //        }
        
        // 경과 부분
        cancellable = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                self.stopWatch.millisecondElapsed += 0.01
                self.stopWatch.lapElapsed += 0.01
                
            })
    }
    
    // stop
    func stop() {
        cancellable?.cancel()
        cancellable = nil
    }
    // laptime
    func lap() {
        stopWatch.lapTimes.append(self.formatTime(seconds: laptimeElapsed))
       
        maxOrminIndex()
        if laptimesCount == 2 {
            if maxIndex == nil {
                maxIndex = 0
            } else {
                minIndex = 0
            }
        }
        
    }
    // maxIndexandminIndexFind //하드 코딩 같음. 고쳐야댐
    //1개일때는 값만 넣고
    func maxOrminIndex() {
      
        laptimeElapsedCompare()
        print("maxTime:",maxlaptimeElapsed)
        print("maxIndex:",maxIndex ?? "notIndex")
        print("minTime:",minlaptimeElapsed)
        print("minIndex:",minIndex ?? "notIndex")
      
    }
    
    // laptimeElapsedCompare
    func laptimeElapsedCompare() {
        if (laptimeElapsed > maxlaptimeElapsed) {
            maxlaptimeElapsed = laptimeElapsed
            if laptimesCount > 1 {
                maxIndex = stopWatch.lapTimes.count - 1
            }
        }
        // max = 1 maxlap = laptimeElapsed, min = nil, minlap = 999
        if laptimeElapsed < minlaptimeElapsed{
            minlaptimeElapsed = laptimeElapsed
            if laptimesCount > 1 {
                minIndex = stopWatch.lapTimes.count - 1
            }
        }
        
    }
    
    
    //reset
    func reset() {
        self.stopWatch.millisecondElapsed = 0.00
        self.stopWatch.lapElapsed = 0.00
        maxIndex = nil
        minIndex = nil
        maxlaptimeElapsed = -999
        minlaptimeElapsed = 999
        self.stopWatch.lapTimes.removeAll()
        self.isEmptylaptimes = true
        
    }
    
}
