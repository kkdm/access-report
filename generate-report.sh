#!/bin/bash
set -euxo pipefail

_TARGET=${TARGET}
_ROOT=${ROOT_DIR}
_LOG_DIR=${LOG_DIR}

_Y=`date +%Y --date='1 day ago'`
_M=`date +%m --date='1 day ago'`
_D=`date +%d --date='1 day ago'`
_DAILY_DIR=${_ROOT}/${_Y}/${_M}/${_D}
_MONTHLY_DIR=${_ROOT}/${_Y}/${_M}
_YEARLY_DIR=${_ROOT}/${_Y}

# Create daily dir
mkdir -p ${_DAILY_DIR}

cat ${TARGET} >> ${_LOG_DIR}/monthly.log
cat ${TARGET} >> ${_LOG_DIR}/yearly.log

# Generate daily log
goaccess ${TARGET} --log-format='%^ %^ %^ [%d:%t %^] "%r" %s %b "%R" "%u" %T ~h{," }' --date-format='%d/%b/%Y' --time-format='%H:%M:%S' -o ${_DAILY_DIR}/report.html

# Generate monthly report
goaccess ${_LOG_DIR}/monthly.log --log-format='%^ %^ %^ [%d:%t %^] "%r" %s %b "%R" "%u" %T ~h{," }' --date-format='%d/%b/%Y' --time-format='%H:%M:%S' -o ${_MONTHLY_DIR}/report.html 

# Generate yearly report
goaccess ${_LOG_DIR}/yearly.log --log-format='%^ %^ %^ [%d:%t %^] "%r" %s %b "%R" "%u" %T ~h{," }' --date-format='%d/%b/%Y' --time-format='%H:%M:%S' -o ${_YEARLY_DIR}/report.html 

if [[ "${_M}" != "`date +%m`" ]]; then
  rm -f ${_LOG_DIR}/monthly.log
fi

if [[ "${_Y}" != "`date +%Y`" ]]; then
  rm -f ${_LOG_DIR}/yearly.log
fi

