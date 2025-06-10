#!/bin/bash

set -e

# Tool selection
TOOL=$1

if [ -z "$TOOL" ]; then
  echo "Which tool do you want to use?"
  echo "1) standard-version"
  echo "2) semantic-release"
  read -p "Your choice (1 or 2): " CHOICE
  case $CHOICE in
    1) TOOL="standard-version" ;;
    2) TOOL="semantic-release" ;;
    *) echo "Invalid choice" && exit 1 ;;
  esac
fi

# Release function using standard-version
release_with_standard_version() {
  echo "🔧 Bumping version (standard-version)..."
  npx standard-version --release-as minor --changelog

  VERSION=$(jq -r '.version' package.json)
  echo "📦 New version: v$VERSION"

  echo "🏷️ Creating git tag and pushing..."
  git push --follow-tags origin main

  echo "🚀 Creating GitHub release..."
  gh release create "v$VERSION" -F CHANGELOG.md --title "Release v$VERSION"
}

# Release function using semantic-release
release_with_semantic_release() {
  echo "🧪 Running release with semantic-release..."
  npx semantic-release
}

# Run the selected tool
case $TOOL in
  standard-version)
    release_with_standard_version
    ;;
  semantic-release)
    release_with_semantic_release
    ;;
  *)
    echo "Unrecognised tool: $TOOL"
    exit 1
    ;;
esac
