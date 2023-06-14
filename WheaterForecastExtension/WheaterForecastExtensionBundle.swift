//
//  WheaterForecastExtensionBundle.swift
//  WheaterForecastExtension
//
//  Created by Алексей Сердюк on 04.04.2023.
//

import WidgetKit
import SwiftUI

@main
struct WheaterForecastExtensionBundle: WidgetBundle {
    var body: some Widget {
        WheaterForecastExtension()
        WheaterForecastExtensionLiveActivity()
    }
}
