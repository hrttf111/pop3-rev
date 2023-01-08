EDITOR_BIN="PopEdt.exe"
#wine /opt/sandbox/pop/${EDITOR_BIN}
PREV=$(pwd)
cd /opt/sandbox/pop/
wine ./${EDITOR_BIN}
cd ${PREV}
