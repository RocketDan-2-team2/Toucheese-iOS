//
//  FilterProtocol.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import Foundation

protocol FilterProtocol: CaseIterable, Equatable {
    var title: String { get }
    var key: String { get }
}
