#!/bin/sh

[ -d "$HOME/.cache/lf/preview" ] || mkdir -p "$HOME/.cache/lf/preview"

hash() {
    # File is identified by the xxh3sum of metadata from stat for efficiency
    cache="$HOME/.cache/lf/preview/$(stat --printf '%s%n%Y' "$(readlink -f "$file")" | xxh3sum | cut -d' ' -f1)"
}

draw_image() {
    file="$1"
    if [ -n "$FIFO_UEBERZUG" ]; then
        path="$(readlink -f -- "$file" | sed 's/\\/\\\\/g;s/"/\\"/g')"
        printf '{"action":"add","identifier":"preview","x":%d,"y":%d,"width":%d,"height":%d,"scaler":"contain","scaling_position_x":0.5,"scaling_position_y":0.5,"path":"%s"}\n' \
          "$x" "$y" "$width" "$height" "$path" >"$FIFO_UEBERZUG"
        exit 1
    else
        chafa --clear -s "${width}x${height}" "$file"
    fi
}

file="$1"
width="$2"
height="$3"
x="$4"
y="$5"

mime="$(file --mime-type -Lb "$1")"

case "$mime" in
    image/*)
        hash
        draw_image "$file" "$width" "$height"
        ;;
    video/*)
        hash
        [ -f "${cache}.jpg" ] ||
            ffmpegthumbnailer -i "$file" -s 720 -q 5 -o "${cache}.jpg"
        draw_image "${cache}.jpg" "$width" "$height"
        ;;
    application/epub+zip)
        hash
        [ -f "${cache}.jpg" ] ||
            gnome-epub-thumbnailer -s 720 "$file" "${cache}.jpg"
        draw_image "${cache}.jpg" "$width" "$height"
        ;;
    application/pdf)
        hash
        [ -f "${cache}" ] ||
            # pdftoppm already adds .jpg extension
            pdftoppm -f 1 -l 1 -singlefile -jpeg "$file" "${cache}"
        draw_image "${cache}.jpg" "$width" "$height"
        ;;
    audio/*)
        mid3v2 -l "$file"
        ;;
    application/x-tar|application/gzip|application/x-bzip2|application/x-xz|application/zstd)
        tar -tf "$file"
        ;;
    application/zip)
        unzip -l "$file"
        ;;
    application/x-rar)
        unrar-free l "$file"
        ;;
    application/x-7z-compressed)
        7z l "$file"
        ;;
    *)
        less -40 "$file"
        ;;
esac
