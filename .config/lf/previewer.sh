#!/bin/sh

pager="head -40"

[ -d "$HOME/.cache/lf/preview" ] || mkdir -p "$HOME/.cache/lf/preview"

# File is identified by the xxh3sum of metadata from stat for efficiency
cache="$HOME/.cache/lf/preview/$(stat --printf '%s%n%Y' "$(readlink -f "$1")" | xxh3sum | cut -d' ' -f1)"

draw_image() {
    # Double the width because terminal characters are not square
    catimg -t -c -w "$(($2 * 2))" "$1"
}

case $(file --mime-type -Lb "$1") in
    image/*)
        draw_image "$1" "$2" "$3"
        ;;
    video/*)
        [ -f "${cache}.jpg" ] ||
            ffmpegthumbnailer -i "$1" -s 480 -q 5 -o "${cache}.jpg"
        draw_image "${cache}.jpg" "$2" "$3"
        ;;
    application/epub+zip)
        [ -f "${cache}.png" ] ||
            gnome-epub-thumbnailer "$1" "${cache}.png"
        draw_image "${cache}.png" "$2" "$3"
        ;;
    application/pdf)
        [ -f "${cache}" ] ||
            # pdftoppm already adds .jpg extension
            pdftoppm -f 1 -l 1 -singlefile -jpeg "$1" "${cache}"
        draw_image "${cache}" "$2" "$3"
        ;;
    audio/*)
        mid3v2 -l "$1"
        ;;
    application/x-tar|application/gzip|application/x-bzip2|application/x-xz|application/zstd)
        tar -tf "$1"
        ;;
    application/zip)
        unzip -l "$1"
        ;;
    application/x-rar)
        unrar-free l "$1"
        ;;
    application/x-7z-compressed)
        7z l "$1"
        ;;
    *)
        $pager "$1"
        ;;
esac
