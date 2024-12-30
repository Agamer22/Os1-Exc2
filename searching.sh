ssum=0

exit_script()
{
    echo "Total search sum is $ssum"
    exit 0
}
trap 'exit_script' SIGINT

if [ -z "$1" ]
then
    perms=777
else
    perms=$1
fi

if [ -z "$2" ]
then
    time=30
else
    time=$2
fi

for (( ; ; ))
do

echo "Please type the name of the directory"
read dir

sum=$(find /$dir -perm $perms 2>/dev/null| grep -c "")
let ssum=ssum+sum
echo "Files with $perms permissions($sum):"
find /$dir -perm $perms 2>/dev/null

echo
echo "------------------------"
echo

sum=$(find /$dir -mtime $time 2>/dev/null| grep -c "")
let ssum=ssum+sum
echo "Files that have been modified in the last $2 days($sum):"
find /$dir -mtime $time 2>/dev/null

echo
echo "------------------------"
echo

sum=$(find /$dir -type d -atime $time 2>/dev/null | grep -c "")
let ssum=ssum+sum
echo "Directories that have been accessed in the last $2 days($sum):"
find /$dir -type d -atime $time 2>/dev/null

echo
echo "------------------------"
echo

sum=$(ls -la /$dir | grep "^.......r" | grep -c "")
let ssum=ssum+sum
echo "Files that everyone can read($sum):"
ls -la /$dir | grep "^.......r"


echo
echo "------------------------"
echo

sum=$(ls -la /$dir | grep "^d.wx....wx" | grep -c "")
let ssum=ssum+sum
echo "Directories that user and others have the right to modify($sum):"

ls -la /$dir | grep "^d.wx....wx"

done

