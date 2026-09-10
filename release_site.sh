set -e
cd /zfsfiles/DockerConfig/DockerSource/VibeNVR-workspace/VibeNVR-site
DEFAULT_BRANCH="main"
git fetch origin
git checkout $DEFAULT_BRANCH
git pull origin $DEFAULT_BRANCH

LAST_TAG=$(git tag --sort=-v:refname | head -1 || true)
LAST_TAG=${LAST_TAG:-v1.0.0}

NEW_VERSION=$(node -e '
const [tag] = process.argv.slice(1);
const [maj, minor, patch] = tag.replace(/^v/i, "").split(".").map(Number);
console.log(`v${maj}.${minor}.${patch + 1}`);
' "$LAST_TAG")

VER_NUM=${NEW_VERSION#v}
git checkout -b "release/$NEW_VERSION"

# Merging PRs
echo "Merging PRs..."
git merge origin/bolt-optimize-layout-thrashing-6984148380279937818 --no-edit
git merge origin/palette/telemetry-active-state-1318982437635419339 --no-edit

# Bump Version in UI
sed -i -E "s/>v[0-9]+\.[0-9]+\.[0-9]+</>v$VER_NUM</" src/header.html

# Remove Stray Files & Commit
git rm -rf .agents .wrangler .env .dev.vars 2>/dev/null || true
git add -A
git commit -m "v$VER_NUM: merge PRs and bump version"

# Merge to Main & Push
git checkout $DEFAULT_BRANCH
git merge release/$NEW_VERSION --no-edit
git branch -d release/$NEW_VERSION
git push origin $DEFAULT_BRANCH

# Tag and Publish Release Notes
git tag "$NEW_VERSION"
git push origin $DEFAULT_BRANCH --tags

TODAY=$(date +%Y-%m-%d)
NOTES="## [$VER_NUM] - $TODAY

### Changed
- ⚡ Bolt: Prevent layout thrashing in gallery interval and remove premature micro-optimization
- 🎨 Palette: Add active state to telemetry stat cards
"

gh release create "$NEW_VERSION" --title "$NEW_VERSION" --notes "$NOTES"
