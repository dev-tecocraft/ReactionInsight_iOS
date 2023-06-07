//
//  ContentView.swift
//  ReactionInsight
//
//  Created by iMac.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @State private var reactionModel: [ReactionModel] = [
        ReactionModel(img: Img.cool, numbers: 0, percentage: 0, yValue: 0.1, color: .yellow),
        ReactionModel(img: Img.cry, numbers: 0, percentage: 0, yValue: 0.4, color: .cyan),
        ReactionModel(img: Img.angry, numbers: 0, percentage: 0, yValue: 0.3, color: .red),
        ReactionModel(img: Img.happy, numbers: 0, percentage: 0, yValue: 0.8, color: .green),
        ReactionModel(img: Img.surprised, numbers: 0, percentage: 0, yValue: 0.6, color: .blue),
        ReactionModel(img: Img.love, numbers: 0, percentage: 0, yValue: 0.2, color: .orange)
    ]
    
    @State private var arrChartColor: [Color] = []
    @State private var arrChartValue: [Double] = []
    
    @State private var chartValue: Double = 0.0
    @State private var chartColor: Color = .red
    @State private var emptyChartText: String = LabelText.emptyChartText
    
    //MARK: - Main view
    var body: some View {
        ScrollView {
            VStack {
                //MARK: - Post view
                VStack {
                    //MARK: User Info view
                    PostDataView()
                    
                    //MARK: Reaction pallet view
                    HStack(spacing: 15) {
                        ForEach(reactionModel, id: \.self) { model in
                            PostReactionView(action: {
                                let index = reactionModel.firstIndex(of: model)
                                reactionModel[index ?? 0].numbers += 1
                                manageChartData()
                                animatePieChart()
                            }, reactionModel: model)
                        }
                    }
                    .padding([.leading, .trailing])
                    .padding(.top, 4)
                    .padding(.bottom, 6)
                }
                .modifier(BgView())
                
                //MARK: - Chart-Data view
                VStack {
                    Text(LabelText.chartData)
                        .padding(.top)
                    HStack{
                        //MARK: Reactions list with percetage
                        VStack(alignment: .leading) {
                            ForEach(0..<reactionModel.count, id:\.self) { i in
                                ReactionPercentageView(img: reactionModel[i].img, txt: "\(reactionModel[i].percentage) %", color: reactionModel[i].color)
                            }
                        }
                        
                        //MARK: Pie Chart view
                        ZStack {
                            if chartValue == 0.0 {
                                Text(emptyChartText)
                                    .font(.system(size: 15))
                            }
                            
                            FullPieAnimation(chartValue: .constant(chartValue), color: .constant(chartColor))
                            PieChartView(data: zip(arrChartValue, arrChartColor).map { ($0, $1) })
                                .frame(width: 200, height: 180)
                        }
                    }
                    .padding(.all)
                }
                .modifier(BgView())
            }
        }
        .padding(.top, 1)
        .background(Color.gray.opacity(0.1))
        .onAppear {
            arrChartColor = reactionModel.map({$0.color})
            manageChartData()
        }
    }
    
    //MARK: - Private helper functions
    
    /// this function is use for manage chart data according to value
    private func manageChartData() {
        
        /// caluclate total values for finding actual percentage values
        let sum = reactionModel.reduce(0) { $0 + $1.numbers }
        
        /// this loop is used for calculate percentage for each numbers
        for index in 0..<reactionModel.count {
            let percentage = Double(reactionModel[index].numbers) / Double(sum) * 100
            let roundedPercentage = Double(round(10 * percentage) / 10)
            
            if roundedPercentage > 0.0 {
                reactionModel[index].percentage = roundedPercentage
                chartColor = reactionModel[index].color
            }
        }
        
        arrChartValue = reactionModel.map { Double($0.percentage) }
    }
    
    private func animatePieChart() {
        withAnimation(.easeInOut(duration: 0.5)) {
            chartValue = 10
        }
    }
    
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
