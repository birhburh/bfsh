#!/bin/sh

# from here
# https://community.hpe.com/t5/operating-system-hp-ux/reading-a-single-character-then-what/td-p/2880639

echo -n W
echo A

while echo 1; do
    stty -echo
    stty raw
    readchar=$(dd if=$(tty) bs=1 count=1 2>/dev/null)

    case $readchar in
    $'\003')
        stty -raw
        stty sane
        stty erase "^H"
        exit 1
        ;;

    *)
        stty -raw
        echo "you typed '$readchar'"
        echo "$readchar" | head -c1 | xxd
        ;;
    esac
    stty -raw
    stty sane
    stty erase "^H"
done
exit 0