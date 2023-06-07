//
//  PlayerTrackerView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.05.2023.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    var maximumValue: Double
    private let minimumValue: Double = 0.0
    
    /// 1 second in milliseconds
    private let step: Double = 1
    let trackColor: Color = .white
    let thumbColor: Color = .white
    let remainedDurationColor: Color = .lightGray
    private let trackHeight: CGFloat = 4
    private let thumbSize: CGSize = CGSize(width: 16, height: 16)
    
    @EnvironmentObject var playerViewModel: PlayerViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Track
                Rectangle()
                    .foregroundColor(remainedDurationColor)
                    .frame(height: trackHeight)
                    .cornerRadius(trackHeight / 2)

                // Fill
                Rectangle()
                    .foregroundColor(trackColor)
                    .frame(width: fillWidth(in: geometry), height: trackHeight)
                    .cornerRadius(trackHeight / 2)

                // Thumb
                Circle()
                    .foregroundColor(thumbColor)
                    .frame(width: thumbSize.width, height: thumbSize.height)
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                    .offset(x: thumbOffset(in: geometry))
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ gestureValue in
                            let dragValue = gestureValue.location.x / geometry.size.width
                            value = getValue(from: dragValue)
                        })
                        .onEnded({ gestureValue in
                            let dragValue = gestureValue.location.x / geometry.size.width
                            let finalValue = getValue(from: dragValue)
                            playerViewModel.skipToPosition(finalValue)
                        })
                    )
            }
        }
    }

    private func fillWidth(in geometry: GeometryProxy) -> CGFloat {
        let ratio = CGFloat((value - minimumValue) / (maximumValue - minimumValue))
        return geometry.size.width * ratio
    }

    private func thumbOffset(in geometry: GeometryProxy) -> CGFloat {
        let ratio = CGFloat((value - minimumValue) / (maximumValue - minimumValue))
        let trackWidth = geometry.size.width - thumbSize.width
        return ratio * trackWidth
    }

    private func getValue(from dragValue: CGFloat) -> Double {
        let totalWidth = CGFloat(maximumValue - minimumValue)
        let value = Double(dragValue) * totalWidth + minimumValue
        let steppedValue = round(value / step) * step
        
        return min(maximumValue, max(minimumValue, steppedValue))
    }
}


struct PlayerTrackView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    private var totalTime: Double = 300 // Total time of the track in seconds

    var body: some View {
        VStack {
            CustomSlider(value: $playerViewModel.currentValue,
                         maximumValue: playerViewModel.state?.duration ?? 5000)
            .padding()
            
            HStack {
                Text(Int(playerViewModel.currentValue).convertSecondsToTime())
                    .padding(.leading)
                    .foregroundColor(.lightGray)
                Spacer()
                Text(Int(playerViewModel.state?.duration ?? 0.0).convertSecondsToTime())
                    .padding(.trailing)
                    .foregroundColor(.lightGray)
            }
        }.frame(maxHeight: 44)
    }
}

extension Int {
    func convertSecondsToTime() -> String {
        let minutes = self / 60
        let remainingSeconds = self % 60
        
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

struct PlayerTrackView_Preview: PreviewProvider {
    static var previews: some View {
        BlackBGScreen {
            PlayerTrackView()
                .environmentObject(PlayerViewModel.filledViewModel())
        }
    }
}
