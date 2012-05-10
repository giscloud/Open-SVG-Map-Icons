#!/bin/bash

# $1 type - like 'accommodation' or 'amenity'
# $2 name - name of the icon without the '.svg'
# $3 colour - e.g. '#ffddaa'
# $4 size - size in pixels e.g. 32
# $5 output path - if empty string, working dir will be used
# $6 effect - 'invert' OR 'glow'

pushd . > /dev/null
cd `dirname $BASH_SOURCE` > /dev/null
BASEFOLDER=`pwd`;
popd  > /dev/null
BASEFOLDER=`dirname $BASEFOLDER`

INPUTFILE="${BASEFOLDER}/svg/$1/$2.svg"

OUTPUTNAME="$1.$2.$3.$4"

if [ -z "$5" ]; then
  OUTPUTFOLDER=${BASEFOLDER}/
else
  OUTPUTFOLDER=$5
fi

if [ ! -d "${OUTPUTFOLDER}" ]; then
  mkdir ${OUTPUTFOLDER}
fi

if [ "$6" == "invert" ]; then
  OUTPUTNAME="$OUTPUTNAME.invert"
  ${BASEFOLDER}/tools/recolourtopng.sh ${INPUTFILE} $3 $3 '#ffffff' $4 ${OUTPUTFOLDER}/${OUTPUTNAME}
elif [ "$6" == "glow" ]; then
  OUTPUTNAME="$OUTPUTNAME.glow"
  ${BASEFOLDER}/tools/recolourtopng.sh ${INPUTFILE} 'none' 'none' $3 $4 ${OUTPUTFOLDER}/${OUTPUTNAME}.tmp
  convert ${OUTPUTFOLDER}/${OUTPUTNAME}.tmp.png \( +clone -background "#ffffff" -shadow 8000x2-0+0 \) +swap -background none -layers merge +repage -trim ${OUTPUTFOLDER}/${OUTPUTNAME}.png
  rm ${OUTPUTFOLDER}/${OUTPUTNAME}.tmp.png
else
  ${BASEFOLDER}/tools/recolourtopng.sh ${INPUTFILE} 'none' 'none' $3 $4 ${OUTPUTFOLDER}/${OUTPUTNAME}
fi
