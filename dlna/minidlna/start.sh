#!/bin/sh

INITIAL_CONF="/etc/minidlna.conf"
PERSISTENT_CONF="/cache/minidlna.conf"
TEMP_CONF="/tmp/minidlna.conf"
PID_FILE="/run/minidlna.pid"

## Copying initial config file to persistent storage
if [[ ! -f "$PERSISTENT_CONF" ]]; then
  cat "$INITIAL_CONF" > "$PERSISTENT_CONF"
fi

## Copying persisten config file to the temp config file.
cat "$PERSISTENT_CONF" > "$TEMP_CONF"

## Updating temp config file with parameters from Docker ENV.
echo "port=${TCP_PORT}" >> "$TEMP_CONF"
echo "friendly_name=${FRIENDLY_NAME}" >> "$TEMP_CONF"
echo "serial=${SERIAL}" >> "$TEMP_CONF"

# All media dirs
if [[ ! -z "${ALL_MEDIA_DIR1}" ]]; then
  echo "media_dir=${ALL_MEDIA_DIR1}" >> "$TEMP_CONF"
fi

if [[ ! -z "${ALL_MEDIA_DIR2}" ]]; then
  echo "media_dir=${ALL_MEDIA_DIR2}" >> "$TEMP_CONF"
fi

if [[ ! -z "${ALL_MEDIA_DIR3}" ]]; then
  echo "media_dir=${ALL_MEDIA_DIR3}" >> "$TEMP_CONF"
fi

if [[ ! -z "${ALL_MEDIA_DIR4}" ]]; then
  echo "media_dir=${ALL_MEDIA_DIR4}" >> "$TEMP_CONF"
fi

if [[ ! -z "${ALL_MEDIA_DIR5}" ]]; then
  echo "media_dir=${ALL_MEDIA_DIR5}" >> "$TEMP_CONF"
fi

if [[ ! -z "${ALL_MEDIA_DIR6}" ]]; then
  echo "media_dir=${ALL_MEDIA_DIR6}" >> "$TEMP_CONF"
fi

if [[ ! -z "${ALL_MEDIA_DIR7}" ]]; then
  echo "media_dir=${ALL_MEDIA_DIR7}" >> "$TEMP_CONF"
fi

if [[ ! -z "${ALL_MEDIA_DIR8}" ]]; then
  echo "media_dir=${ALL_MEDIA_DIR8}" >> "$TEMP_CONF"
fi

if [[ ! -z "${ALL_MEDIA_DIR9}" ]]; then
  echo "media_dir=${ALL_MEDIA_DIR9}" >> "$TEMP_CONF"
fi

# Video
if [[ ! -z "${VIDEO_DIR1}" ]]; then
  echo "media_dir=V,${VIDEO_DIR1}" >> "$TEMP_CONF"
fi

if [[ ! -z "${VIDEO_DIR2}" ]]; then
  echo "media_dir=V,${VIDEO_DIR2}" >> "$TEMP_CONF"
fi

if [[ ! -z "${VIDEO_DIR3}" ]]; then
  echo "media_dir=V,${VIDEO_DIR3}" >> "$TEMP_CONF"
fi

if [[ ! -z "${VIDEO_DIR4}" ]]; then
  echo "media_dir=V,${VIDEO_DIR4}" >> "$TEMP_CONF"
fi

if [[ ! -z "${VIDEO_DIR5}" ]]; then
  echo "media_dir=V,${VIDEO_DIR5}" >> "$TEMP_CONF"
fi

if [[ ! -z "${VIDEO_DIR6}" ]]; then
  echo "media_dir=V,${VIDEO_DIR6}" >> "$TEMP_CONF"
fi

if [[ ! -z "${VIDEO_DIR7}" ]]; then
  echo "media_dir=V,${VIDEO_DIR7}" >> "$TEMP_CONF"
fi

if [[ ! -z "${VIDEO_DIR8}" ]]; then
  echo "media_dir=V,${VIDEO_DIR8}" >> "$TEMP_CONF"
