#!/bin/bash
# USAGE:    diffstat.sh [file1] [file2]

if [ ! $2 ]
then
   printf "\n   USAGE: diffstat.sh [file1] [file2]\n\n"
   exit
fi

diff -y "$1" "$2" > "/tmp/diff_tmp" 
add_lines=$(cat "/tmp/diff_tmp" | grep '>' | wc -l)
del_lines=$(cat "/tmp/diff_tmp" | grep '<'- | wc -l)

# ignore diff header (those starting with @@) 
#at_lines=$(cat "/tmp/diff_tmp" | grep ^@ | wc -l)
chg_lines=$(cat "/tmp/diff_tmp" | grep "\s\+|\s\+" | wc -l)
#chg_lines=$(expr $chg_lines - $add_lines - $del_lines - $at_lines)
#chg_lines=$(expr $chg_lines - $add_lines - $del_lines)

# subtract header lines from count (those starting with +++ & ---) 
#add_lines=$(expr $add_lines - 1)
#del_lines=$(expr $del_lines - 1)
total_change=$(expr $chg_lines + $add_lines + $del_lines)

rm -v /tmp/diff_tmp

printf "Total added lines:  "
printf "%10s\n" "$add_lines"
printf "Total deleted lines:"
printf "%10s\n" "$del_lines"
printf "Modified lines:     "
printf "%10s\n" "$chg_lines"
printf "Total changes:      "
printf "%10s\n" "$total_change"
