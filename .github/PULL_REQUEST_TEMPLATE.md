## Description

<!-- Décrivez clairement les modifications apportées -->

## Type de modification

<!-- Cochez les cases appropriées -->

- [ ] 🐛 Correction de bug (fix)
- [ ] ✨ Nouvelle fonctionnalité (feature)
- [ ] 📝 Documentation
- [ ] 🔧 Refactoring / Amélioration de code
- [ ] ⚡ Amélioration de performance
- [ ] ✅ Ajout de tests
- [ ] 🔒 Sécurité / Nouvelle règle CIS

## Problème résolu

<!-- Si applicable, référencez l'issue associée -->

Fixes #(numéro de l'issue)

## Modifications apportées

<!-- Listez les principales modifications -->

- 
- 
- 

## Tests effectués

<!-- Décrivez les tests que vous avez effectués -->

- [ ] Tests de syntaxe Shell (`bash -n script.sh`)
- [ ] Tests shellcheck
- [ ] Tests yamllint
- [ ] Scan de sécurité (detect-secrets, gitleaks)
- [ ] Tests pre-commit
- [ ] Tests en environnement de développement
- [ ] Tests sur RedHat/CentOS 7.6+

### Commandes exécutées

```bash
# Ajoutez les commandes de test que vous avez exécutées
make validate
make test
```

## Checklist

<!-- Vérifiez que toutes les cases sont cochées avant de soumettre la PR -->

- [ ] J'ai testé mes modifications
- [ ] Mon code respecte les conventions du projet (headers, nommage, etc.)
- [ ] J'ai mis à jour la documentation si nécessaire
- [ ] J'ai ajouté/mis à jour les tests si nécessaire
- [ ] Les hooks pre-commit passent sans erreur
- [ ] Les tests de sécurité (secrets) passent
- [ ] J'ai vérifié qu'il n'y a pas de régression
- [ ] Les fonctions ont un header de documentation complet
- [ ] Les scripts utilisent les fonctions CAST appropriées
- [ ] J'ai testé le mode "check" et "apply" si applicable

## Environnement de test

<!-- Sur quel(s) environnement(s) avez-vous testé ? -->

- **OS** : RedHat / CentOS / AlmaLinux / Rocky Linux
- **Version OS** : 7.6 / 8.x / 9.x
- **Bash version** :


## Captures d'écran / Logs

<!-- Si applicable, ajoutez des captures d'écran ou des extraits de logs -->

```bash
# Coller les logs pertinents ici
```

## Impact

<!-- Décrivez l'impact de ces modifications -->

- [ ] Aucun impact sur les configurations existantes
- [ ] Nécessite une migration de configuration
- [ ] Peut casser la compatibilité ascendante
- [ ] Nécessite une mise à jour de la documentation
- [ ] Modifie des règles de sécurité existantes

### Breaking changes

<!-- Si applicable, décrivez les breaking changes et comment les gérer -->

## Notes pour les reviewers

<!-- Informations supplémentaires pour faciliter la review -->

## Checklist pour les mainteneurs

<!-- Ne pas modifier - Pour les mainteneurs uniquement -->

- [ ] Code review effectuée
- [ ] Tests passent en CI/CD
- [ ] Documentation à jour
- [ ] Version mise à jour si nécessaire


- [ ] Code review effectuée
- [ ] Tests CI/CD passent
- [ ] Documentation à jour
- [ ] Changelog mis à jour
- [ ] Version incrémentée si nécessaire
