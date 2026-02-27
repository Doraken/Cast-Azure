# Guide de contribution - Cast-Azure

Merci de votre intérêt pour contribuer à Cast-Azure ! Ce document fournit les directives et bonnes pratiques pour contribuer au projet.

## Table des matières

- [Code de conduite](#code-de-conduite)
- [Comment contribuer](#comment-contribuer)
- [Standards de code](#standards-de-code)
- [Processus de développement](#processus-de-développement)
- [Tests](#tests)
- [Documentation](#documentation)

## Code de conduite

En participant à ce projet, vous vous engagez à respecter notre code de conduite :

- Soyez respectueux et inclusif
- Acceptez les critiques constructives
- Concentrez-vous sur ce qui est le mieux pour la communauté
- Faites preuve d'empathie envers les autres membres

## Comment contribuer

### Signaler un bug

Pour signaler un bug, créez une issue avec :

- **Titre descriptif** : Résumé clair du problème
- **Description détaillée** : Contexte et reproduction du bug
- **Environnement** : OS, version, configuration
- **Logs** : Extraits pertinents des logs d'erreur
- **Comportement attendu** : Ce qui devrait se passer
- **Comportement observé** : Ce qui se passe réellement

### Proposer une amélioration

Pour proposer une nouvelle fonctionnalité :

1. Vérifiez qu'elle n'existe pas déjà dans les issues
2. Créez une issue détaillant :
   - Le problème que cela résout
   - La solution proposée
   - Les alternatives considérées
   - L'impact sur la compatibilité

### Soumettre des modifications

1. **Forkez le projet**

   ```bash
   git clone https://github.com/yourusername/Cast-Azure.git
   cd Cast-Azure
   ```

2. **Créez une branche**

   ```bash
   git checkout -b feature/ma-fonctionnalite
   # ou
   git checkout -b fix/mon-correctif
   ```

3. **Faites vos modifications**

4. **Testez vos modifications**

   ```bash
   make check
   make test
   ```

5. **Commitez avec des messages clairs**

   ```bash
   git commit -m "feat: ajout de la fonction X pour Y"
   # ou
   git commit -m "fix: correction du bug dans la fonction Z"
   ```

6. **Poussez vers votre fork**

   ```bash
   git push origin feature/ma-fonctionnalite
   ```

7. **Créez une Pull Request**

## Standards de code

### Scripts Shell (.sh, .lib)

#### Format des headers

Tous les scripts doivent avoir un header standardisé :

```bash
#!/bin/bash
################################################################################
# Subject    : Description du script (max 66 caractères)                       #
# Author     : Votre Nom                                                       #
# Created on : JJ/MM/AAAA                                                      #
# Mail       : votre.email@example.com                                         #
################################################################################
# Extract from CAST framework - Property of Arnaud Crampet
################################################################################
```

#### Conventions de nommage

- **Variables globales** : `MAJUSCULES_AVEC_UNDERSCORES`
- **Variables locales** : `minuscules_avec_underscores` ou `_préfixe_local`
- **Fonctions** : `Nom_Function_Avec_Majuscules`
- **Fichiers** : `nom-descriptif.sh` ou `module.lib`

#### Style de code

```bash
# ✓ BON
function Ma_Fonction
{
#|# Description : Description de la fonction
#|# Var to set  : variable1 : Description
#|# Base usage  : Ma_Fonction "arg1" "arg2"
#|# Send Back   : Valeur de retour
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################

    local _variable_locale="${1}"
    local _autre_variable="${2}"

    # Code de la fonction
    # ...

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# ✗ MAUVAIS
function mafonction() {
    variable=$1
    # Pas de documentation
    # Pas de trace
}
```

#### Bonnes pratiques Shell

1. **Toujours citer les variables**

   ```bash
   # ✓ BON
   echo "${mon_variable}"
   
   # ✗ MAUVAIS
   echo $mon_variable
   ```

2. **Utiliser des variables locales**

   ```bash
   # ✓ BON
   function Ma_Fonction
   {
       local _var_locale="${1}"
   }
   
   # ✗ MAUVAIS
   function ma_fonction
   {
       var_globale=$1
   }
   ```

3. **Vérifier les codes de retour**

   ```bash
   # ✓ BON
   commande
   CTRL_Result_func "${?}" "description" "Failled" "0" "" ""
   
   # ✗ MAUVAIS
   commande  # Pas de vérification
   ```

4. **Utiliser les fonctions CAST**

   ```bash
   # Utiliser les fonctions du framework
   MSG_DISPLAY "Info" "Message d'information"
   MSG_DISPLAY "ErrorN" "Message d'erreur" "1"
   Directory_CRT "/chemin/repertoire"
   CTRL_Result_func "${?}" "operation" "Failled" "0" "" ""
   ```

### Modules de sécurité

#### Structure d'une règle de sécurité

```bash
function CIS_1.2.3_Ma_Regle
{
#|# Description : Application de la règle CIS 1.2.3
#|# Var to set  : Aucune
#|# Base usage  : CIS_1.2.3_Ma_Regle "check|apply"
#|# Send Back   : Message de conformité
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################

    local _mode="${1:-check}"
    local _rule_num="1.2.3"
    
    MSG_DISPLAY "Info" "Rule : ${_rule_num} - Ma Règle"
    
    case "${_mode}" in
        "check")
            # Vérification de conformité
            # ...
            ;;
        "apply")
            # Application de la règle
            # ...
            ;;
    esac

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}
```

## Processus de développement

### Configuration de l'environnement

```bash
# Cloner le projet
git clone https://github.com/yourusername/Cast-Azure.git
cd Cast-Azure

# Installer les dépendances de développement
make install

# Configurer les hooks pre-commit
make setup
```

### Workflow de développement

1. **Créer une branche**

   ```bash
   git checkout -b feature/nom-de-la-fonctionnalite
   ```

2. **Développer et tester**

   ```bash
   # Après chaque modification
   make lint
   make security
   make test
   ```

3. **Pre-commit automatique**

   Les hooks pre-commit s'exécutent automatiquement :
   - Détection de secrets (detect-secrets, gitleaks)
   - Validation shell (shellcheck)
   - Validation YAML (yamllint)
   - Formatage des fichiers
   - Validation des commits (conventional commits)

4. **Commit**

   ```bash
   git add .
   git commit -m "feat: description de la fonctionnalité"
   ```

   Format des messages : `type: description`

   Types valides :
   - `feat` : Nouvelle fonctionnalité
   - `fix` : Correction de bug
   - `docs` : Documentation uniquement
   - `style` : Formatage, points-virgules manquants, etc.
   - `refactor` : Refactoring de code
   - `perf` : Amélioration des performances
   - `test` : Ajout ou correction de tests
   - `chore` : Tâches de maintenance

## Tests

### Tests de syntaxe

```bash
# Test de syntaxe shell
make test
```

### Tests manuels

Pour tester votre module de sécurité :

```bash
# Mode check (vérification uniquement)
source lib/security/security_X.lib
CIS_X.Y.Z_Ma_Regle "check"

# Mode apply (application)
sudo CIS_X.Y.Z_Ma_Regle "apply"
```

### Validation complète

```bash
# Toutes les vérifications avant commit
make validate
```

## Documentation

### Documentation du code

- **Toutes les fonctions** doivent avoir un header de documentation
- **Commentaires** : Expliquez le "pourquoi", pas le "quoi"
- **Exemples** : Fournissez des exemples d'utilisation

### Documentation README

Mettez à jour le README.md si vos modifications :

- Ajoutent une nouvelle fonctionnalité
- Modifient l'installation ou la configuration
- Changent l'utilisation du script

### Documentation des règles CIS

Pour chaque nouvelle règle de sécurité, documentez :

- **Numéro de règle CIS** : ex: 1.2.3
- **Description** : Ce que la règle vérifie/applique
- **Impact** : Niveau de criticité
- **Prérequis** : Dépendances ou configurations nécessaires

## Questions et support

Si vous avez des questions :

- Créez une issue avec le tag `question`
- Contactez : <arnaud@crampet.net>

## Licence

En contribuant à Cast-Azure, vous acceptez que vos contributions soient sous la même licence que le projet.

## Remerciements

Merci de contribuer à améliorer la sécurité des systèmes Linux !
