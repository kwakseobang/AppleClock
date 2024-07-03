//
//  StopWatchViewModel.swift
//  AppleClock
//
//  Created by 곽서방 on 7/1/24.
//

import Foundation
import UIKit
import Combine

enum mode : String {
    case isAction = "중단" // 버튼 텍스트 표시를 위해
    case isPaused = "시작"
    case isStop = "재설정"

}
class StopWatchViewModel: ObservableObject {
    @Published var mode: mode = .isStop
    @Published var stopWatch: StopWatch = .init(millisecondElapsed: 0.00)
    @Published var secondsElapsed: Double = 0.00
    private var cancellable: AnyCancellable?
}

extension StopWatchViewModel {
    // 시작 버튼
    func startBtnTapped() {
        self.secondsElapsed = stopWatch.millisecondElapsed
        // start
        self.start()
        
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
            self.secondsElapsed = 0.00
        }
    }
    // 시간 포매
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
        
       // TODO: - 세분화 예정
        var backgroundTaskID: UIBackgroundTaskIdentifier? //백그라운드 작업 아이디를 저장할 변수 초기값 nil
        //앱이 백그라운드로 전환되었을 때 일부 작업을 계속 수행할수있게 해주는 코드
        //UIBackgroundTaskIdentifier 값을 반환하며 이 값은 나중에 백그라운드 작업을 종료시키는데 사용된다.
        backgroundTaskID = UIApplication.shared.beginBackgroundTask {
            if let task = backgroundTaskID {
                //ID가 없으면 백그라운드 작업 종료
                UIApplication.shared.endBackgroundTask(task)
                backgroundTaskID = .invalid
            }
        }
        mode = .isAction
        // 경과 부분
        cancellable = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                self.secondsElapsed += 0.01
            })
    }
    
    // stop
    func stop() {
        cancellable?.cancel()
        cancellable = nil
    }
    
}
