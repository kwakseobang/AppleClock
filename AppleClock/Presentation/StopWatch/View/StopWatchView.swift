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
                .frame(height: 150)
            StopWatchOperationView(stopWatchViewModel: stopWatchViewModel)
            Spacer()
                .frame(height: 100)
            StopWatchBtnView(stopWatchViewModel: stopWatchViewModel)
                .padding(.bottom)
            
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.gray)
                .opacity(0.6)
            
            LaptimeCellListView(stopWatchViewModel: stopWatchViewModel)
            Spacer()
            
        }
        .padding()
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
                stopWatchViewModel.initOrRecordBtnTapped()
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
            }
            .disabled(stopWatchViewModel.mode == .isStop)
            Spacer()
            // 타이머 시작 및 일시정지
            Button {
                if stopWatchViewModel.mode == .isStop {
                    stopWatchViewModel.startBtnTapped()
                } else {
                    stopWatchViewModel.pauseOrRestartBtnTapped()
                }
            }label: {
                Text(stopWatchViewModel.mode != .isAction  ? "시작" : "중단" )
                    .font(.system(size: 18))
                    .foregroundColor(
                        stopWatchViewModel.mode != .isAction ? .green : .red)
                    .frame(width: 88, height: 88)
                    .background(
                        Circle()
                            .fill(
                                stopWatchViewModel.mode != .isAction ?
                                Color.green.opacity(0.2): Color.red.opacity(0.2)
                            ) // opacity 투명도
                    )
            }
            
        }
        
    }
}
//MARK: - lap time cell List view
private struct LaptimeCellListView: View {
    @ObservedObject var stopWatchViewModel: StopWatchViewModel
    
    fileprivate init(stopWatchViewModel: StopWatchViewModel) {
        self.stopWatchViewModel = stopWatchViewModel
    }
    fileprivate var body: some View {
        ScrollView{
            if stopWatchViewModel.mode != .isStop {
                LaptimeCellView(time: stopWatchViewModel.formatTime(seconds:stopWatchViewModel.laptimeElapsed ) ,index: stopWatchViewModel.laptimesCount)
            }
            
            ForEach(stopWatchViewModel.laptimes.indices.reversed(), id: \.self) { index in
                LaptimeCellView(
                    time: stopWatchViewModel.laptimes[index],
                    index: index,
                    maxIndex: stopWatchViewModel.maxLapTimeIndex,
                    minIndex: stopWatchViewModel.minLapTimeIndex
                )
                
            }
            
        }
    }
}
//MARK: - lap time cell view
private struct LaptimeCellView: View {
    private var time: String
    private var index: Int
    private var maxIndex: Int?
    private var minIndex: Int?
    fileprivate init(time: String,
                     index:Int,
                     maxIndex: Int? = nil,
                     minIndex:Int? = nil
    ) {
        self.time = time
        self.index = index
        self.maxIndex = maxIndex
        self.minIndex = minIndex
    }
    
    fileprivate var body: some View {
        HStack {
            Text("랩 \(index + 1)")
                .font(.system(size: 18))
            
            Spacer()
            Text(time)
                .font(.system(size: 18,weight: .light,design: .monospaced))
            
        }
        
        .foregroundColor(
            
            maxIndex == index ? .red : minIndex == index ? .green : .white
        )
        .padding(.vertical,7)
        
        Rectangle()
            .frame(height: 0.5)
            .foregroundColor(.gray)
            .opacity(0.4)
        
    }
}
#Preview {
    StopWatchView()
}
