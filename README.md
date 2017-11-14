# handwriting_number

Dans ce projet, nous avons cherché sur la reconnaissance des chiffres manuscrits.
Premièrement, nous extrayons les caractéristiques d’image dont les méthodes sont
bien définies dans le rapport. Puis, on vérifie la qualité des caractéristiques par la
méthode des fenêtres de Parzen et le K-plus-proche-voisin. Sur cette base, on teste
deux méthodes d’apprentissage plus modernes--le SVM et le méthode BP (Back
Propagation) réseaux de neurones. Naturellement, on considère le problème de la
sélection des caractéristiques après. C’est-à-dire comment choisir les meilleur
caractéristiques pour le système. On teste l’algorithme d’sélection avec les réseaux de
neurones et discute les résultats.
