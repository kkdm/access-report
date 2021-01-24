#!/bin/bash
set -euxo pipefail

_TMP=${MONTHLY_LOG_DIR}
_ROOT=${ROOT_DIR}
_LOG_FILE=${LOG_FILE}

_Y=`date +%Y`
_M=`date +%m`
_D=`date +%d`
_DAILY_DIR=${_ROOT}/${_Y}/${_M}/${_D}
_MONTHLY_DIR=${_ROOT}/${_Y}/${_M}

# Create daily dir
mkdir -p ${_DAILY_DIR}

# Generate daily log
goaccess ${_LOG_FILE} --log-format='%^ %^ %^ [%d:%t %^] "%r" %s %b "%R" "%u" %T ~h{," }' --date-format='%d/%b/%Y' --time-format='%H:%M:%S' -o ${_DAILY_DIR}/report.html

# Add daily log to monthly log
# Monthly cron will rotate old log
cat ${_LOG_FILE} >> ${_TMP}/monthly.log

# Generate monthly report
goaccess ${_TMP}/monthly.log --log-format='%^ %^ %^ [%d:%t %^] "%r" %s %b "%R" "%u" %T ~h{," }' --date-format='%d/%b/%Y' --time-format='%H:%M:%S' -o ${_MONTHLY_DIR}/report.html 

