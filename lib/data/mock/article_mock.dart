import 'package:hydrogrow/data/models/article.dart';

final List<Article> mockArticles = [
  Article(
    id: 'art-1',
    title: 'Optimiser le pH en hydroponie NFT : mon retour d\'expérience',
    authorId: 'Koruji',
    authorName: 'Koruji',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    category: 'Technique',
    tags: ['pH', 'NFT', 'hydroponie', 'optimisation'],
    content: '''Après plusieurs mois de culture en système NFT, j'ai enfin trouvé la méthode qui me convient pour maintenir un pH stable entre 5.8 et 6.2.

Le problème principal que j'avais au départ, c'est que mon pH remontait systématiquement la nuit quand les plantes photosynthétisent moins. J'ai donc mis en place une double mesure : matin et soir.

**Ma routine quotidienne :**

1. Mesure du pH à 7h avant les lampes
2. Ajustement si nécessaire avec pH Down ou pH Up dilués au 1/10
3. Mesure à 19h après la session lumineuse
4. Note des variations dans mon carnet de bord

Ce qui m'a le plus aidé, c'est d'utiliser une solution tampon de référence à 6.0 pour calibrer mon pH-mètre chaque semaine. Beaucoup d'erreurs viennent d'une sonde mal calibrée.

**L'astuce que personne ne m'avait dite :** ajouter du silicate de potassium à faible dose (0.5 mL/L) tamponise naturellement la solution et réduit les fluctuations. Depuis que j'ai intégré ça à ma recette, les variations sont passées de ±0.8 à ±0.2 en moyenne.

N'hésitez pas à me poser vos questions en commentaire !''',
  ),
  Article(
    id: 'art-2',
    title: 'Comparatif laine de roche vs coco : lequel choisir pour démarrer ?',
    authorId: 'Koruji',
    authorName: 'Koruji',
    createdAt: DateTime.now().subtract(const Duration(days: 15)),
    category: 'Partage',
    tags: ['substrat', 'laine de roche', 'coco', 'débutant'],
    content: '''Question que beaucoup se posent au départ : laine de roche ou fibre de coco ? J'ai testé les deux et voici mon bilan objectif après un an de pratique.

**Laine de roche :**
✅ Inerte, pas de buffer chimique
✅ Excellente rétention d'eau et d'air
✅ Réutilisable si bien stérilisée
❌ Moins écologique (fibres minérales)
❌ Peut irriter la peau à la manipulation

**Fibre de coco :**
✅ Renouvelable et biodégradable
✅ Activité microbienne naturellement bénéfique
✅ Bon rapport prix/volume
❌ Contient naturellement du potassium (à prendre en compte dans la nutrition)
❌ Peut varier en qualité selon les fournisseurs

**Mon verdict :** Pour un débutant qui veut apprendre sans trop de variables, je recommande la laine de roche. Pour quelqu'un de sensible à l'écologie ou qui fait de la culture semi-bio, la coco est excellente avec un rinçage initial soigneux.

Dans tous les cas, l'important c'est la constance dans vos pratiques !''',
  ),
  Article(
    id: 'art-3',
    title: 'Recette de solution nutritive de base pour légumes feuilles',
    authorId: 'Loocist',
    authorName: 'Loocist',
    createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    category: 'Nutrition',
    tags: ['nutrition', 'solution', 'légumes feuilles', 'recette'],
    content: '''Voici la recette que j'utilise depuis 6 mois pour mes laitues, épinards et basilic. Elle fonctionne très bien en système DWC et aéroponie.

**Pour 100L d'eau :**

| Nutriment | Quantité |
|-----------|----------|
| Nitrate de calcium | 94g |
| Nitrate de potassium | 40g |
| Phosphate monopotassique | 27g |
| Sulfate de magnésium | 24g |
| Chélate de fer EDTA | 1.5g |

**Oligo-éléments (solution mère x1000) :**
Utiliser 10 mL de la solution mère Hoagland modifiée pour 100L.

**Paramètres cibles :**
- EC : 1.2 à 1.8 mS/cm
- pH : 6.0 à 6.5
- Température solution : 18-22°C

J'utilise de l'eau osmosée (EC < 0.1) pour avoir un contrôle total. Si vous avez de l'eau du robinet, mesurez d'abord son EC résiduel et ajustez en conséquence.

Cette recette est volontairement légère en azote pour favoriser un goût moins amer et une texture croquante. Pour les plantes à fruits, augmentez le nitrate de calcium de 20% en phase végétative.''',
  ),
  Article(
    id: 'art-4',
    title: 'Comment j\'ai automatisé mon dosage avec un Arduino Nano',
    authorId: 'Loocist',
    authorName: 'Loocist',
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    category: 'Innovation',
    tags: ['automation', 'arduino', 'DIY', 'dosage'],
    content: '''Projet DIY que j'avais en tête depuis longtemps : un doseur automatique de pH et d'EC piloté par Arduino. Voici comment je l'ai construit pour moins de 80€.

**Matériel nécessaire :**
- Arduino Nano (ou compatible)
- 3x pompes péristaltiques 12V (alimentation séparée)
- Capteur pH analogique (module DFRobot)
- Capteur EC analogique
- Module relais 4 canaux
- Boîtier étanche IP65
- Fils, résistances, condensateurs de filtrage

**Principe de fonctionnement :**
L'Arduino lit le pH et l'EC toutes les 30 minutes. Si le pH est hors plage (5.8-6.2), il active la pompe pH Down ou pH Up pendant X secondes selon la dérive. Pareil pour l'EC avec la solution nutritive concentrée.

Le code source est disponible sur mon GitHub (DM pour le lien). Je recommande d'ajouter un délai de 10 minutes après chaque dosage avant la prochaine lecture, le temps que la solution se mélange bien.

**Résultat :** 90% de stabilité en plus, et je n'interviens manuellement qu'une fois par semaine pour les contrôles visuels.

Prochaine étape : intégrer un écran OLED et des alertes par notification push !''',
  ),
  Article(
    id: 'art-5',
    title: 'Problème de brunissement des racines en DWC — quelqu\'un a une solution ?',
    authorId: 'HydroFarmer42',
    authorName: 'HydroFarmer42',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    category: 'Question',
    tags: ['DWC', 'racines', 'pythium', 'problème'],
    content: '''Bonjour à tous,

Je cultive des tomates cerises en DWC depuis 3 semaines et j'observe un brunissement progressif des racines. La solution nutritive reste claire et ne sent pas mauvais, mais les racines passent du blanc immaculé à un marron clair.

**Mes paramètres actuels :**
- EC : 2.1 mS/cm
- pH : 6.1
- Température solution : 23°C (je sais, c'est un peu élevé)
- Oxygénation : pompe à air 6L/min pour 50L
- Lumière : 18h/6h, LED 400W

J'ai lu que ça pouvait être du Pythium (champignon aquatique) favorisé par la température élevée. J'envisage d'ajouter de la Hydroguard (Bacillus amyloliquefaciens) ou du peroxyde d'hydrogène à 3%.

Est-ce que quelqu'un a déjà eu ce problème ? Quelle solution a fonctionné pour vous ? Je préférerais rester en culture propre sans fongicides chimiques si possible.

Merci d'avance pour vos retours !''',
  ),
  Article(
    id: 'art-6',
    title: 'Construire une tour aéroponique verticale pour 40 plants en 1m²',
    authorId: 'VertiGrow',
    authorName: 'VertiGrow',
    createdAt: DateTime.now().subtract(const Duration(days: 8)),
    category: 'Innovation',
    tags: ['aéroponie', 'vertical', 'DIY', 'espace réduit'],
    content: '''La tour aéroponique verticale est la solution idéale pour maximiser la production en espace réduit. Voici mon setup qui produit 40 plants sur 1m² de surface au sol.

**Structure :**
- Tube PVC 150mm de diamètre, 2m de hauteur
- 8 niveaux de 5 trous de 50mm (déphasés à 45°)
- Réservoir de 80L en bas (récupération par gravité)
- Pompe 1500L/h pour la brumisation

**La magie de l'aéroponie :**
Les racines sont suspendues dans l'air et reçoivent une brume fine de solution nutritive toutes les 3 minutes pendant 15 secondes. L'exposition maximale à l'oxygène accélère la croissance de 30 à 50% par rapport à l'hydroponie classique.

**Points d'attention :**
- La pompe NE DOIT PAS s'arrêter plus de 30 minutes (racines qui sèchent)
- Utiliser des buses anti-bouchon en inox (les plastiques s'obstruent vite)
- Insulation thermique du réservoir obligatoire en été

J'ai investi 180€ en matériel pour ce setup. Le retour sur investissement en légumes récoltés est estimé à 4 mois.

Je peux partager les plans détaillés pour ceux qui sont intéressés !''',
  ),
  Article(
    id: 'art-7',
    title: 'Les erreurs de débutant que j\'aurais aimé éviter',
    authorId: 'HydroFarmer42',
    authorName: 'HydroFarmer42',
    createdAt: DateTime.now().subtract(const Duration(days: 45)),
    category: 'Partage',
    tags: ['débutant', 'erreurs', 'conseils', 'retour'],
    content: '''Deux ans de pratique de l'hydroponie, des échecs, des réussites, et surtout beaucoup d'apprentissages. Voici les erreurs que j'ai faites et que vous pouvez éviter.

**1. Sauter l'étape de calibration**
Mon pH-mètre d'entrée de gamme n'était jamais calibré. Pendant 2 mois je pensais être à 6.0 et j'étais en réalité à 5.2. Résultat : carence en calcium et magnésium sur toute la récolte.

**2. Négliger la température de la solution**
Au-dessus de 22°C, le risque de Pythium explose. J'ai perdu une culture entière l'été à cause de ça.

**3. Changer trop de variables en même temps**
Quand quelque chose ne va pas, ne changez qu'UN paramètre à la fois. Sinon vous ne savez jamais ce qui a marché.

**4. Sous-estimer la consommation d'eau**
En pleine croissance, mes tomates buvaient 2L/jour/plant. Pas assez de réservoir = fluctuations de l'EC constantes.

**5. Oublier la période de nettoyage**
Entre chaque culture, un nettoyage complet à l'eau de Javel diluée + rinçage abondant est indispensable pour éviter l'accumulation de pathogènes.

J'espère que ce retour vous évitera quelques galères ! N'hésitez pas à ajouter vos propres erreurs en commentaire.''',
  ),
];
