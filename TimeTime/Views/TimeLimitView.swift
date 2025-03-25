//
//  TimeLimitView.swift
//  TimeTime
//
//  Created by levin marvyn on 25/03/2025.
//

import SwiftUI

struct TimeLimitView: View {
    var body: some View {
        // ici on a juste un bouton retour en arrière (< Paramètres généraux) avec juste en dessous un titre en gras en taille assez concecente (limite de temps d'écran) et endessous, un texte Limite par jour avec en desosus un texte affichant la limite actuelle (doit etre réactive) et a gache de celle ci un switch (- + pour augmenter jusuqua 12h et baiser jusqua 2h)
        
        // on rajoutera aussi un bouton factice (juste là pour voir si ca fonctionne (on prend le dernier jour du TimeModel et on regarde si on a dépassé la limite de temps, si oui alors on a une notification à l'écran (Salut ! Je te fais un rappel ! (titre) Tu as atteint ta limite d'écran O_o (description))
        Text("TimeLimitView")
    }
}

#Preview {
    TimeLimitView()
}
