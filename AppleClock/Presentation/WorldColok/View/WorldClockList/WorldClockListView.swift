//
//  WorldColokView.swift
//  AppleClock
//
//  Created by 곽서방 on 6/30/24.
//

import SwiftUI
enum RouteType {
    case modal
    case sheet
}

struct WorldClockListView: View {
    @State private var goToSelectWorldClock: Bool = false
    //    @State private var
    var body: some View {
        
        NavigationStack {
            VStack {
                
                WorldClockTableListView()
                Spacer()
            }
            .navigationTitle("세계 시계")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        
                    }label: {
                        Text("편집")
                            .font(.system(size: 20))
                    }
                    .foregroundColor(.orange)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        goToSelectWorldClock = true
                    }label: {
                        Image(systemName: "plus")
                    }
                    .foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $goToSelectWorldClock) {
                //modal로 표시되는 view를 navigationview로 감싸서 navigation bar 사용
                NavigationView{
                    WorldColckSelectView()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}
//MARK: - WorldClockTableListView
private struct WorldClockTableListView: View {
    fileprivate var body: some View {
        Divider()
            .padding(.horizontal)
        WorldClockTableCellView()
    }
}

//M
#Preview {
    WorldClockListView()
}
