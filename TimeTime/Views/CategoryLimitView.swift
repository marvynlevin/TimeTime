//
//  CategoryLimitView.swift
//  TimeTime
//
//  Created by levin marvyn on 25/03/2025.
//

import SwiftUI

struct CategoryLimitView: View {
    var body: some View {
        // ici on a juste un bouton retour en arrière (< Paramètres généraux) avec juste en dessous un titre en gras en taille assez concecente (limite de temps par catégorie)
        
        VStack {
            // on boucle sur les category qui existent
            VStack {
                Text("nom de la category i")
                
                HStack {
                    Text("limite temps heure, min") // doit afficher sous le format 1h 30min (et non 90min...)
                    // switch (- + qui décremente ou incremente de 10 min par 1 min
                }
            }
        }
        Text("CategoryLimitView")
    }
}

#Preview {
    CategoryLimitView()
}
