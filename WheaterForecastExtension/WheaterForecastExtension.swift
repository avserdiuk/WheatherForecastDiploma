//
//  WheaterForecastExtension.swift
//  WheaterForecastExtension
//
//  Created by Алексей Сердюк on 04.04.2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WheaterForecastExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {

        ZStack{
            Color(Colors.accentBlue.color)
            Image("cloud_wi")
                .offset(x: 80, y: -40)

            HStack(){
                Image("wIco")
                Text("19°")
                    .foregroundColor(.white)
                    .font(.custom(Font.regular.rawValue, size: 30))
            }.offset(x: -110,y: -50)

            VStack( alignment: .trailing, spacing: 6) {
                Text("Переменная облачность")
                    .foregroundColor(.white)
                    .font(.custom(Font.regular.rawValue, size: 14))
                Text("Омск")
                    .foregroundColor(.white)
                    .font(.custom(Font.bold.rawValue, size: 14))
            }.offset(x: 70,y: -45)

            HStack(spacing: 30){
                ForEach(
                    1...5,
                    id: \.self
                ) {_ in
                    VStack(alignment: .center, spacing: 3){
                        Text("чт")
                            .foregroundColor(.white)
                            .font(.custom(Font.regular.rawValue, size: 16))
                        Text("70%")
                            .foregroundColor(.white)
                            .font(.custom(Font.regular.rawValue, size: 13))
                        Image("cloudIco_wi")
                        Text("9°/15°")
                            .foregroundColor(.white)
                            .font(.custom(Font.regular.rawValue, size: 13))
                    }
                }
            }.offset(x: 0,y: 25)
        }
    }
}


struct WheaterForecastExtension: Widget {
    let kind: String = "WheaterForecastExtension"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WheaterForecastExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WheaterForecastExtension_Previews: PreviewProvider {
    static var previews: some View {
        WheaterForecastExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
