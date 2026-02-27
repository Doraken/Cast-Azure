# Cast-Azure - Linux Security Hardening Framework

[![License](https://img.shields.io/badge/license-Proprietary-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.5-green.svg)](https://github.com/yourusername/Cast-Azure)
[![Platform](https://img.shields.io/badge/platform-Linux-lightgrey.svg)](README.md)

Framework automatisé de sécurisation Linux basé sur CAST et les standards CIS (Center for Internet Security).

## Vue d'ensemble

Cast-Azure est un framework complet de sécurisation pour systèmes Linux (RedHat/CentOS 7.6+) qui implémente les meilleures pratiques de sécurité basées sur les benchmarks CIS. Il permet d'auditer et d'appliquer automatiquement des configurations de sécurité sur vos serveurs Linux.

### Caractéristiques principales

- ✅ **Conformité CIS** : Implémentation automatisée des standards CIS Linux Benchmark
- 🔍 **Audit de sécurité** : Vérification de la conformité aux règles de sécurité
- 🛡️ **Application automatique** : Application des configurations de sécurité
- 📊 **Rapports détaillés** : Génération de rapports HTML de conformité
- 🔧 **Modulaire** : Architecture basée sur des modules de sécurité (niveaux 1-8)
- 📝 **Extensible** : Bibliothèques de fonctions réutilisables

## Architecture

```text
Cast-Azure/
├── bin/                    # Scripts exécutables
│   └── secure-linux.sh    # Script principal de sécurisation
├── lib/                    # Bibliothèques de fonctions
│   ├── CIS-sec/           # Règles CIS spécifiques
│   │   ├── CIS_1.lib      # CIS Benchmark Section 1
│   │   └── CIS_2.lib      # CIS Benchmark Section 2
│   ├── security/          # Modules de sécurité par niveaux
│   │   ├── security_1.lib # Niveau de sécurité 1 (critique)
│   │   ├── security_2.lib # Niveau de sécurité 2
│   │   └── ...            # Niveaux 3-8
│   ├── common.lib         # Fonctions communes
│   ├── directory.lib      # Gestion des répertoires
│   ├── file.lib           # Gestion des fichiers
│   ├── yum.lib            # Gestion des packages YUM
│   ├── lvm_device.lib     # Gestion LVM
│   └── sanitycheck.lib    # Vérifications de santé
├── conf/                   # Configuration
│   └── config.cnf         # Configuration globale
├── data/                   # Données et templates
│   ├── def/               # Définitions
│   ├── doc/               # Documentation générée
│   ├── templates/         # Templates de configuration
│   └── xml/               # Définitions XML
└── logs/                   # Journaux d'exécution
```

## Prérequis

- **Système d'exploitation** : RedHat/CentOS 7.6+ (compatible AlmaLinux/Rocky Linux)
- **Droits** : Accès root (sudo)
- **Packages** : wget, unzip
- **Espace disque** : Au moins 100 Mo disponibles dans `/srv/admin/scripts`

## Installation

### Installation rapide

```bash
#!/bin/bash
VERSION="1.0.5"

# Installation des dépendances
sudo yum install wget unzip -y

# Nettoyage des versions précédentes
sudo rm -rf /tmp/SEC-LNX* /tmp/*.zip*

# Téléchargement de la dernière version
cd /tmp
wget https://inari.crampet.net/doraken/SEC-LNX/archive/v${VERSION}.zip
unzip /tmp/v${VERSION}.zip

# Installation dans /srv/admin/scripts
sudo rm -rf /srv/admin/scripts
sudo mkdir --parent /srv/admin/scripts/
sudo mv /tmp/SEC-LNX-v${VERSION}/* /srv/admin/scripts/
sudo chmod +x /srv/admin/scripts/bin/secure-linux.sh

echo "Installation terminée dans /srv/admin/scripts"
```

### Installation depuis le dépôt Git

```bash
git clone https://github.com/yourusername/Cast-Azure.git
cd Cast-Azure
sudo cp -r * /srv/admin/scripts/
sudo chmod +x /srv/admin/scripts/bin/secure-linux.sh
```

## Configuration

### Fichier de configuration principal

Éditez `/srv/admin/scripts/conf/config.cnf` pour personnaliser :

- Niveaux de sécurité à appliquer
- Exclusions spécifiques
- Paramètres de journalisation
- Configuration réseau (NTP, DNS, etc.)

### Exemple de configuration

```bash
# Activer/désactiver les niveaux de sécurité
ENABLE_LEVEL_1=true
ENABLE_LEVEL_2=true
ENABLE_LEVEL_3=true

# Serveur NTP
NTP_SERVER="51.15.177.17"

# Niveau de debug (0-9)
DEBUG_LEVEL=9
```

## Utilisation

### Mode complet (audit + application)

```bash
sudo /srv/admin/scripts/bin/secure-linux.sh
```

### Rapport de conformité

Après exécution, un rapport HTML détaillé est généré :

- **Emplacement** : `/tmp/report.html`
- **Contenu** : État de conformité pour chaque règle de sécurité
- **Format** : Tableau HTML avec numéro de chapitre, élément de sécurité et statut

### Vérification du rapport

```bash
# Ouvrir le rapport dans Firefox
firefox /tmp/report.html &

# Ou copier le rapport pour analyse
cp /tmp/report.html ~/security-report-$(date +%Y%m%d).html
```

## Règles de sécurité couvertes

Cast-Azure implémente plusieurs catégories de règles de sécurité CIS :

### Niveau 1 - Critique

- Configuration du bootloader (mot de passe GRUB)
- Vérifications des filesystems critiques (/tmp, /var, /var/log, /home)
- Validation GPG pour YUM
- Désactivation des services non nécessaires

### Niveaux 2-8

- Configuration réseau et pare-feu
- Gestion des utilisateurs et permissions
- Configuration SSH sécurisée
- Audit et journalisation
- Configuration du noyau
- Contrôles d'accès

## Modules de bibliothèques

### Bibliothèques système

| Bibliothèque       | Description                               |
| ------------------ | ----------------------------------------- |
| `common.lib`       | Fonctions utilitaires communes            |
| `directory.lib`    | Gestion avancée des répertoires           |
| `file.lib`         | Opérations sur les fichiers               |
| `yum.lib`          | Gestion des packages YUM/DNF              |
| `lvm_device.lib`   | Gestion des volumes logiques              |
| `sanitycheck.lib`  | Vérifications de cohérence système        |

### Bibliothèques de sécurité

| Module           | Périmètre                                    |
|------------------|----------------------------------------------|
| `security_1.lib` | Règles critiques de sécurité système         |
| `security_2.lib` | Configuration réseau et services             |
| `security_3.lib` | Gestion des accès et authentification        |
| `security_4.lib` | Audit et journalisation                      |
| `security_5.lib` | Configuration du noyau                       |
| `security_6.lib` | Contrôles d'intégrité                        |
| `security_7.lib` | Règles avancées                              |
| `security_8.lib` | Conformité et reporting                      |


## Développement

### Prérequis développement

```bash
# Installer les dépendances de développement
pip install -r requirements-dev.txt

# Configurer les hooks pre-commit
make setup
```

### Tests et vérifications

```bash
# Vérification syntaxique des scripts shell
make lint

# Scan de sécurité (détection de secrets)
make security

# Toutes les vérifications
make check
```

### Structure d'une fonction CAST

```bash
function My_Function
{
#|# Description : Description de la fonction
#|#
#|# Var to set  : Variable1 : Description
#|#               Variable2 : Description
#|#
#|# Base usage  : My_Function "arg1" "arg2"
#|#
#|# Send Back   : Valeur de retour
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ]"

# Implémentation de la fonction
# ...

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}
```

## Sécurité

### Détection de secrets

Ce projet utilise plusieurs outils de détection de secrets :

- **detect-secrets** : Détection heuristique de secrets
- **gitleaks** : Scan avec patterns de secrets connus
- **pre-commit hooks** : Validation avant chaque commit

### Commandes de sécurité

```bash
# Scan complet de sécurité
make security

# Mise à jour de la baseline detect-secrets
detect-secrets scan --update .secrets.baseline

# Scan gitleaks manuel
gitleaks detect --source . --config .gitleaks.toml --verbose
```

## Journalisation

Les logs d'exécution sont stockés dans :

- **Chemin** : `/var/log/secure-linux/`
- **Format** : Horodatage, niveau, message
- **Rotation** : Automatique via logrotate

## Dépannage

### Erreur "CNF_SRC" non défini

```bash
# Vérifier que le fichier de configuration existe
ls -l /srv/admin/scripts/conf/config.cnf

# Vérifier les permissions
sudo chmod 644 /srv/admin/scripts/conf/config.cnf
```

### Échec d'application d'une règle

Consultez le rapport HTML `/tmp/report.html` pour identifier la règle en échec et les logs système.

## Licence et propriété

- **Framework CAST** : Propriété exclusive de Arnaud Crampet
- **Module Cast-Azure** : Arnaud Crampet / Doraken
- **Contact** : <arnaud@crampet.net>

## Contribution

Voir [CONTRIBUTING.md](CONTRIBUTING.md) pour les directives de contribution.

## Support

- **Email** : <arnaud@crampet.net>
- **Documentation** : Voir le répertoire `data/doc/`


## Changelog

### Version 1.0.5 (actuelle)

- Implémentation complète des niveaux de sécurité 1-8
- Support RedHat/CentOS 7.6+
- Génération de rapports HTML
- Architecture modulaire

## Ressources

- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)
- [RedHat Security Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/)
- [CAST Framework Documentation](data/doc/)

---

**Développé par** : Arnaud Crampet (Doraken)  
**Copyright** : © 2018-2026 Arnaud Crampet  
**Version** : 1.0.5
