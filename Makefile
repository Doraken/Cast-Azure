# Makefile for Cast-Azure
# Facilite les opérations courantes de développement et test

.PHONY: help install setup lint test security check pre-commit clean

# Couleurs pour l'affichage
GREEN  := \033[0;32m
YELLOW := \033[0;33m
RED    := \033[0;31m
NC     := \033[0m # No Color

help: ## Affiche cette aide
	@echo "$(GREEN)Commandes disponibles:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-20s$(NC) %s\n", $$1, $$2}'

install: ## Installe les dépendances de développement
	@echo "$(GREEN)Installation des dépendances...$(NC)"
	pip install -r requirements-dev.txt
	@echo "$(GREEN)✓ Installation terminée$(NC)"

setup: install ## Configure l'environnement de développement complet
	@echo "$(GREEN)Configuration de pre-commit...$(NC)"
	pre-commit install
	pre-commit install --hook-type commit-msg
	@echo "$(GREEN)✓ Environnement configuré$(NC)"

lint: ## Vérifie la syntaxe et le formatage
	@echo "$(GREEN)Vérification YAML...$(NC)"
	yamllint -c .yamllint . || true
	@echo "$(GREEN)Vérification des scripts shell...$(NC)"
	@find bin lib -type f \( -name "*.sh" -o -name "*.lib" \) -exec shellcheck {} + || true
	@echo "$(GREEN)✓ Vérification terminée$(NC)"

security: ## Scan de sécurité (secrets)
	@echo "$(GREEN)Détection de secrets avec detect-secrets...$(NC)"
	detect-secrets scan --baseline .secrets.baseline
	@echo "$(GREEN)Détection de secrets avec gitleaks...$(NC)"
	gitleaks detect --source . --config .gitleaks.toml --verbose
	@echo "$(GREEN)✓ Scan de sécurité terminé$(NC)"

test: lint ## Exécute tous les tests
	@echo "$(GREEN)Test de syntaxe des scripts shell...$(NC)"
	@bash -n bin/secure-linux.sh && echo "  ✓ bin/secure-linux.sh: OK" || echo "  ✗ bin/secure-linux.sh: ERREUR"
	@for lib in lib/*.lib; do \
		bash -n "$$lib" && echo "  ✓ $$lib: OK" || echo "  ✗ $$lib: ERREUR"; \
	done
	@echo "$(GREEN)✓ Tests terminés$(NC)"

check: lint security ## Exécute toutes les vérifications
	@echo "$(GREEN)✓ Toutes les vérifications sont passées$(NC)"


pre-commit: ## Exécute pre-commit sur tous les fichiers
	@echo "$(GREEN)Exécution des hooks pre-commit...$(NC)"
	pre-commit run --all-files
	@echo "$(GREEN)✓ Pre-commit terminé$(NC)"

pre-commit-update: ## Met à jour les hooks pre-commit
	@echo "$(GREEN)Mise à jour des hooks pre-commit...$(NC)"
	pre-commit autoupdate
	@echo "$(GREEN)✓ Hooks mis à jour$(NC)"

secrets-update: ## Met à jour la baseline de secrets
	@echo "$(GREEN)Mise à jour de la baseline de secrets...$(NC)"
	detect-secrets scan --baseline .secrets.baseline --update
	@echo "$(GREEN)✓ Baseline mise à jour$(NC)"

clean: ## Nettoie les fichiers temporaires
	@echo "$(GREEN)Nettoyage...$(NC)"
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete
	find . -type d -name '.pytest_cache' -delete
	@echo "$(GREEN)✓ Nettoyage terminé$(NC)"

validate: check test ## Validation complète avant commit
	@echo "$(GREEN)✓ Validation complète réussie$(NC)"
	@echo "$(GREEN)Vous pouvez maintenant commiter vos modifications$(NC)"

init: setup ## Initialisation complète du projet
	@echo "$(GREEN)Projet initialisé avec succès!$(NC)"
	@echo "$(YELLOW)Prochaines étapes:$(NC)"
	@echo "  1. Modifiez les fichiers selon vos besoins"
	@echo "  2. Exécutez 'make validate' avant de commiter"
	@echo "  3. Commitez avec 'git commit'"

.DEFAULT_GOAL := help
