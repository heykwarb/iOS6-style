//
//  widget.swift
//  widget
//
//  Created by Yohey Kuwa on 2023/03/24.
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

struct widgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        bookShelfView()
    }
}

struct bookShelfView: View{
    let artworks = ["kickback", "TLOP serif ver_small", "thriller_small"]
    let artworkSize: CGFloat = 90
    let frameHeight: CGFloat = 16
    
    ///let bgShadow: Color = C
    var body: some View{
        ZStack{
            Image("WoodBG_small")
                .resizable()
            Color.bgShadow.opacity(1)
            Image("WoodBG_small")
                .resizable()
                .opacity(0.9)
            
            HStack{
                ZStack{
                    Image("WoodBG_small")
                        .resizable()
                    Color.bgShadow.opacity(1)
                        .blendMode(.multiply)
                    Image("WoodBG_small")
                        .resizable()
                        .opacity(0.4)
                        
                }
                .frame(width: 20)
                    
                Spacer()
                
                ZStack{
                    Image("WoodBG_small")
                        .resizable()
                    Color.bgShadow.opacity(1)
                        .blendMode(.multiply)
                    Image("WoodBG_small")
                        .resizable()
                        .opacity(0.4)
                        
                }
                .frame(width: 20)
            }
            .shadow(color: .bgShadow.opacity(0.4), radius: 3)
            .shadow(color: .bgShadow.opacity(0.8), radius: 20)
            
            GeometryReader{ geo in
                ZStack{
                    Image("WoodBG_small")
                        .resizable()
                    Color.bgShadow.opacity(1)
                        .blendMode(.multiply)
                    Image("WoodBG_small")
                        .resizable()
                        .opacity(0.2)
                    
                        
                }
                .clipShape(
                    Path() {path in
                        path.addLines([
                            CGPoint(x: 20, y: 0),
                            CGPoint(x: 0, y: 16),
                            CGPoint(x: geo.size.width, y: 16),
                            CGPoint(x: geo.size.width-20, y: 0),
                            ///CGPoint(x: 0, y: 0),
                        ])
                    }
                )
                .shadow(color: .bgShadow.opacity(0.7), radius: 10)
                .offset(y: geo.size.height/2-16 + artworkSize/2+frameHeight/2)
                
                
            }
            
            VStack{
                ZStack{
                    Image("WoodBG_small")
                        .resizable()
                    Color.white.opacity(0.2)
                }
                .frame(height: frameHeight)
                .shadow(color: .black, radius: 18)
                Spacer()
            }
            ZStack{
                Image("WoodBG_small")
                    .resizable()
                Color.white.opacity(0.2)
            }
            .frame(height: frameHeight)
            .offset(y: artworkSize/2+frameHeight)
            
            HStack{
                ForEach(0..<3){num in
                    Image(artworks[num])
                        .resizable()
                        .frame(width: artworkSize, height: artworkSize)
                        .cornerRadius(4)
                        .shadow(color: .black, radius: 3)
                    
                }
            }
        }
    }
}
struct widgetView1 : View {
    let gradient1 = LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.3), .gray.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
    
    let artworks = ["kickback", "TLOP serif ver_small", "thriller_small"]
    var body: some View {
        ZStack{
            gradient1
            ZStack{
                Color.black.opacity(0.4)
                Image("BG")
                    .resizable()
                    .blendMode(.multiply)
                
                HStack{
                    ForEach(0..<3){num in
                        Image(artworks[num])
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(4)
                            .shadow(radius: 2)
                    
                    }
                }
            }
            .clipShape(ContainerRelativeShape())
            .padding(2)
            
        }
    }
}

struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
