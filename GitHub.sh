# --- Ask for GitHub username and optional token ---
read -p "👤 Enter your GitHub username: " GITHUB_USER
read -s -p "🔑 Enter your GitHub token (leave blank for public-only access): " GITHUB_TOKEN
echo ""

mkdir -p ~/Documents/GitHub
cd ~/Documents/GitHub

echo "📡 Fetching repos for $GITHUB_USER..."

if [ -n "$GITHUB_TOKEN" ]; then
  echo "🔐 Using authenticated GitHub API..."
  curl -s -u "$GITHUB_USER:$GITHUB_TOKEN" "https://api.github.com/user/repos?per_page=100" | \
    grep -o 'git@[^"]*\.git\|https://[^"]*\.git' | \
    while read repo; do
      name=$(basename "$repo" .git)
      if [ ! -d "$name" ]; then
        echo "📥 Cloning $name..."
        git clone "$repo"
      else
        echo "✅ $name already exists, skipping."
      fi
    done
else
  echo "🌐 No token provided — cloning public repos only..."
  curl -s "https://api.github.com/users/$GITHUB_USER/repos?per_page=100" | \
    grep -o 'https://[^"]*\.git' | \
    while read repo; do
      name=$(basename "$repo" .git)
      if [ ! -d "$name" ]; then
        echo "📥 Cloning $name..."
        git clone "$repo"
      else
        echo "✅ $name already exists, skipping."
      fi
    done
fi
