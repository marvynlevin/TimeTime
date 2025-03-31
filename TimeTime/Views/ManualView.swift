import SwiftUI

struct ManualView: View {
    @StateObject private var categoryVM = CategoryViewModel()
    @Environment(\.presentationMode) var presentationMode

    let manualText = """
    **Bienvenue sur TimeTime**
    L'application conçue pour vous aider à gérer et maîtriser votre temps d'écran. Ce manuel vous expliquera comment utiliser l'application, interpréter les données affichées, configurer les paramètres et comprendre nos conditions d'utilisation et notre politique de confidentialité.

    **1. Présentation de l'application**
    TimeTime vous permet de :
    • Suivre votre temps d'écran par jour, semaine et année
    • Analyser votre consommation d'applications par catégorie
    • Paramétrer des limites de temps d'utilisation
    • Recevoir des rappels pour limiter votre usage

    Notre objectif est de vous aider à adopter des habitudes numériques plus saines tout en conservant une pleine conscience de votre consommation digitale.

    **2. Comprendre vos données**
    TimeTime affiche vos habitudes d'utilisation sous forme de graphiques et de statistiques :
    • Par jour, par semaine : visualisez l'évolution de votre consommation.
    • Par catégorie d'application : Identifiez les types d'apps que vous utilisez le plus (vidéo, réseaux sociaux, productivité, etc.);
    • Alertes et recommandations : Recevez des suggestions personnalisées pour mieux gérer votre temps d'écran.
    
    **3. Graphiques et statistiques**
    TimeTime affiche vos habitudes d'utilisation sous forme de graphiques et de statistiques :
    • Par jour, semaine et année : Visualisez l'évolution de votre consommation.
    • Par catégorie d'application : Identifiez les types d'apps que vous utilisez le plus (vidéo, réseaux sociaux, productivité, etc.).
    • Alertes et recommandations : Recevez des suggestions personnalisées pour mieux gérer votre temps d'écran.

    **4. Fonctionnalités de paramétrage**
    TimeTime offre plusieurs options pour adapter votre expérience :
    • Limite de temps d'écran : Définissez un temps d'utilisation maximum par heure, jour ou mois.
    • Notification d'heure de coucher : Activez une alerte pour vous rappeler d'aller dormir.
    • Gestion des applications par catégorie : Personnalisez vos catégories et contrôlez leur usage.

    **5. Conditions Générales d'Utilisation (CGU)**
    En utilisant TimeTime, vous acceptez nos CGU, qui prévoient notamment :
    • Une utilisation responsable de l'application
    • Le respect des lois en vigueur concernant la protection des données
    • L'interdiction de partager votre compte avec d'autres utilisateurs.

    **6. Politique de Confidentialité (RGPD)**
    Votre confidentialité est notre priorité. Nous respectons le RGPD et nous engageons à :
    • Ne collecter que les données nécessaires à l'utilisation de l'application
    • Ne pas partager vos données avec des tiers sans votre consentement
    • Vous offrir un accès et un contrôle total sur vos informations personnelles

    **7. Support et assistance**
    Si vous avez des questions ou des problèmes, notre équipe de support est à votre disposition. Vous pouvez consulter la FAQ ou nous contacter directement depuis l'application.

    Nous espérons que TimeTime vous aidera à adopter une consommation digitale plus équilibrée !

    **Bonne utilisation !**
    L'équipe TimeTime
    """

    var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("Manuel d'utilisation")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(parseManualText(manualText), id: \.self) { item in
                            if item.starts(with: "**") {
                                Text(item.replacingOccurrences(of: "**", with: ""))
                                    .font(.system(size: 19))
                                    .fontWeight(.bold)
                                    .padding(.top, 6)
                            } else {
                                Text(item)
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        Image("logoTimeTime")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 80)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
                .frame(height: 427)

                Spacer()

                HStack {
                    Image("garcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 135)

                    VStack {
                        Spacer()

                        Text("Vous pouvez revenir à l'accueil via ce bouton après votre lecture !")
                            .italic()
                            .font(.system(size: 16))
                            .lineSpacing(1)
                            .fontWeight(.bold)
                            .padding(.horizontal, 5)
                            .multilineTextAlignment(.center)

                        NavigationLink(destination: HomeView()) {
                            Text("Accueil")
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
            .padding(.bottom, 12)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "#B64D6E"))
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                    Text("Paramètres généraux")
                        .foregroundColor(Color(hex: "#B64D6E"))
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                }
            })
            .onDisappear {
                categoryVM.saveSettings()
            }
        }

        // FONCTION PARSER DE DATA
        func parseManualText(_ text: String) -> [String] {
            let lines = text.split(separator: "\n").map { String($0) }
            var formattedLines: [String] = []

            for line in lines {
                formattedLines.append(line)
            }

            return formattedLines
        }
    }

    #Preview {
        ManualView()
    }
