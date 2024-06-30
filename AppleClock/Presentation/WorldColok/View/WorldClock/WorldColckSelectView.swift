//
//  WorldColckSelectView.swift
//  AppleClock
//
//  Created by 곽서방 on 6/30/24.
//

import SwiftUI

struct WorldColckSelectView: View {
    var body: some View {
        VStack{
            SearchBar()
            
            Spacer()
            ScrollView {
                
            }
        }
        .navigationBarTitle("도시 선택",displayMode: .inline)
      
    }
}

//MARK: - search bar
private struct SearchBar: View {
    @State var text: String = ""
    fileprivate var body: some View {
        HStack{
            HStack() {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                TextField("검색", text: $text)
                    .font(.system(size: 17, weight: .light, design: .default))
                    .textFieldStyle(.plain)
                
                
            }
            .frame(width: UIScreen.main.bounds.width - 80, height: 25)
            .padding(.all,10)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            
            Button{
                
            }label: {
                Text("취소")
                    .font(.system(size: 20))
                    .foregroundColor(.orange)
            }
        }
    }
}

// MARK: - List
//private struct ListView: View {
//    fileprivate var body: some View {
//        
//    }
//}

#Preview {
    WorldColckSelectView()
}
