# Guide de démarrage rapide - Cast-Azure

Ce guide vous permet de démarrer rapidement avec Cast-Azure pour sécuriser vos systèmes Linux.

## Installation en 2 minutes

### Prérequis

- RedHat/CentOS 7.6+ (ou compatible AlmaLinux/Rocky Linux)
- Accès root (sudo)
- Connexion Internet

### Installation rapide

```bash
#!/bin/bash
VERSION="1.0.5"

# 1. Installer les dépendances
sudo yum install wget unzip -y

# 2. Télécharger Cast-Azure
cd /tmp
wget https://inari.crampet.net/doraken/SEC-LNX/archive/v${VERSION}.zip
unzip v${VERSION}.zip

# 3. Installer dans /srv/admin/scripts
sudo mkdir -p /srv/admin/scripts/
sudo mv SEC-LNX-v${VERSION}/* /srv/admin/scripts/
sudo chmod +x /srv/admin/scripts/bin/secure-linux.sh

# 4. Lancer le script de sécurisation
sudo /srv/admin/scripts/bin/secure-linux.sh
```

## Première utilisation

### 1. Exécution du script principal

```bash
# Lancer la sécurisation complète
sudo /srv/admin/scripts/bin/secure-linux.sh
```

Le script va :

- ✅ Vérifier les filesystems critiques (/tmp, /var, /var/log, /home)
- ✅ Configurer le bootloader GRUB avec un mot de passe
- ✅ Activer la vérification GPG pour YUM
- ✅ Appliquer les règles CIS de sécurité (niveaux 1-8)
- ✅ Générer un rapport HTML de conformité

### 2. Consulter le rapport

```bash
# Ouvrir le rapport dans Firefox
firefox /tmp/report.html &

# Ou transférer le rapport pour analyse
scp /tmp/report.html user@votre-poste:~/
```

### 3. Interpréter les résultats

Le rapport HTML contient :

| Colonne         | Description                              |
|-----------------|------------------------------------------|
| Num chapter     | Numéro de la règle CIS                   |
| Security Element| Description de la règle de sécurité      |
| Status          | OK (✓) ou ERROR (✗)                      |

## Configuration de base

### Personnaliser la configuration

Éditez le fichier de configuration principal :

```bash
sudo vi /srv/admin/scripts/conf/config.cnf
```

### Paramètres importants

```bash
# Niveaux de sécurité (true/false)
ENABLE_LEVEL_1=true    # Critique - Obligatoire
ENABLE_LEVEL_2=true    # Recommandé
ENABLE_LEVEL_3=true    # Optionnel
ENABLE_LEVEL_4=true    # Optionnel
ENABLE_LEVEL_5=true    # Avancé
ENABLE_LEVEL_6=true    # Avancé
ENABLE_LEVEL_7=true    # Avancé
ENABLE_LEVEL_8=true    # Reporting

# Serveur NTP
NTP_SERVER="51.15.177.17"

# Niveau de debug (0-9)
# 0 = Aucun debug
# 9 = Très verbeux
DEBUG_LEVEL=5

# Chemin des scripts
Base_Dir_Scripts="/srv/admin/scripts"
Base_Dir_Scripts_Lib="${Base_Dir_Scripts}/lib"

# Fichier de log
logfile="/var/log/secure-linux/$(date +%Y%m%d-%H%M%S).log"
```

## Cas d'usage courants

### 1. Audit de sécurité (sans modification)

Pour vérifier la conformité sans appliquer de modifications :

```bash
# Source les bibliothèques
source /srv/admin/scripts/conf/config.cnf
source /srv/admin/scripts/lib/security/security_1.lib

# Vérifier une règle spécifique en mode check
CIS_1.2.3_Ma_Regle "check"
```

### 2. Sécurisation automatique complète

```bash
# Application de toutes les règles
sudo /srv/admin/scripts/bin/secure-linux.sh
```

### 3. Application d'un niveau de sécurité spécifique

```bash
# Source les configurations
source /srv/admin/scripts/conf/config.cnf

# Appliquer uniquement le niveau 1 (critique)
for Secure in $(cat ${Base_Dir_Scripts_Lib}/security/security_1.lib | \
                grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }')
do
    ${Secure} "apply"
done
```

### 4. Vérification d'une règle spécifique

```bash
# Exemple : Vérifier la configuration GRUB
source /srv/admin/scripts/lib/security/security_1.lib
Set_Boot_Loader_Password
```

## Règles de sécurité principales

### Niveau 1 - Critique

