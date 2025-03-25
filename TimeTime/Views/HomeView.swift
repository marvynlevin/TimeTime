import SwiftUI

struct HomeView: View {
    @StateObject private var timeVM = TimeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("logoTimeTime")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 70)
                        .padding(.vertical, 20)

                    Text("\"Maitrisez votre temps, optimisez votre vie.\"")

                }

                VStack {
                    Spacer()
                    Text("Votre temps aujourd'hui")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)

                    HStack(spacing: 0) {
                        Text("\(Int(timeVM.todayUsage))h")
                            .font(.system(size: 22))
                            .foregroundColor(Color(hex: "#B64D6E"))
                        Text(" \(Int((timeVM.todayUsage - Float(Int(timeVM.todayUsage))) * 60))min")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                    }

                    let difference = timeVM.todayUsage - timeVM.yesterdayUsage
                    Text("C'est ")
                        .foregroundColor(.black)
                    + Text("\(abs(Int(difference)))h \(abs(Int((difference - Float(Int(difference))) * 60)))min de ")
                        .foregroundColor(.black)
                    + Text(difference < 0 ? "moins" : "plus")
                        .foregroundColor(difference < 0 ? Color(hex:"#0F9E05") : Color(hex: "#DB0101"))
                        .fontWeight(.bold)
                    + Text(" que hier")
                        .foregroundColor(.black)
                }

                VStack {
                    Spacer()
                    Text("Vos applications")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)

                    ForEach(Array(timeVM.topAppsToday.prefix(3).enumerated()), id: \.offset) { index, element in
                        let (app, duration) = element
                        HStack {
                            Text("\(Int(duration))h \(Int((duration - Float(Int(duration))) * 60))min")
                                .fontWeight(index == 0 ? .bold : .regular)
                                .font(.system(size: 22))
                                .foregroundColor(index == 0 ? Color(hex: "#B64D6E") : .black)

                            Text(app)
                                .fontWeight(index == 0 ? .bold : .regular)
                                .font(.system(size: 22))
                                .foregroundColor(index == 0 ? Color(hex: "#B64D6E") : .black)
                        }
                    }

                    Spacer()
                }
                .padding(.vertical, 36)

                Spacer()

                HStack {
                    Image("garcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 135)

                    VStack {
                        Spacer()

                        Text("Pour toutes informations complémentaires, vous pouvez accéder au manuel !")
                            .italic()
                            .font(.system(size: 16))
                            .lineSpacing(2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 5)
                            .multilineTextAlignment(.center)

                        Button {
                            // code pour le bouton
                        } label: {
                            Text("Manuel")
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 2)
                                .background(Color(hex: "#B64D6E"))
                                .cornerRadius(30)
                        }

                        Spacer()
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

#Preview {
    HomeView()
}
