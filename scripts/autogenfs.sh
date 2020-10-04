 #!/bin/bash
 function read_dir(){
 for file in `ls $1`
 do
  if [ -d $1"/"$file ]; then
  read_dir $1"/"$file
  else
  echo $1"/"$file "0 0 0644"
  fi
 done
 }
 
 read_dir $1