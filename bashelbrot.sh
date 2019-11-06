#!/Users/dave/.nix-profile/bin/bash

set -eu

color() {
  z=$1
  if [[ $z -gt 231 ]]; then z=231; fi
  echo -e -n "\e[48;5;${z}m"
}

reset() { echo -e -n "\e[0m"; }

LINES="`tput lines`"
COLUMNS="`tput cols`"

WXL="-1.4"
WXH="0.6"
WYL="1"
WYH="-1"

for (( y=0; y < $LINES - 1; y++ )); do
 for (( x=0; x < $COLUMNS; x++ )); do
  Cx=`echo "$x / ($COLUMNS - 1) * ($WXH - $WXL) + $WXL"|bc -l`
  Cy=`echo "$y / ($LINES - 2) * ($WYH - $WYL) + $WYL"|bc -l`

  Z=`echo "define trunc(x) { auto s; s=scale; scale=0; x=x/1; scale=s; return x }; x=$Cx; y=$Cy; for(z=1; z<=500; z++) {xp = x * x - y * y + $Cx; yp = 2 * x * y + $Cy; if (xp * xp + yp * yp > 4) {trunc(sqrt(z)*10); z=999} else {x=xp; y=yp; if (z == 140) {0; break} } }"|bc -l`
  echo -e -n "$(color $Z) "
 done
 echo -e "$(reset)"
done
