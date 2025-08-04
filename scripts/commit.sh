#!/bin/bash

# Script pour faire des commits conventionnels
# Usage: ./scripts/commit.sh

echo "🚀 Conventional Commit Helper"
echo "=============================="

# Demander le type de commit
echo ""
echo "Choisis le type de commit :"
echo "1) feat:     Nouvelle fonctionnalité"
echo "2) fix:      Correction de bug"
echo "3) docs:     Documentation"
echo "4) style:    Formatage, points-virgules manquants, etc."
echo "5) refactor: Refactoring du code"
echo "6) test:     Ajout de tests"
echo "7) chore:    Maintenance, dépendances, etc."
echo "8) perf:     Amélioration des performances"
echo "9) ci:       Configuration CI/CD"
echo "10) build:   Build ou outils de build"
echo "11) revert:  Annulation d'un commit précédent"
echo ""

read -p "Entrez le numéro du type (1-11): " type_choice

# Mapping des choix vers les types
case $type_choice in
    1) commit_type="feat" ;;
    2) commit_type="fix" ;;
    3) commit_type="docs" ;;
    4) commit_type="style" ;;
    5) commit_type="refactor" ;;
    6) commit_type="test" ;;
    7) commit_type="chore" ;;
    8) commit_type="perf" ;;
    9) commit_type="ci" ;;
    10) commit_type="build" ;;
    11) commit_type="revert" ;;
    *) echo "❌ Choix invalide. Utilisation de 'chore' par défaut."; commit_type="chore" ;;
esac

echo ""
echo "Type choisi: $commit_type"

# Demander la portée (optionnel)
echo ""
read -p "Portée (optionnel, ex: auth, ui, api): " scope

# Construire le préfixe
if [ -n "$scope" ]; then
    prefix="$commit_type($scope)"
else
    prefix="$commit_type"
fi

# Demander le message
echo ""
read -p "Message de commit: " message

# Construire le message complet
if [ -n "$message" ]; then
    full_message="$prefix: $message"
else
    echo "❌ Message requis!"
    exit 1
fi

# Demander la description (optionnel)
echo ""
read -p "Description détaillée (optionnel): " description

# Construire le message final
if [ -n "$description" ]; then
    commit_msg="$full_message

$description"
else
    commit_msg="$full_message"
fi

# Afficher le commit qui va être fait
echo ""
echo "📝 Commit qui va être créé :"
echo "=============================="
echo "$commit_msg"
echo "=============================="

# Demander confirmation
echo ""
read -p "Confirmer le commit ? (y/N): " confirm

if [[ $confirm =~ ^[Yy]$ ]]; then
    # Faire le commit
    git add .
    git commit -m "$commit_msg"
    echo "✅ Commit créé avec succès!"
else
    echo "❌ Commit annulé."
    exit 1
fi 