| Règle      | Description                                     | Impact  |
|------------|-------------------------------------------------|---------|
| 1.1.x      | Configuration des filesystems                   | Élevé   |
| 1.2.x      | Configuration du bootloader                     | Élevé   |
| 1.3.x      | Vérification GPG pour les packages              | Moyen   |
| 1.6.2      | Mot de passe bootloader GRUB                    | Élevé   |

### Niveau 2 - Réseau et Services

| Règle      | Description                                     | Impact  |
|------------|-------------------------------------------------|---------|
| 2.x.x      | Désactivation des services non nécessaires      | Moyen   |
| 3.x.x      | Configuration réseau sécurisée                  | Moyen   |

### Niveaux 3-8 - Avancés

- **Niveau 3** : Gestion des accès et authentification
- **Niveau 4** : Audit et journalisation
- **Niveau 5** : Configuration du noyau
- **Niveau 6** : Contrôles d'intégrité
- **Niveau 7** : Règles avancées
- **Niveau 8** : Conformité et reporting

## Dépannage rapide

### Problème : "CNF_SRC non défini"

```bash
# Solution : vérifier le fichier de configuration
ls -l /srv/admin/scripts/conf/config.cnf
sudo chmod 644 /srv/admin/scripts/conf/config.cnf
```

### Problème : "Permission denied"

```bash
# Solution : vérifier les permissions
sudo chmod +x /srv/admin/scripts/bin/secure-linux.sh
```

### Problème : "Command not found"

```bash
# Solution : installer les dépendances manquantes
sudo yum install wget unzip -y
```

### Problème : Une règle échoue

1. Consulter le rapport HTML `/tmp/report.html`
2. Identifier la règle en échec
3. Vérifier les logs :

   ```bash
   sudo tail -f /var/log/secure-linux/*.log
   ```

4. Appliquer manuellement la règle en mode debug :

   ```bash
   DEBUG_LEVEL=9
   source /srv/admin/scripts/lib/security/security_X.lib
   Nom_De_La_Regle "apply"
   ```

## Commandes utiles

### Vérification système

```bash
# Vérifier les filesystems montés
mount | grep -E "/tmp|/var|/home"

# Vérifier les services actifs
systemctl list-units --type=service --state=running

# Vérifier la configuration GRUB
cat /boot/grub2/user.cfg
```

### Journalisation

```bash
# Voir les logs du dernier run
sudo tail -100 /var/log/secure-linux/*.log

# Suivre les logs en temps réel
sudo tail -f /var/log/secure-linux/*.log

# Rechercher les erreurs
sudo grep -i error /var/log/secure-linux/*.log
```

### Sauvegarde

```bash
# Sauvegarder la configuration
sudo tar -czf /tmp/cast-azure-backup-$(date +%Y%m%d).tar.gz \
    /srv/admin/scripts/conf/

# Sauvegarder un fichier avant modification (automatique)
# Cast-Azure crée automatiquement des backups : fichier.bak
```

## Développement et contribution

### Configuration de l'environnement de développement

```bash
# Cloner le projet
git clone https://github.com/yourusername/Cast-Azure.git
cd Cast-Azure

# Installer les dépendances de développement
make install

# Configurer les hooks pre-commit
make setup
```

### Tests avant commit

```bash
# Vérification complète
make validate

# Tests individuels
make lint        # Vérification syntaxe
make security    # Scan de sécurité
make test        # Tests unitaires
```

## Ressources supplémentaires

- 📖 **Documentation complète** : [README.md](README.md)
- 🤝 **Guide de contribution** : [CONTRIBUTING.md](CONTRIBUTING.md)
- 🔒 **Standards CIS** : <https://www.cisecurity.org/cis-benchmarks/>
- 📧 **Support** : <arnaud@crampet.net>

## Prochaines étapes

1. ✅ Installer Cast-Azure
2. ✅ Exécuter le script de sécurisation
3. ✅ Consulter le rapport de conformité
4. 📝 Personnaliser la configuration selon vos besoins
5. 🔄 Planifier des exécutions régulières (cron)
6. 📊 Monitorer les résultats et ajuster

### Planifier l'exécution automatique

```bash
# Ajouter à cron pour exécution mensuelle
sudo crontab -e

# Ajouter cette ligne :
# Exécution le 1er de chaque mois à 2h00
0 2 1 * * /srv/admin/scripts/bin/secure-linux.sh
```

---

**Besoin d'aide ?** Consultez [README.md](README.md) ou contactez <arnaud@crampet.net>
