function movtogif() {
    local output="${2:-out.gif}"
    local size="${3:-1024}"
    local rate="${4:-10}"
    local colors="${4:-128}"

    if [ $# -eq 0 ]; then
        echo ""
        echo "Converts Mov files to gif."
        echo ""
        echo "Usage: mov2gif source.mov [$output size:$size frame_rate:$rate colors:$colors]"
        echo ""
        return 1
    fi

    time ffmpeg -i $1 -r $rate -f image2pipe -vcodec ppm - | time convert -verbose +dither -layers Optimize -resize "${size}x${size}"\> - gif:- | gifsicle --colors $colors --delay=5 --loop --optimize=3 --multifile -> $output
}