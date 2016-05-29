#! /bin/bash
DEFAULT_SERVER=localhost
DEFAULT_PORT=9001
DEFAULT_SECRET="abcdefgh"

print_syntax() {
cat << EOF
Usage $0 [-h SERVER] [-p PORT] [-s SECRET] id_instance id_entity
SERVER, PORT and SECRET can also be provided as environment variables
EOF
}

while getopts h:p:s: opt; do
        case $opt in
                h)
                        SERVER=$OPTARG
                        ;;
                p)
                        PORT=$OPTARG
                        ;;
                s)
                        SECRET=$OPTARG
                        ;;
                \?)
                        print_syntax
                        exit 1
                        ;;
                :)
                        print_syntax
                        exit 1
                        ;;
        esac
done
shift $((OPTIND-1))

if (( $# != 2 )); then
        print_syntax
        exit 1
fi
BASE_URL=http://${SERVER-$DEFAULT_SERVER}:${PORT-$DEFAULT_PORT}/api/v1

ID_INSTANCE=$1
ID_ENTITY=$2

curl -X DELETE -H "Access-Token: ${SECRET-$DEFAULT_SECRET}" -H "Content-Type: application/json" $BASE_URL/instances/$ID_INSTANCE/entities/$ID_ENTITY
