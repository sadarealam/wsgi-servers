#!/usr/bin/env sh

# Install custom python package if requirements.txt is present
if [ -e "/requirements.txt" ]; then
    $(command -v pip) install --user -r /requirements.txt
fi

case "$1" in
  run)
    exec python app/run.py
    ;;
  migrate)
    python app/manage.py migrate --noinput
    ;;
  collectstatic)
    python app/manage.py collectstatic --noinput
    ;;
  *)
    exec "$@"
    ;;
esac
