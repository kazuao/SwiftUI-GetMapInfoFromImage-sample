//
//  ContentView.swift
//  SwiftUI-GetCoordinatesFromImage-Sample
//
//  Created by kazunori.aoki on 2021/12/01.
//

import SwiftUI
import AdvancedScrollView

struct ContentView: View {

    @State private var isShowHalfModal = false

    var body: some View {

        VStack {
            Text("Map 拡大テスト")

            Button(action: { isShowHalfModal.toggle() }) {
                Text("show half modal")
            }
            // half modalふうに使う場合
//            .halfModal(isShow: $isShowHalfModal) {
//                InMap()
//            } onEnd: {
//                print("dismiss half modal")
//            }
            // modalとして使う場合
            .sheet(isPresented: $isShowHalfModal, onDismiss: {
                print("dismiss")
            }, content: {
                InMap()
            })
            // フルスクリーンにするばあい
//            .fullScreenCover(isPresented: $isShowHalfModal, onDismiss: { }) {
//                InMap()
//            }
        }
    }
}

struct InMap: View {

    @State var location: CGPoint?
    @State private var showingAlert: AlertData?

    let magnification = Magnification(range: 1.0...5.0,
                                      initialValue: 1.0,
                                      isRelative: true)

    var body: some View {

        AdvancedScrollView(magnification: magnification,
                           isScrollIndicatorVisible: true) { _ in

            Image("map")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(Background { location in
                    self.location = location
                    print("location: \(location)")

                    judgeTouchArea(point: location)
                })
                .overlay(locationIcon)
                .alert(item: $showingAlert) { item in
                    alert(alertItem: item)
                }
        }
    }

    var locationIcon: some View {
        if let location = location {
            return AnyView(Circle()
                            .fill(.blue)
                            .frame(width: 10, height: 10)
                            .position(x: location.x, y: location.y))
        } else {
            return AnyView(EmptyView())
        }
    }

    func judgeTouchArea(point: CGPoint) {
        switch (point.x, point.y) {
        case (183...210, 54...83):
            print("ラルフローレン")
            showingAlert = .init(title: "ラルフローレン", message: "tap", primaryText: "OK", primaryAction: {
                print("ok tapped ラルフローレン")
            }, secondaryText: "Cancel", secondaryAction: {
                print("cancel tapped ラルフローレン")
            })

        case (277...300, 171...191):
            print("ルイヴィトン")
            showingAlert = .init(title: "ルイヴィトン", message: "tap", primaryText: "OK", primaryAction: {
                print("ok tapped ラルフローレン")
            }, secondaryText: "Cancel", secondaryAction: {
                print("cancel tapped ルイヴィトン")
            })

        case (388...400, 195...210):
            print("Apple")
            showingAlert = .init(title: "Apple", message: "tap", primaryText: "OK", primaryAction: {
                print("ok tapped Apple")
            }, secondaryText: "Cancel", secondaryAction: {
                print("cancel tapped Apple")
            })

        case (434...461, 267...292):
            print("みずほ")
            showingAlert = .init(title: "みずほ", message: "tap", primaryText: "OK", primaryAction: {
                print("ok tapped みずほ")
            }, secondaryText: "Cancel", secondaryAction: {
                print("cancel tapped みずほ")
            })

        default: break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
