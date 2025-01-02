#echo "./$0 $1 $2 $3" | at 10 pm


if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -n "$4" ]
then
    echo "script needs [user name] [source] [destination]"
    exit 1
fi

name=$1
src=$2
dst=$3

if [ -f "/home/$name/$dst" ]
then
    tar -rf /home/$name/$dst /home/$name/$src
    echo "File appended"
else
    tar -cf /home/$name/$dst /home/$name/$src
    echo "File created"
fi



: '
    0 23 * 1-6 0 path_to_the_script/bck.sh user_name Desktop tmp
'
