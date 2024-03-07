magick --help > /dev/null || { echo "magick not found. Install imagemagick."; exit 1; }

set -euo pipefail

rm -rf thumb
rm -rf ls.txt
rm -rf ls2.txt
mkdir -p thumb
for file in *.jpg; do
    echo ">$file<" ">thumb/${file%.jpg}<"
    # if [ "${CI}" = "" ]; then
    #     sips -z 170 340 "$file" --out "thumb/${file%.jpg}.jpg"
    # else
        magick "$file" -resize 340x170^ -gravity center -extent 340x170 "thumb/${file##*/}"
    # fi

done
ls *.jpg > ls.txt
while IFS= read -r file; do
    echo "$file::$(exiftool "$file" | grep 'Create Date' | awk -F': ' '{print $2}')"
done < ls.txt | tee ls2.txt
