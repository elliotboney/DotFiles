#! Code Stuff
#########################
##          SSH         #
#########################
# SSH to production
alias prod="ssh eboney@173.255.203.251 -p 2222"
# SSH to production mysql
alias prodsql="ssh eboney@173.255.197.75"
alias ell='_changetitle elliotboney.com && ssh elliotboney.com'

alias artisan='php artisan'

#########################
##          PHP        ##
#########################
# Create php docs
alias createdocs='phpdoc -d ./library/ZFDebug -t docs --template clean'


#########################
#         MISC          #
#########################

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  alias code="rcode"
# many other tests omitted
fi


# Outputs shell colors
function colortest() {
  for x in 0 1 4 5 7 8; do
    for i in `seq 30 37`; do
      for a in `seq 40 47`; do
        echo -ne "\e[$x;$i;$a""m\\\x1b[$x;$i;$a""m\e[0;37;40m ";
      done;
      echo;
    done;
  done;
  echo "";
}

colortestdircolors() {
    # Ordered from darkest to lightest within each color family
    # Each color appears only once across all arrays
    local -a REDS=(52 88 124 160 196 1 9)
    local -a ORANGES=(130 166 202 172 208 214 216 217 223 224)
    local -a YELLOWS=(100 136 142 178 184 220 226 227 228 229 3 11 230)
    local -a GREENS=(22 28 64 70 72 65 108 34 76 40 106 112 46 82 118 154 148 119 155 149 120 156 150 191 121 10 157 192 190)
    local -a CYANS=(23 29 30 36 37 43 44 50 79 80 51 86 87 45 81 115 116 122 123 117 159 194 14)
    local -a BLUES=(17 18 19 20 21 24 25 26 27 31 32 33 38 39 74 62 63 68 69 105 111 75)
    local -a PURPLES=(53 54 89 90 55 57 91 56 61 96 97 126 127 132 92 98 133 128 134 139 99 93 129 135 170 140 175 141 176 171 177 4 12) 
    local -a PINKS=(125 161 162 163 164 165 168 169 197 198 199 200 201 204 205 206 207 210 211 212 213 5 13 218 219 225)
    local -a BROWNS=(58 94 101 137 144 173 180)
    local -a GRAYS=(7 8 60 67 103 104 109 110 145 146 188 189 151 152 195 181 182)
 
    local ext="$1"
    
    if [[ -n "$ext" ]]; then
        # If extension provided, output in dircolors format
        echo "# Copy the line with your desired color to your dircolors file:"
        echo
        
        # Color groups
        echo -e "\n\e[01;38;5;160m# REDS:\e[00m"
        for i in "${REDS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        echo -e "\n\e[01;38;5;202m# ORANGES:\e[00m"
        for i in "${ORANGES[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        echo -e "\n\e[01;38;5;226m# YELLOWS:\e[00m"
        for i in "${YELLOWS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        echo -e "\n\e[01;38;5;2m# GREENS:\e[00m"
        for i in "${GREENS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        echo -e "\n\e[01;38;5;51m# CYANS:\e[00m"
        for i in "${CYANS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        echo -e "\n\e[01;38;5;33m# BLUES:\e[00m"
        for i in "${BLUES[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        echo -e "\n\e[01;38;5;134m# PURPLES:\e[00m"
        for i in "${PURPLES[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        echo -e "\n\e[01;38;5;200m# PINKS/MAGENTAS:\e[00m"
        for i in "${PINKS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        echo -e "\n\e[01;38;5;94m# BROWNS:\e[00m"
        for i in "${BROWNS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        echo -e "\n\e[01;38;5;160m# GRAYS:\e[00m"
        for i in "${GRAYS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        done
        
        # # Grayscale (232-255)
        # echo -e "\n# Grayscale ramp (232-255):"
        # for i in {232..255}; do
        #     echo -en "\e[38;5;${i}m████ "
        #     printf "*${ext} 0;38;5;%-3d\e[0m  # Color %3d\n" "$i" "$i"
        # done
        
    else
        # If no extension, show grouped view
        echo "256 Terminal Colors Preview (Grouped by Visual Appearance):"
        echo "Run with an extension (e.g., 'colortestdircolors .txt') to get dircolors format"
        
        # System colors
        echo -e "\n# Standard colors (0-7):"
        for i in "${STANDARD[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
        done
        echo
        
        echo "# Bright colors (8-15):"
        for i in "${BRIGHT[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
        done
        echo
        
        # Color groups with line breaks for readability
        echo -e "\n# REDS:"
        for i in "${REDS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
        done
        echo
        
        echo -e "\n# ORANGES:"
        for i in "${ORANGES[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
        done
        echo
        
        echo -e "\n# YELLOWS:"
        local count=0
        for i in "${YELLOWS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
            ((count++))
            if (( count % 8 == 0 )); then echo; fi
        done
        echo
        
        echo -e "\n# GREENS:"
        count=0
        for i in "${GREENS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
            ((count++))
            if (( count % 8 == 0 )); then echo; fi
        done
        echo
        
        echo -e "\n# CYANS:"
        count=0
        for i in "${CYANS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
            ((count++))
            if (( count % 8 == 0 )); then echo; fi
        done
        echo
        
        echo -e "\n# BLUES:"
        count=0
        for i in "${BLUES[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
            ((count++))
            if (( count % 8 == 0 )); then echo; fi
        done
        echo
        
        echo -e "\n# PURPLES:"
        count=0
        for i in "${PURPLES[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
            ((count++))
            if (( count % 8 == 0 )); then echo; fi
        done
        echo
        
        echo -e "\n# PINKS/MAGENTAS:"
        count=0
        for i in "${PINKS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
            ((count++))
            if (( count % 8 == 0 )); then echo; fi
        done
        echo
        
        echo -e "\n# BROWNS:"
        count=0
        for i in "${BROWNS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
            ((count++))
            if (( count % 8 == 0 )); then echo; fi
        done
        echo
        
        echo -e "\n# GRAYS:"
        count=0
        for i in "${GRAYS[@]}"; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
            ((count++))
            if (( count % 8 == 0 )); then echo; fi
        done
        echo
        
        # Grayscale (232-255)
        echo -e "\n# Grayscale ramp (232-255):"
        for i in {232..243}; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
        done
        echo
        for i in {244..255}; do
            echo -en "\e[38;5;${i}m████ "
            printf "%3d\e[0m " "$i"
        done
        echo
    fi
}