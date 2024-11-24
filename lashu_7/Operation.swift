//
//  Operation.swift
//  lashu_7
//
//  Created by Lasha Tavberidze on 23.11.24.
//

import Foundation

enum Operation: Int{
    case add = 0
    case subtract
    case divide
    case multiply
    func perform(_ a: Double, _ b: Double) -> Double{
        switch self {
        case .add: return a + b
        case .subtract: return a - b
        case .multiply: return a * b
        case .divide: return a / b
        }
    }
}
