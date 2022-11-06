#!/bin/bash

# should see smooth gradients when running this script in the terminal
# https://jdhao.github.io/2018/10/19/tmux_nvim_true_color/#fn:2
# https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6

awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
