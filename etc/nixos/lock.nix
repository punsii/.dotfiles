with import <nixpkgs> {};
writeShellScriptBin "lock" ''
# hide i3 bar
i3-msg mode "default"

# add a lock screen!
#i3lock -e -f -c 000000 -i /home/klajsdlkfj/lock.png
i3lock -e -f -c 000000
''

