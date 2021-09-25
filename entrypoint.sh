#!/bin/sh

set -eux

PROJECT_ROOT="/go/src/github.com/${GITHUB_REPOSITORY}"
EXT=''

if [ $GOOS == 'windows' ]; then
  EXT='.exe'
fi

EVENT_DATA=$(cat $GITHUB_EVENT_PATH)
#echo $EVENT_DATA | jq .

UPLOAD_URL=$(echo $EVENT_DATA | jq -r .release.upload_url)
UPLOAD_URL=${UPLOAD_URL/\{?name,label\}/}

RELEASE_NAME=$(echo $EVENT_DATA | jq -r .release.tag_name)
PROJECT_NAME=$(basename $GITHUB_REPOSITORY)
NAME="${NAME:-${PROJECT_NAME}_${RELEASE_NAME}}_${GOOS}_${GOARCH}"

FILE_LIST="${PROJECT_NAME}${EXT} ${EXTRA_FILES}"
FILE_LIST=`echo "${FILE_LIST}" | awk '{$1=$1};1'`


mkdir -p $(dirname ${PROJECT_ROOT})
ln -s "${GITHUB_WORKSPACE}" "${PROJECT_ROOT}"
cd "$PROJECT_ROOT"

go get -v ./...
if [ $GOOS == 'windows' ]; then
  go build -v -a -trimpath -ldflags '-s -w' -o "${PROJECT_NAME}${EXT}"
else
  go build -v -a -trimpath -ldflags '-s -w -linkmode external -extldflags "-fno-PIC -static"' -o "${PROJECT_NAME}${EXT}"
fi

if [ $GOOS == 'windows' ]; then
  ARCHIVE=tmp.zip
  zip -9r $ARCHIVE ${FILE_LIST}
else
  ARCHIVE=tmp.tgz
  tar cvfz $ARCHIVE ${FILE_LIST}
fi

CHECKSUM=$(md5sum ${ARCHIVE} | cut -d ' ' -f 1)

curl \
  -X POST \
  --data-binary @${ARCHIVE} \
  -H 'Content-Type: application/octet-stream' \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${UPLOAD_URL}?name=${NAME}.${ARCHIVE/tmp./}"

curl \
  -X POST \
  --data $CHECKSUM \
  -H 'Content-Type: text/plain' \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${UPLOAD_URL}?name=${NAME}_checksum.txt"
