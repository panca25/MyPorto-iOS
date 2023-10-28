//
//  Models.swift
//  MyPorto
//
//  Created by Panca Setiawan on 28/10/23.
//

import Foundation

struct DataChartResponse: Codable {
    let type: String
    let data: ChartData
    
    enum ChartData: Codable {
        case donutChart([DonutDataItem])
        case lineChart(LineData)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode([DonutDataItem].self) {
                self = .donutChart(x)
                return
            }
            if let x = try? container.decode(LineData.self) {
                self = .lineChart(x)
                return
            }
            throw DecodingError.typeMismatch(ChartData.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Tidak ada tipe ChartData"))
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .donutChart(let x):
                try container.encode(x)
            case .lineChart(let x):
                try container.encode(x)
            }
        }
    }
}

struct DonutDataItem: Codable {
    let label: String
    let percentage: String
    let data: [Transaction]
}

struct Transaction: Codable {
    let trx_date: String
    let nominal: Double
}

struct LineData: Codable {
    let month: [Int]
}