fi

if [[ ! -z "${VIDEO_DIR9}" ]]; then
  echo "media_dir=V,${VIDEO_DIR9}" >> "$TEMP_CONF"
fi

# Audio
if [[ ! -z "${AUDIO_DIR1}" ]]; then
  echo "media_dir=A,${AUDIO_DIR1}" >> "$TEMP_CONF"
fi

if [[ ! -z "${AUDIO_DIR2}" ]]; then
  echo "media_dir=A,${AUDIO_DIR2}" >> "$TEMP_CONF"
fi

if [[ ! -z "${AUDIO_DIR3}" ]]; then
  echo "media_dir=A,${AUDIO_DIR3}" >> "$TEMP_CONF"
fi

if [[ ! -z "${AUDIO_DIR4}" ]]; then
  echo "media_dir=A,${AUDIO_DIR4}" >> "$TEMP_CONF"
fi

if [[ ! -z "${AUDIO_DIR5}" ]]; then
  echo "media_dir=A,${AUDIO_DIR5}" >> "$TEMP_CONF"
fi

if [[ ! -z "${AUDIO_DIR6}" ]]; then
  echo "media_dir=A,${AUDIO_DIR6}" >> "$TEMP_CONF"
fi

if [[ ! -z "${AUDIO_DIR7}" ]]; then
  echo "media_dir=A,${AUDIO_DIR7}" >> "$TEMP_CONF"
fi

if [[ ! -z "${AUDIO_DIR8}" ]]; then
  echo "media_dir=A,${AUDIO_DIR8}" >> "$TEMP_CONF"
fi

if [[ ! -z "${AUDIO_DIR9}" ]]; then
  echo "media_dir=A,${AUDIO_DIR9}" >> "$TEMP_CONF"
fi

# Pictures
if [[ ! -z "${PICTURES_DIR1}" ]]; then
  echo "media_dir=P,${PICTURES_DIR1}" >> "$TEMP_CONF"
fi

if [[ ! -z "${PICTURES_DIR2}" ]]; then
  echo "media_dir=P,${PICTURES_DIR2}" >> "$TEMP_CONF"
fi

if [[ ! -z "${PICTURES_DIR3}" ]]; then
  echo "media_dir=P,${PICTURES_DIR3}" >> "$TEMP_CONF"
fi

if [[ ! -z "${PICTURES_DIR4}" ]]; then
  echo "media_dir=P,${PICTURES_DIR4}" >> "$TEMP_CONF"
fi

if [[ ! -z "${PICTURES_DIR5}" ]]; then
  echo "media_dir=P,${PICTURES_DIR5}" >> "$TEMP_CONF"
fi

if [[ ! -z "${PICTURES_DIR6}" ]]; then
  echo "media_dir=P,${PICTURES_DIR6}" >> "$TEMP_CONF"
fi

if [[ ! -z "${PICTURES_DIR7}" ]]; then
  echo "media_dir=P,${PICTURES_DIR7}" >> "$TEMP_CONF"
fi

if [[ ! -z "${PICTURES_DIR8}" ]]; then
  echo "media_dir=P,${PICTURES_DIR8}" >> "$TEMP_CONF"
fi

if [[ ! -z "${PICTURES_DIR9}" ]]; then
  echo "media_dir=P,${PICTURES_DIR9}" >> "$TEMP_CONF"
fi


## Sometimes PID file can exist after restart. Cleaning.
if [[ -f "$PID_FILE" ]]; then
  pid=$(cat "$PID_FILE")
  if [[ -n "$(ps -p $pid -o pid=)" ]]; then
    echo "Another MiniDLNA instance is running: $pid. Exiting..."
    exit 1
  else
    echo "Removing uncleaned pid file: $PID_FILE"
    rm -f "$PID_FILE"
  fi
fi

exec /usr/sbin/minidlnad -P "$PID_FILE" -f "$TEMP_CONF" -S -r



