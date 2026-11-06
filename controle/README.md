# Fichiers de contrôle

| Fichier | Contenu |
|---|---|
| `journal_corrections_JO.csv` | Chaque correction : commune, champ, valeur avant, valeur après, texte du JO qui la justifie |
| `noms_a_verifier.csv` | Les 272 noms non confirmés par un JO, avec le nom trouvé dans le JO le plus récent et une catégorie (« variante d’orthographe » ou « changement de nom probable ») |
| `renommages_JO_loi_26-06.csv` | Les noms remplacés par la graphie de la loi 26-06 |
| `correspondance_IdCommune.csv` | Passage de l’ancien `IdCommune` au nouveau |

Les noms extraits des JO scannés (1991) ont été lus par reconnaissance de caractères : la colonne `Nom_dans_le_JO` de `noms_a_verifier.csv` peut contenir de petites erreurs de lecture.
