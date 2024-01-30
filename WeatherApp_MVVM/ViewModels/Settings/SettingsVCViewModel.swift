//
//  SettingsVCViewModel.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import Foundation

final class SettingsVCViewModel {
    
    private var selectedIndexPath: Int?
    
    //MARK: - TableView Logic
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return 2
    }
    
    func titlesForSections(_ section: Int) -> String? {
        switch section {
        case 0:
            return TitlesForSections.temperature.rawValue
        case 1:
            return TitlesForSections.other.rawValue
        default:
            return ""
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath, completion: @escaping () -> Void) {
        if indexPath.section == 0 {
            selectedIndexPath = indexPath.row
            
            if indexPath.row == 0 {
                UserDefaults.standard.setValue(MeasurementsTypes.mertic.rawValue, forKey: "units")
            } else {
                UserDefaults.standard.setValue(MeasurementsTypes.imperial.rawValue, forKey: "units")
            }
            UserDefaults.standard.setValue(selectedIndexPath, forKey: "selectedItem")
            UserDefaults.standard.synchronize()
            completion()
        }
    }
}
