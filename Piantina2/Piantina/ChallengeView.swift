//
//  ChallengeView.swift
//  Piantina
//
//  Created by Gennaro Savarese on 10/04/25.
//

import SwiftUI
import Foundation

struct Challenge: Identifiable {
    let id = UUID()
    let title: String
    var currentSteps: Int
    let goalSteps: Int
    

    var isCompleted: Bool {
        return currentSteps >= goalSteps
    }
}
class ChallengeViewModel: ObservableObject {
    @StateObject private var healthManager = HealthKitManager()
    @Published var challenges: [Challenge] = []
 /*
    func addStepsToAll(_ steps: Int) {
       for index in challenges.indices {
           let current = challenges[index].currentSteps
            let goal = challenges[index].goalSteps
         let newTotal = min(current + steps, goal)
           challenges[index].currentSteps = newTotal
        }
    }
    */
    init() {
        loadChallenges()
    }

    func loadChallenges() {
        challenges = [
            Challenge(title: "Too Fast, Too Curious", currentSteps: healthManager.steps, goalSteps: 100000),
            Challenge(title: "Speedy McFeet", currentSteps: healthManager.steps, goalSteps: 500000),
            Challenge(title: "Usain Bolt 2.0", currentSteps: healthManager.steps, goalSteps: 750000),
            Challenge(title: "History Of Naples", currentSteps: healthManager.steps, goalSteps: 1000000)
        ]
    }
/*
    func addSteps(to challengeID: UUID, steps: Int) {
        if let index = challenges.firstIndex(where: { $0.id == challengeID }) {
            challenges[index].currentSteps = min(challenges[index].currentSteps + steps, challenges[index].goalSteps)
        }
    }
 */
}

struct ChallengeRow: View {
    var challenge: Challenge
    @StateObject private var healthManager = HealthKitManager()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(challenge.title)
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.9))
                Text("\(healthManager.steps.formatted()) / \(challenge.goalSteps.formatted()) Steps")
                    .font(.body)
                    .foregroundColor(.white.opacity(1))
            }
            Spacer()
            
            CircularProgressView(progress: CGFloat(healthManager.steps) / CGFloat(challenge.goalSteps))
        }

        .padding(20)
        .background(Color.black.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .lineSpacing(100)
        .padding(.bottom, 19)
    }
}
struct CircularProgressView: View {
    var progress: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 9)
                .opacity(0.2)
                .foregroundColor(.white)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(.green)
                .rotationEffect(Angle(degrees: -90))

            if progress >= 1 {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
                    .font(.system(size: 12, weight: .bold))
            }
        }
        .frame(width: 32, height: 32)
    }
}
struct ChallengesView: View {
    @StateObject private var viewModel = ChallengeViewModel()
    

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(1.1), Color.green.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 15) {
                HStack{
                    
                    Text("Challenges")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.top,30)
                        .padding(.bottom,60)
                        .padding(.leading,90)
                }

                ForEach(viewModel.challenges) {
                    challenge in
                    ChallengeRow(challenge: challenge)
                }

                Spacer()
             }
            .padding()
            }
        }
    }

#Preview {
    ChallengesView()
}

