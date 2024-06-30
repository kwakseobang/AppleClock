//
//  WorldClockViewModel.swift
//  AppleClock
//
//  Created by 곽서방 on 6/30/24.
//

import Foundation

class WorldClockListViewModel: ObservableObject {
    @Published var worldClocks: [WorldClock]
    
    init(worldClocks: [WorldClock] = []) {
        self.worldClocks = worldClocks
    }
    
}

extension WorldClockListViewModel {
    // 추가
    func addClock(_ worldclock: WorldClock) {
        worldClocks.append(worldclock)
    }
    // 삭제
    func removeClock(_ worldclock: WorldClock) {
        if let index = worldClocks.firstIndex(where: {$0.id == worldclock.id}) {
            worldClocks.remove(at: index)
        }
    }
}
