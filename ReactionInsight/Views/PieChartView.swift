//
//  PieChartView.swift
//  ReactionInsight
//
//  Created by iMac.
//

import SwiftUI

struct PieChartView: View {
    let data: [(Double, Color)]
    
    var body: some View {
        ZStack {
            ForEach(0..<data.count, id: \.self) { index in
                PieSlice(startAngle: angle(for: index),
                         endAngle: angle(for: index + 1))
                .fill(data[index].1)
                .animation(.linear(duration: 0.5), value: data[index].0)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func angle(for index: Int) -> Angle {
        let total = data.reduce(0) { $0 + $1.0 }
        let startAngle = data.prefix(index).reduce(0) { $0 + $1.0 } / total * 360
        return Angle(degrees: startAngle)
    }
}

struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(startAngle.radians, endAngle.radians) }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
}

struct FullPieAnimation :  View {
    @Binding var chartValue : CGFloat
    @Binding var color: Color
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Circle()
                    .inset(by: proxy.size.width / 4)
                    .trim(from: 0, to: chartValue / 10)
                    .stroke(color, style: StrokeStyle(lineWidth: proxy.size.width / 2))
                    .rotationEffect(.radians(-.pi / 2))
            }
        }
    }
}
