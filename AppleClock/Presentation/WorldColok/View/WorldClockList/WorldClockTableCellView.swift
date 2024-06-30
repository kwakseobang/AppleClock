//
//  WorldClockTableCellView.swift
//  AppleClock
//
//  Created by 곽서방 on 6/30/24.
//

import SwiftUI

struct WorldClockTableCellView: View {
    var body: some View {
        VStack(spacing:20){
          
            HStack {
                
                VStack(alignment: .leading,spacing: 5) {

                        Text("오늘,+0시간")
                        .foregroundColor(.gray)
                    
                    Text("지역")
                        .font(.system(size: 30,weight: .light))
                }
                Spacer()
                
                Text("20:20")
                    .font(.system(size: 60,weight: .light))
            }
            
            Divider()
        }
        .padding(.horizontal)
    }
}

#Preview {
    WorldClockTableCellView()
}
