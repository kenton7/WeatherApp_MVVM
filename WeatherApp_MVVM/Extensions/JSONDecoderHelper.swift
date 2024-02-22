//
//  JSONDecoderHelper.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 22.02.2024.
//

import Foundation

final class JSONDecoderHelper {
    static func getDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
}
