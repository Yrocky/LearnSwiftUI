//
//  DoVideoPlayer.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/2/7.
//

import SwiftUI
import AVKit

struct DoVideoPlayer: View {
    var body: some View {
        ExampleContainerView("VideoPlayer", version: "2.0") {
            
            doPlayLocalVideo
            
            doPlayRemoteVideo
            
            doVideoOverlay
            
            doVideoOverlayWithValueChange
            
            // todo：wrapAVKit中的视图
        }
    }
    
    var doPlayLocalVideo: some View {
        VExampleView("local video") {
            /*:
             在14.0中，SwiftUI为我们提供了播放视频的组件：`VideoPlayer`，
             但是需要依赖AVKit的，其头文件如下：
             
             ```swift
             struct VideoPlayer<VideoOverlay> : View where VideoOverlay : View {
             
                 public init(player: AVPlayer?, @ViewBuilder videoOverlay: () -> VideoOverlay)
                 
                 public var body: some View { get }
                 public typealias Body = some View
             }
             
             VideoPlayer where VideoOverlay == EmptyView {
                 public init(player: AVPlayer?)
             }
             ```
             我们唯一要做的就是，使用AVPlayer来加载视频资源，然后交给VideoPlayer即可。
             
             
             创建的VideoPlayer还需要自己设置尺寸，
             
             */
            VideoPlayer(player: AVPlayer(url: localVideoURL))
                .frame(width: 300, height: 90)
        }
    }
    
    var doPlayRemoteVideo: some View {
        VExampleView("remote") {
            VideoPlayer(player: AVPlayer(url: remoteVideoURL))
                .frame(width: 300, height: 150)
        }
    }
    
    var doVideoOverlay: some View {
        VExampleView("videoOverlay") {
            /*:
             VideoPlayer还允许我们创建一个`VideoOverlay`，这个VideoOverlay最终会作用在视频图层上，我们可以设置水印、弹幕等等，
             
             我们使用VideoOverlay添加的View不能响应任何的事件，它只是被绘制到图层中。
             */
            VideoPlayer(player: AVPlayer(url: localVideoURL)) {
                
                VStack {
                    Text("Y_rocky")
                        .padding(4)
                        .foregroundColor(.white)
                        .font(.system(size: 11))
                        .background(Color.pink)
                        .cornerRadius(4)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onTapGesture {
                            // 不能响应手势
                            print("1.tap...")
                        }
                }
            }
            .frame(width: 300, height: 190)
            .cornerRadius(10)
            .overlay(
                Text("Y_rocky")
                    .padding(4)
                    .foregroundColor(.white)
                    .font(.system(size: 11))
                    .background(Color.blue)
                    .cornerRadius(4)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .onTapGesture {
                        // 可以响应手势
                        print("2.tap...")
                    }
            )
        }
    }
    
    @State private var value: CGFloat = 0.3
    
    var doVideoOverlayWithValueChange: some View {
        VExampleView("value change") {
            VideoPlayer(player: AVPlayer(url: localVideoURL)) {
                /*:
                 如果我们为VideoPlayer设置的VideoOverlay涉及到数据的变动，那么就会引起VideoPlayer的重新绘制，
                 
                 目前SwiftUI中的VideoPlayer还不是很完善，很多功能够没有提供，还是只能靠桥接到AVKit来实现视频的播放。
                 */
                VStack {
                    Text("\(value)")
                        .padding(4)
                        .foregroundColor(.white)
                        .font(.system(size: 11))
                        .background(Color.pink)
                        .cornerRadius(4)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .frame(width: 300, height: 190)
            .cornerRadius(10)
            
            VideoPlayer(player: AVPlayer(url: localVideoURL))
                .frame(width: 300, height: 190)
                .cornerRadius(10)
                .overlay(
                    Text("\(value)")
                        .padding(4)
                        .foregroundColor(.white)
                        .font(.system(size: 11))
                        .background(Color.blue)
                        .cornerRadius(4)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                )
            
            Slider(value: $value, in: 0...1, step: 0.1)
        }
    }
    var localVideoURL: URL {
        Bundle.main.url(forResource: "BlurImageView", withExtension: ".mp4")!
    }
    
    var remoteVideoURL: URL {
        URL(string: "http://vfx.mtime.cn/Video/2019/03/13/mp4/190313094901111138.mp4")!
    }
}

struct DoVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        DoVideoPlayer()
    }
}
