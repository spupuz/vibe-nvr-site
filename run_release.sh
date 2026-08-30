REPO_NAME="vibe-nvr-site"
DEFAULT_BRANCH="main"

git status --short
git diff --stat

grep -riE "(api_key|password|secret|token|auth|credentials)" . | grep -v "node_modules" | grep -v "\.git" || true
git ls-files | grep -E "\.env|dev\.vars|\.wrangler" || true

LAST_TAG=$(git tag --sort=-v:refname | head -1 || true)
LAST_TAG=${LAST_TAG:-v1.0.0}
SUBJECT=$(git log -1 --format=%s)

NEW_VERSION=$(node -e '
const [tag, subject] = process.argv.slice(1);
const [maj, minor, patch] = tag.replace(/^v/i, "").split(".").map(Number);
const m = subject.match(/^([a-z]+)(\([^)]*\))?(!)?:/);
const bump = m && m[3] ? "major" : (m && m[1] === "feat" ? "minor" : "patch");
console.log(bump === "major" ? `v${maj + 1}.0.0` : bump === "minor" ? `v${maj}.${minor + 1}.0` : `v${maj}.${minor}.${patch + 1}`);
' "$LAST_TAG" "$SUBJECT")

VER_NUM=${NEW_VERSION#v}
echo "Bumping to $NEW_VERSION"

sed -i -E "s/>v[0-9]+\.[0-9]+\.[0-9]+</>v$VER_NUM</" src/header.html || true

git add -A
git commit -m "chore: release $NEW_VERSION
- Auto-bump version to $NEW_VERSION" || true

git push origin $DEFAULT_BRANCH

git tag "$NEW_VERSION"
git push origin $DEFAULT_BRANCH --tags

TODAY=$(date +%Y-%m-%d)
NOTES="## [$VER_NUM] - $TODAY

### Changed
$(git log "$LAST_TAG"..HEAD --format='- %s' | sed 's/^- \([a-z]*\): \(.*\)/- **\1**: \2/')
"
gh release create "$NEW_VERSION" --title "$NEW_VERSION" --notes "$NOTES"
