#!/bin/bash
#
# Author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
if [ $# -eq 0 ]
  then
    echo "Given a directory, script will:"
    echo " - replace 'foo' in any file names with 'bar'"
    echo " - replace 'foo' in the contents of any files with 'bar'"
    echo " - output the file names that were changed"
    echo ""
    echo "Example:"
    echo "./foobar.sh /tmp/directory"
  exit 1
fi

# If non-recursive functionality is desired, add -maxdepth 1 option to find
for FILE in $(find $1 -type f); do
  # String replacement and comparison much faster then another
  # for loop stat'ing the file system
  NEWNAME=${FILE//foo/bar}
  if [ "$NEWNAME" != "$FILE" ]
  then
    echo "Renaming $FILE to $NEWNAME"
    mv "$FILE" "$NEWNAME"
  fi

  echo "Replacing string 'foo' with 'bar' in:" $NEWNAME
  sed -i 's%foo%bar%g' $NEWNAME
done
