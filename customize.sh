#!/system/bin/sh

## MiXplorer Sharing
## https://drive.google.com/drive/folders/1BfeK39boriHy-9q76eXLLqbCwfV17-Gv

tmp=$MODPATH/tmp
list=$tmp/MiX-List
names=$tmp/MiX-Names

if [ "$API" -lt "30" ] ; then
  echo 1E3lVWnPdf3YaEuwlacgFWGyG7aTcstKK>$list
  echo 1E3lVWnPdf3YaEuwlacgFWGyG7aTcstKK=MiXplorer-api29>$names
else
  echo 1Z90pssJkf6puabWuKe0XoZXhDQ5dZ7CD>$list
  echo 1Z90pssJkf6puabWuKe0XoZXhDQ5dZ7CD=MiXplorer>$names
fi

if [ "$ARCH" = "arm" ] ; then
  # 32-bit
  wget=$MODPATH/tools/wget/armeabi-v7a/wget
  echo 1q_D7w9EKdgeiIWLYXQ2LtFK0nY5nbCMz>>$list
  echo 1q_D7w9EKdgeiIWLYXQ2LtFK0nY5nbCMz=MiX.addon.PDF-arm>>$names

  echo 10WVQukmcWQ_x3sySVOCAU0QpDFR5KhB1>>$list
  echo 10WVQukmcWQ_x3sySVOCAU0QpDFR5KhB1=MiX.addon.Image-arm>>$names

  echo 1Ezvagh6tO1XW4w__ghGEEQwVMBgC7C4d>>$list
  echo 1Ezvagh6tO1XW4w__ghGEEQwVMBgC7C4d=MiX.addon.Codecs-arm>>$names

  echo 1IphwWMt2-Sf94YbbgdMsWA61mYeNrFSX>>$list
  echo 1IphwWMt2-Sf94YbbgdMsWA61mYeNrFSX=MiX.addon.Archive-arm>>$names
else
  # 64-bit
  wget=$MODPATH/tools/wget/arm64-v8a/wget
  echo 18sETzOrcwPr_ITsrZ26_MCw3gsi1R3pH>>$list
  echo 18sETzOrcwPr_ITsrZ26_MCw3gsi1R3pH=MiX.addon.PDF-arm64>>$names

  echo 1P0Lj3UDFQP5_Eda_CA69NgmwmLsUqSQl>>$list
  echo 1P0Lj3UDFQP5_Eda_CA69NgmwmLsUqSQl=MiX.addon.Image-arm64>>$names

  echo 1x9z1HlpBGqp7MFa3KK8jH5VrGxmaQUGk>>$list
  echo 1x9z1HlpBGqp7MFa3KK8jH5VrGxmaQUGk=MiX.addon.Codecs-arm64>>$names

  echo 1fxYkdFUk9rIZYmL_JtRzLMr6Kdd6VFGL>>$list
  echo 1fxYkdFUk9rIZYmL_JtRzLMr6Kdd6VFGL=MiX.addon.Archive-arm64>>$names
fi

# common
echo 1ipfIkKo1DuvXIYrkLQ8l-WmBFzaDzRnp>>$list
echo 1ipfIkKo1DuvXIYrkLQ8l-WmBFzaDzRnp=MiX.addon.AutoTag>>$names

echo 1QF60JtXjhif5ZOwfrYuwCtUS7NeeAL7I>>$list
echo 1QF60JtXjhif5ZOwfrYuwCtUS7NeeAL7I=MiX.addon.Tagger>>$names

chmod 777 $wget

echo
echo
echo Downloading... 
for i in $(cat $list)
do
  name=`grep ^$i= $names | cut -d "=" -f 2`
  echo    - $name...
  $wget -q --no-check-certificate -O "$tmp/$name.apk" "https://docs.google.com/uc?export=download&confirm=&id=$i"
done

sleep 1

echo
echo
echo Installing... 
for i in $(cat $list)
do
  name=`grep ^$i= $names | cut -d "=" -f 2`
  echo    - $name...
  pm install --dont-kill "$tmp/$name.apk" > /dev/null 2>&1
done
echo    - MiX.addon.Metadata...
pm install --dont-kill "$tmp/MiX.addon.Metadata.apk" > /dev/null 2>&1

echo    - MiX.addon.Signer...
pm install --dont-kill "$tmp/MiX.addon.Signer.apk" > /dev/null 2>&1

echo    - MiX.addon.SMB...
pm install --dont-kill "$tmp/MiX.addon.SMB.apk" > /dev/null 2>&1

sleep 1

echo
echo
echo Cleaning... 
for i in $(cat $list)
do
  name=`grep ^$i= $names | cut -d "=" -f 2`
  echo    - $name...
  rm -rf "$tmp/$name.apk" > /dev/null 2>&1
done
echo    - MiX.addon.Metadata...
rm -rf "$tmp/MiX.addon.Metadata.apk" > /dev/null 2>&1

echo    - MiX.addon.Signer...
rm -rf "$tmp/MiX.addon.Signer.apk" > /dev/null 2>&1

echo    - MiX.addon.SMB...
rm -rf "$tmp/MiX.addon.SMB.apk" > /dev/null 2>&1

rm -rf $MODPATH/tmp
rm -rf $MODPATH/tools

echo > $MODPATH/remove
echo > $MODPATH/disabled
echo > /data/adb/modules/$MODID/remove
echo > /data/adb/modules/$MODID/disabled

echo
echo
echo
echo visit https://mixplorer.com/beta/ for latest beta
echo
echo chekout MiXplorer silver on playstore
echo to supporting MiXplorer dev-team 
echo
echo Enjoy!
echo
