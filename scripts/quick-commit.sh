#!/bin/bash

# Script pour des commits rapides
# Usage: ./scripts/quick-commit.sh <type> <message>
# Exemple: ./scripts/quick-commit.sh feat "add linux desktop integration"

if [ $# -lt 2 ]; then
    echo "❌ Usage: $0 <type> <message>"
    echo ""
    echo "Types disponibles:"
    echo "  feat     - Nouvelle fonctionnalité"
    echo "  fix      - Correction de bug"
    echo "  docs     - Documentation"
    echo "  style    - Formatage"
    echo "  refactor - Refactoring"
    echo "  test     - Tests"
    echo "  chore    - Maintenance"
    echo "  perf     - Performance"
    echo "  ci       - CI/CD"
    echo "  build    - Build"
    echo "  revert   - Annulation"
    echo ""
    echo "Exemples:"
    echo "  $0 feat 'add linux desktop integration'"
    echo "  $0 fix 'hide noVNC toolbar'"
    echo "  $0 docs 'update README'"
    exit 1
fi

commit_type=$1
shift
message="$*"

# Validation du type
valid_types=("feat" "fix" "docs" "style" "refactor" "test" "chore" "perf" "ci" "build" "revert")

if [[ ! " ${valid_types[@]} " =~ " ${commit_type} " ]]; then
    echo "❌ Type invalide: $commit_type"
    echo "Types valides: ${valid_types[*]}"
    exit 1
fi

# Construire le message de commit
commit_msg="$commit_type: $message"

# Afficher ce qui va être fait
echo "📝 Commit: $commit_msg"
echo ""

# Demander confirmation
read -p "Confirmer le commit ? (y/N): " confirm

if [[ $confirm =~ ^[Yy]$ ]]; then
    git add .
    git commit -m "$commit_msg"
    echo "✅ Commit créé avec succès!"
else
    echo "❌ Commit annulé."
    exit 1
fi 