mkdir json/
mkdir exercise-temp/

KRAMDOWN="kramdown --line-width 9999  --entity-output :as_input"

for i in {1..500}
do

  # Temp filenames
  JSON="json/${i}-exercise.json"
  ORIG="exercise-temp/${i}-exercise-orig.html"
  ORIG2="exercise-temp/${i}-exercise-formatted.html"
  ORIG3="exercise-temp/${i}-exercise-canonical.html"
  ORIG4="exercise-temp/${i}-exercise-cleanedup.html"
  NEW="exercise-temp/${i}-exercise-new.html"
  ORIG_MD="exercise-temp/${i}-exercise-orig.md"
  NEW_MD="exercise-temp/${i}-exercise-new.md"

  NEW_WRAPPED="exercise-temp/${i}-exercise-new-wrapped.html"


  echo "Downloading and Converting ${i}"
  curl --progress-bar "https://exercises-qa.openstax.org/api/exercises/${i}" > ${JSON}
  cat ${JSON} | jq --raw-output ".questions[0].stem_html" > ${ORIG}

  echo '<html><body>' > ${ORIG2}
  cat ${ORIG} >> ${ORIG2}
  echo '' >> ${ORIG2}
  echo '</body></html>' >> ${ORIG2}
  cat ${ORIG2} > ${ORIG3}

  xsltproc --html ./exercise-cleanup.xsl ${ORIG3} | xmllint --html --xmlout --pretty 2 - > ${ORIG4}

  xsltproc --html ./exercise-omit-stuff.xsl ${ORIG3}  | ${KRAMDOWN} --input html --output kramdown > ${ORIG_MD}

  ${KRAMDOWN} --input kramdown --output html ${ORIG_MD} > ${NEW_WRAPPED}

  xsltproc --html ./exercise-cleanup.xsl ${NEW_WRAPPED} | xmllint --html --xmlout --pretty 2 - > ${NEW}

  diff -w ${ORIG4} ${NEW}

done
