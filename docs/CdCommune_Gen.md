# Le code généré `CdCommune_Gen`

## Pourquoi un code généré ?

L’Algérie dispose d’un code commune officiel, attribué par l’ONS. Ce code n’était pas disponible au moment de la constitution du jeu de données. Plutôt que de laisser les communes sans code, un code **reproductible** a été construit à partir de la structure administrative : wilaya → daïra → commune.

Le champ `CdCommune` reste réservé au code officiel. Le code généré a un nom distinct (`CdCommune_Gen_…`) pour qu’aucune confusion ne soit possible.

## Structure

Six chiffres : `WW DD CC`.

| Partie | Signification | Valeurs |
|---|---|---|
| `WW` | Code de la wilaya, selon le découpage de l’année | `01` à `48` (1984), `01` à `58` (2019), `01` à `69` (2026) |
| `DD` | Rang de la daïra dans la wilaya | `01` à `21` au maximum |
| `CC` | Rang de la commune dans la daïra | `01` à `07` au maximum |

Deux chiffres pour la commune laissent de la marge : aucune daïra ne dépasse aujourd’hui 7 communes, mais le format accepte jusqu’à 99.

## Règles de numérotation

### 1. Ordre des daïras dans une wilaya

1. La daïra qui contient le **chef-lieu de wilaya** reçoit `01`.
2. Les autres daïras suivent par **ordre alphabétique** de leur nom.

Le chef-lieu de wilaya est la commune dont le nom correspond à celui de la wilaya.

### 2. Ordre des communes dans une daïra

1. La **commune chef-lieu de daïra** reçoit `01`.
2. Les autres suivent par **ordre alphabétique**.
3. Si aucun chef-lieu n’est identifié, toutes les communes sont classées par ordre alphabétique.

### 3. Tri alphabétique

Le tri se fait sur le nom **sans accents ni majuscules ni ponctuation** : « Aïn Témouchent », « Ain Temouchent » et « AIN TEMOUCHENT » sont classés au même rang. Cela rend le classement moins sensible aux variantes d’orthographe.

## Les trois versions du code

| Champ | Wilayas utilisées | Daïras utilisées |
|---|---|---|
| `CdCommune_Gen_1984` | `CdWilaya_1984` (loi 84-09) | `LbDaira_1991` (décret 91-306) |
| `CdCommune_Gen_2019` | `CdWilaya_2019` (loi 19-12) | `LbDaira` (daïras actuelles) |
| `CdCommune_Gen_2026` | `CdWilaya_2026` (loi 26-06) | `LbDaira` (daïras actuelles) |

**Pourquoi le décret de 1991 pour le code 1984 ?** La loi 84-09 fixe les wilayas et leurs communes, mais pas les daïras. Le décret 91-306 est le texte officiel le plus ancien disponible qui fixe les daïras, et les wilayas n’ont pas changé entre 1984 et 1991.

## Exemples

| Commune | 1984 | 2019 | 2026 | Explication |
|---|---|---|---|---|
| Adrar | `010101` | `010101` | `010101` | Chef-lieu de wilaya et de daïra |
| Blida | `090101` | `090101` | `090101` | Chef-lieu de wilaya et de daïra |
| Bouarfa | `090102` | `090102` | `090102` | 2e commune de la daïra de Blida |
| El Achour | `420803` | `160904` | `160904` | Tipaza en 1984, Alger depuis 1997 |
| El Aricha | `131802` | `131902` | `630101` | Chef-lieu de la nouvelle wilaya 63 en 2026 |
| Sidi M’Hamed | `160101` | `160101` | `160101` | Voir le cas d’Alger ci-dessous |

Un même code ne désigne donc **pas** la même commune d’une année à l’autre, et une même commune a en général des codes différents selon l’année. Pour suivre une commune dans le temps, il faut utiliser `oid` ou `IdCommune`.

## Cas particuliers

### Alger

Il n’existe pas de commune nommée « Alger ». La daïra n° `01` est celle qui contient **Alger Centre** : la daïra de Sidi M’Hamed. Sa commune chef-lieu, Sidi M’Hamed, reçoit `160101`, et Alger Centre `160102`.

### Daïras dont le siège ne porte pas le nom d’une commune

Certains sièges de daïra du décret 91-306 ne correspondent à aucune commune actuelle, en général parce que la commune a été renommée depuis :

| Siège dans le JO | Commune chef-lieu retenue |
|---|---|
| Aïn Hsainia (Guelma) | Houari Boumediène |
| Hamma Annassers (Alger) | Belouizdad |
| Silet Abalessa (Tamanrasset) | Abalessa |
| Ifri Ouzellaguène (Béjaïa) | Ouzellaguen |

### Daïras à cheval sur deux wilayas

Quand un nouveau découpage coupe une daïra en deux, chaque partie est numérotée dans sa propre wilaya :

- **El Aricha et El Gor** (daïra de Sebdou) sont dans la wilaya 63 en 2026. El Aricha, chef-lieu de la nouvelle wilaya, reçoit `630101`.
- **Hassi Fehal** (daïra de Mansourah) est dans la wilaya 58 depuis 2019.

### Rouissat

Absente du décret 91-306, Rouissat n’a pas de daïra de 1991. Pour `CdCommune_Gen_1984`, elle est placée **en dernier** dans la daïra d’Ouargla : `300102`.

## La règle du code figé

Un code qui change à chaque correction ne sert à rien. Les codes 2019 et 2026 ont donc été **générés une fois, puis figés** :

- une commune corrigée ou ajoutée reçoit un **nouveau code en fin de liste** ;
- **aucune autre commune n’est renumérotée** ;
- un code libéré **n’est jamais réattribué**.

Deux corrections ont été traitées ainsi :

| Commune | Correction | Ancien code | Nouveau code | Code libéré |
|---|---|---|---|---|
| Mansoura | El Meniaa (58) → Ghardaïa (47), selon la loi 19-12 | `580201` | `470801` (nouvelle daïra 08 de Ghardaïa) | `580201` |
| El Borma | Ouargla (30) → Touggourt (55), selon la loi 19-12 | `300201` | `550601` (nouvelle daïra 06 de Touggourt) | `300201` |

Le code 1984 a en revanche été **entièrement régénéré** lors de l’intégration du décret 91-306 et des corrections du Grand Alger, car sa première version reposait sur des rattachements faux. Il est figé depuis.

## Reproduire le calcul

Pseudo-code de la génération pour une année donnée :

```
pour chaque wilaya W :
    chef_wilaya  ← commune dont le nom correspond au nom de W
    daira_chef   ← daïra de chef_wilaya
    daïras       ← [daira_chef] + autres daïras de W triées (sans accents)
    pour chaque daïra D (rang d) :
        chef_daira ← commune chef-lieu de D (si identifiée)
        communes   ← [chef_daira] + autres communes de D triées (sans accents)
        pour chaque commune C (rang c) :
            code(C) ← W + format(d, "00") + format(c, "00")
```
