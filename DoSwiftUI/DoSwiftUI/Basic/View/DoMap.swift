//
//  DoMap.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/2/7.
//

import SwiftUI
import MapKit

struct DoMap: View {
    var body: some View {
        ExampleContainerView("Map", version: "2.0") {
            
            doMapRect
            
            doCoordinateRegion_1
            
            doCoordinateRegion_2
        }
    }
    
    @State private var mapRect: MKMapRect = MKMapRect(
        origin: MKMapPoint(CLLocationCoordinate2DMake(31.22, 121.48)),
        size: MKMapSize(width: 100000, height: 100000)// 单位为m
    )
    
    var doMapRect: some View {
        VExampleView("use mapRect") {
            /*:
             Map是14.0之后添加的一个关于在SwiftUI中地图视图的拓展，
             */
            Map(mapRect: $mapRect)
                .frame(width: 300, height: 200)
                .cornerRadius(10)
                .shadow(radius: 4)
        }
    }
    
    @State private var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2DMake(31.22, 121.48),
        span: MKCoordinateSpan.init(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    var doCoordinateRegion_1: some View {
        
        VExampleView("use coordinateRegion") {
            Map(coordinateRegion: $coordinateRegion)
                .frame(width: 300, height: 200)
                .cornerRadius(10)
                .shadow(radius: 4)
        }
    }
    
    @State private var trackingMode: MapUserTrackingMode = .follow
    
    var doCoordinateRegion_2: some View {
        
        VExampleView("use coordinateRegion 2") {
            Map(coordinateRegion: $coordinateRegion, interactionModes: .zoom, showsUserLocation: true, userTrackingMode: $trackingMode)
                .frame(width: 300, height: 200)
                .cornerRadius(10)
                .shadow(radius: 4)
        }
    }
    
    let locations : [Location] = [
        Location(latitude: 31.22, longitude: 121.48),
        Location(latitude: 31.4, longitude: 121.24),
        Location(latitude: 31.73, longitude: 121.4)
    ]
    var dosdfs: some View {
        VExampleView("use") {
            /*:
             public init<Items, Annotation>(
                 coordinateRegion: Binding<MKCoordinateRegion>,
                 interactionModes: MapInteractionModes = .all,
                 showsUserLocation: Bool = false,
                 userTrackingMode: Binding<MapUserTrackingMode>? = nil,
                 annotationItems: Items,
                 annotationContent: @escaping (Items.Element) -> Annotation
             )
             
             where Content == _DefaultAnnotatedMapContent<Items>, Items : RandomAccessCollection, Annotation : MapAnnotationProtocol, Items.Element : Identifiable

             */
//            Map(coordinateRegion: $coordinateRegion, annotationItems: locations) { (location) -> MapAnnotationProtocol in
//                MapAnnotation(coordinate: location.coordinate) {
//                    Text("")
//                }
//            }
//            Map(coordinateRegion: $coordinateRegion, annotationItems: locations) { (local) -> MapAnnotationProtocol in
//                MapAnnotation.init(coordinate: local.coordinate) {
//                    Text("")
//                }
//            }
        }
    }
}

struct Location: Identifiable {
    
    let id = UUID()
    let latitude: CLLocationDegrees// 维度
    let longitude: CLLocationDegrees// 经度
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2DMake(latitude, longitude)
    }
}

struct DoMap_Previews: PreviewProvider {
    static var previews: some View {
        DoMap()
    }
}
