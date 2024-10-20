set -e

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> Omakub on macOS"
echo -e "\nBegin installation (or abort with ctrl+c)..."

echo "Cloning Omakub..."
rm -rf ~/.config/omakub
git clone https://github.com/basecamp/omakub.git ~/.config/omakub >/dev/null
if [[ $OMAKUB_REF != "master" ]]; then
  cd ~/.config/omakub
  git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}"
  cd -
fi

echo "Installation starting..."
source ~/.config/omakub/install.sh
