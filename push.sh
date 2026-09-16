#!/usr/bin/env bash
# Wypchnięcie dokumentacji do repo Homelab-RHCSA.
# Token podajesz lokalnie, w swoim terminalu. Nigdzie się nie zapisuje.

set -euo pipefail

USER="tagger123"
REPO="Homelab-RHCSA"

read -rsp "GitHub token: " TOKEN
echo

git init -q 2>/dev/null || true
git add .
git -c user.name="$USER" commit -qm "Dokumentacja homelaba: architektura, sieć, AD, monitoring, RHCSA" || {
  echo "Brak zmian do commita."
}
git branch -M main
git remote remove origin 2>/dev/null || true
git remote add origin "https://${USER}:${TOKEN}@github.com/${USER}/${REPO}.git"
git push -u origin main

# Czyścimy remote z tokenem, żeby nie został w .git/config
git remote set-url origin "https://github.com/${USER}/${REPO}.git"
unset TOKEN
echo "Gotowe."
