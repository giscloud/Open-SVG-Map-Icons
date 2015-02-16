#!/bin/bash

# $1 size
# $2 colour

pushd . > /dev/null
cd `dirname $BASH_SOURCE` > /dev/null
BASEFOLDER=`pwd`;
popd  > /dev/null
BASEFOLDER=`dirname $BASEFOLDER`

TYPES=('accommodation' 'amenity' 'barrier' 'education' 'food' 'health' 'landuse' 'money' 'place_of_worship' 'poi' 'power' 'shopping' 'sport' 'tourist' 'transport' 'water' 'forest' 'landcover' 'landusing' 'other')

SVGFOLDER=${BASEFOLDER}/svg/
OUTPUTFOLDER=${BASEFOLDER}/gallery/

if [ ! -d "${OUTPUTFOLDER}" ]; then
  mkdir ${OUTPUTFOLDER}
fi

for (( i = 0 ; i < ${#TYPES[@]} ; i++ )) do

    echo "On: ${TYPES[i]}"

    for FILE in $SVGFOLDER${TYPES[i]}/*.svg; do

      BASENAME=${FILE##/*/}
      BASENAME=${OUTPUTFOLDER}${TYPES[i]}/${BASENAME%.*}

      if [ ! -d "${OUTPUTFOLDER}${TYPES[i]}" ]; then
        mkdir ${OUTPUTFOLDER}${TYPES[i]}
      fi
      
      ${BASEFOLDER}/tools/recolourtopng.sh ${FILE} 'none' 'none' $2 $1 ${BASENAME}.$1
      
    done

done
