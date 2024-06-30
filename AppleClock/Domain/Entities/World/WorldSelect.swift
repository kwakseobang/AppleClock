//
//  WorldSelect.swift
//  AppleClock
//
//  Created by 곽서방 on 6/30/24.
//

import Foundation

struct WorldSelect: Hashable,Codable {
    var section: RegionSection
    var selectedRegion: WorldRegions
    //지역
    struct WorldRegions: Hashable,Codable  {
        var title: String
        var timeZone: TimeZone
    }
    //지역별 섹션 초성 또는 알파벳
    struct RegionSection: Hashable,Codable  {
        var title: String
        var items: [WorldRegions]
    }
    
   
    
}
