//
//  StopWatchView.swift
//  AppleClock
//
//  Created by 곽서방 on 6/30/24.
//

import SwiftUI
import Combine
struct StopWatchView: View {
    @StateObject var stopWatchViewModel: StopWatchViewModel = StopWatchViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            StopWatchOperationView(stopWatchViewModel: stopWatchViewModel)
            Spacer()
                .frame(height: 100)
            StopWatchBtnView(stopWatchViewModel: stopWatchViewModel)
                .padding(.bottom)
            Divider()
                
            Spacer()
        }
    }
    
}

//MARK: - stopWatch 작동 뷰
private struct StopWatchOperationView: View {
    @ObservedObject var stopWatchViewModel: StopWatchViewModel
    
    fileprivate init(stopWatchViewModel: StopWatchViewModel) {
        self.stopWatchViewModel = stopWatchViewModel
    }
    
    fileprivate var body: some View {
        ZStack{
            // 타이머 값을 표시하는 레이블
            Text(stopWatchViewModel.formatTime(seconds: stopWatchViewModel.secondsElapsed))
                .font(.system(size: 70,weight: .light,design: .monospaced))
                .monospacedDigit() //글자 간에 고정된 폭을 가질 때 사용한다.
            
            
            
        }
    }
}


//MARK: - stopWatch Btn view
private struct StopWatchBtnView: View {
    @ObservedObject var stopWatchViewModel: StopWatchViewModel
    
    fileprivate init(stopWatchViewModel: StopWatchViewModel) {
        self.stopWatchViewModel = stopWatchViewModel
    }
    
    fileprivate var body: some View {
        
        HStack {
            // 타이머 랩 타임 및 리셋
            Button {
                if stopWatchViewModel.mode == .isPaused {
                    stopWatchViewModel.initOrRecordBtnTapped()
                }
            }label: {
                Text(stopWatchViewModel.mode == .isPaused ? "재설정" : "랩")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 88, height: 88)
                    .background(
                        Circle()
                            .fill(Color.gray.opacity(
                                stopWatchViewModel.mode == .isStop ?  0.2 : 0.4)
                            ) // opacity 투명도
                        
                    )
                    .disabled(stopWatchViewModel.mode == .isStop)
            }
            Spacer()
            // 타이머 시작 및 일시정지
            Button {
                if stopWatchViewModel.mode == .isStop {
                    stopWatchViewModel.startBtnTapped()
                } else {
                    stopWatchViewModel.pauseOrRestartBtnTapped()
                }
            }label: {
                Text(stopWatchViewModel.mode == .isStop ? "시작" : "중단" )
                    .font(.system(size: 18))
                    .foregroundColor(
                        stopWatchViewModel.mode == .isStop ? .green : .red)
                    .frame(width: 88, height: 88)
                    .background(
                        Circle()
                            .fill(
                                stopWatchViewModel.mode == .isStop ?
                                Color.green.opacity(0.2): Color.red.opacity(0.2)
                            ) // opacity 투명도
                    )
            }
        }
        .padding(.horizontal)
    }
}
#Preview {
    StopWatchView()
}
