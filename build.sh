#!/bin/sh
SRC_DIR="$(dirname $(readlink -f $0))/test/source"
DST_DIR="$(dirname $(readlink -f $0))/test/target"

MOUNTS=
MOUNTS="$MOUNTS -v $SRC_DIR:/mnt/source/"
MOUNTS="$MOUNTS -v $DST_DIR:/mnt/target/"

ID="-e UID=$(id -u) -e GID=$(id -g)"

IMAGE="gulp"

case $1 in
    tag)
	;;
    push)
	;;
    test)
	shift
	docker run --rm -t -i $MOUNTS $ID $IMAGE $@
	;;
    bash)
	echo "Source - $SRC_DIR"
	echo "Destination - $DST_DIR"
	docker run -t -i $MOUNTS $ID --entrypoint bash $IMAGE
	;;
    *)
	docker build -t $IMAGE .
	;;
esac

# ./build.sh test npm install
# ./build.sh test gulp --build --target /mnt/target
