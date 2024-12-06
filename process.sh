magick --help > /dev/null || { echo "magick not found. Install imagemagick."; exit 1; }

set -euo pipefail

rm -rf ls.txt

mkdir -p thumb

for FILE in *.jpg; do

    TARGET="thumb/${FILE}"

    echo ">$FILE<" ">${TARGET}<"

    if [ -f "${TARGET}" ]; then

        echo "skipping ${FILE} -> ${TARGET}"
    else
        echo "processing ${FILE} -> ${TARGET}"
        # if [ "${CI}" = "" ]; then
        #     sips -z 170 340 "$FILE" --out "thumb/${FILE}"
        # else
            magick "$FILE" -resize 340x170^ -gravity center -extent 340x170 "${TARGET}"
        # fi
    fi

    echo "$FILE::$(exiftool "$FILE" | grep 'Create Date' | awk -F': ' '{print $2}')" >> ls.txt

    echo ""
done
