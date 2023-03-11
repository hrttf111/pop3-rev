GHIDRA_BIN=ghidra
GHIDRA_PATH=$1
if [[ -z "$1" || ! -d "${GHIDRA_PATH}" ]]; then
    GHIDRA_PATH=$(which ${GHIDRA_BIN})
    if [ -h ${GHIDRA_PATH} ]; then
        GHIDRA_PATH=$(readlink ${GHIDRA_PATH})
    fi
    GHIDRA_PATH=${GHIDRA_PATH%${GHIDRA_BIN}}
    GHIDRA_PATH=${GHIDRA_PATH}/..
fi

GHIDRA_HEADLESS=${GHIDRA_PATH}/lib/ghidra/support/analyzeHeadless
if [ -a ${GHIDRA_HEADLESS} ]; then
    GHIDRA_HEADLESS=$(realpath ${GHIDRA_HEADLESS})
    echo ${GHIDRA_HEADLESS}
    exit 0
fi

GHIDRA_HEADLESS=$(find ${GHIDRA_PATH} -name analyzeHeadless)
if [ -a ${GHIDRA_HEADLESS} ]; then
    GHIDRA_HEADLESS=$(realpath ${GHIDRA_HEADLESS})
    echo ${GHIDRA_HEADLESS}
    exit 0
fi
exit 1
