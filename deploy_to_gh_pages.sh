#!/bin/bash
set -e

# Config - change these
REPO_URL="https://github.com/rohithv1997/PortfolioV2.git"  # Your GitHub repo URL (HTTPS)
BRANCH="gh-pages"                                         # Branch to deploy to
PUBLISH_DIR="publish/wwwroot"                             # Path to your published Blazor WASM output

# Build the project (optional if you already published)
# dotnet publish -c Release -o publish

echo "Cloning the $BRANCH branch (or creating if it doesn't exist)..."
if git ls-remote --exit-code --heads $REPO_URL $BRANCH; then
    git clone --branch $BRANCH $REPO_URL temp-gh-pages
else
    git clone $REPO_URL temp-gh-pages
    cd temp-gh-pages
    git checkout --orphan $BRANCH
    git rm -rf .
    git commit --allow-empty -m "Initialize $BRANCH branch"
    git push origin $BRANCH
    cd ..
    git clone --branch $BRANCH $REPO_URL temp-gh-pages
fi

echo "Clearing old files..."
rm -rf temp-gh-pages/*

echo "Copying new files from $PUBLISH_DIR..."
cp -r $PUBLISH_DIR/* temp-gh-pages/

cd temp-gh-pages

echo "Adding files to git..."
git add --all

echo "Committing changes..."
git commit -m "Deploy Blazor WASM to GitHub Pages - $(date +"%Y-%m-%d %H:%M:%S")" || echo "No changes to commit."

echo "Pushing to $BRANCH branch..."
git push origin $BRANCH --force

cd ..

echo "Cleaning up..."
rm -rf temp-gh-pages

echo "Done!"
