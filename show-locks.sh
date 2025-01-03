echo "Type    Pid     Process  ...Process_Name  ...Process_Owner_Name" > locks.log
cat /proc/locks | awk '{print $2}' > temp1.log
cat /proc/locks | awk '{print $5}' > temp2.log


while IFS= read -r p
do
    cat /proc/$p/cmdline >> temp3.log
    echo >> temp3.log
done < temp2.log


while IFS= read -r p
do
    ps -p $p -o comm= >> temp4.log
done < temp2.log

while IFS= read -r p
do
    ps -u -p $p | grep $p | awk '{print $1}' >> temp5.log
done < temp2.log

while IFS= read -r p
do
    ls -l /proc/$p/fd/ | awk '{print $11}' >> temp6.log
done < temp2.log



paste temp1.log temp2.log temp3.log temp4.log temp5.log >> locks.log

echo >> locks.log
echo "Paths to the locked files" >> locks.log
paste temp6.log >> locks.log

rm temp1.log
rm temp2.log
rm temp3.log
rm temp4.log
rm temp5.log
rm temp6.log
