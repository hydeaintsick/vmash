# Conventional Commits - Guide d'utilisation

## 🚀 Scripts disponibles

### 1. Commit interactif complet

```bash
npm run commit
# ou
./scripts/commit.sh
```

**Fonctionnalités :**

- Menu interactif pour choisir le type
- Portée optionnelle (ex: `feat(auth)`, `fix(ui)`)
- Description détaillée optionnelle
- Confirmation avant commit

### 2. Commit rapide

```bash
npm run commit:quick <type> <message>
# ou
./scripts/quick-commit.sh <type> <message>
```

**Exemples :**

```bash
npm run commit:quick feat "add linux desktop integration"
npm run commit:quick fix "hide noVNC toolbar"
npm run commit:quick docs "update README"
npm run commit:quick chore "update dependencies"
```

## 📋 Types de commits

| Type       | Description                      | Exemple                                |
| ---------- | -------------------------------- | -------------------------------------- |
| `feat`     | Nouvelle fonctionnalité          | `feat: add linux desktop integration`  |
| `fix`      | Correction de bug                | `fix: hide noVNC toolbar`              |
| `docs`     | Documentation                    | `docs: update README`                  |
| `style`    | Formatage, points-virgules, etc. | `style: fix indentation`               |
| `refactor` | Refactoring du code              | `refactor: simplify desktop component` |
| `test`     | Ajout de tests                   | `test: add status API tests`           |
| `chore`    | Maintenance, dépendances         | `chore: update dependencies`           |
| `perf`     | Amélioration des performances    | `perf: optimize iframe loading`        |
| `ci`       | Configuration CI/CD              | `ci: add GitHub Actions`               |
| `build`    | Build ou outils de build         | `build: update Docker config`          |
| `revert`   | Annulation d'un commit           | `revert: remove experimental feature`  |

## 🎯 Portées (optionnel)

Vous pouvez ajouter une portée pour préciser le contexte :

```bash
feat(ui): add desktop launch button
fix(api): resolve status endpoint issue
docs(readme): update installation guide
chore(deps): update Next.js to 15.0.0
```

## 📝 Exemples de commits

### Commit simple

```bash
npm run commit:quick feat "add linux desktop integration"
```

### Commit avec portée

```bash
npm run commit:quick feat "add desktop launch button" ui
```

### Commit interactif complet

```bash
npm run commit
# Puis suivre les instructions
```

## 🔧 Configuration

Les scripts sont automatiquement ajoutés au `package.json` :

```json
{
  "scripts": {
    "commit": "./scripts/commit.sh",
    "commit:quick": "./scripts/quick-commit.sh"
  }
}
```

## 💡 Conseils

1. **Utilisez des verbes à l'impératif** : `add`, `fix`, `update`, `remove`
2. **Soyez concis** : Un message court et clair
3. **Utilisez la portée** : Pour préciser le contexte (`ui`, `api`, `auth`, etc.)
4. **Testez vos scripts** : `npm run commit:quick feat "test commit"`

## 🎉 Avantages

- ✅ **Convention standardisée** : Compatible avec Semantic Versioning
- ✅ **Historique propre** : Commits lisibles et organisés
- ✅ **Automatisation** : Scripts pour éviter les erreurs
- ✅ **Flexibilité** : Commits rapides ou détaillés selon les besoins
