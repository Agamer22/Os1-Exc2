doa()
{
    echo "Please type:<Name> <Surname> <City> <Phone number>"
read info
echo $info >> katalogos
}

dol()
{
    cat katalogos | grep . | grep . -n

}

dos()
{
    if [ "$1" -eq 4 ]
    then
        cat katalogos | grep . | sort -k 4 -n | grep . -n
    else
        cat katalogos | grep . | sort -k $1   | grep . -n
    fi
}

doc()
{
    cat katalogos | grep . | grep . -n | grep "$1"
}
linedeleted=0
dod()
{
    linedeleted=$(sed -n '1{/$pattern/{p;d;}}' katalogos)
    linedeleted=$(echo $linedeleted | awk '{print $1}')
    sed -i "0,/pattern/{/pattern/d;}" katalogos
    if [ "$1" = '#1' ]
    then
        if [ ! linedeleted -z ]
        then
            dob
        fi
    fi

    if [ "$1" = '#2' ]
    then
        if [ ! linedeleted -z ]
        then
            dor
        fi
    fi

}

dob()
{
    if [ -n "$linedeleted" ]
    then
        sed "${linedeleted}i\ " katalogos
        dod "#1"
    fi

}

dor()
{
    if [ -n "$linedeleted" ]
    then
        dod "#2"
    fi
}

while getopts 'als:c:d:br' OPTION
do
    case "$OPTION" in
        a)
            doa
            ;;
        l)
            dol
            ;;
        s)
            dos "$OPTARG"
            ;;
        c)
            doc "$OPTARG"
            ;;
        d)
            pattern="$OPTARG"
            dod
            ;;
        b)
            dob
            ;;
        r)
            dor
            ;;
        *)
            echo "scrip requirements / options : [-a] [-l] [-s <number>] [-c <keyword>] [-d <keyword> and < -b > or < -r >] "
            ;;

    esac
done
