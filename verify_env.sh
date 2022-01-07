#!/bin/bash

Help()
{
   # Display Help
   echo "Usage: verify_env [OPTIONS]"
   echo "Verify environment variables"
   echo "Example verify_env -s src -e dist,node_modules"
   
   echo "Options:"
   echo "-s, --search     Take directory to search."
   echo "-n, --name       Take name of env file."
   echo "-e, --exclude    Take directories to exclude from search."
   echo "-h  --help       Display this help text and exit"
}

options=$(getopt -o s:n:e:h -l source:,name:,exclude:,help  -- "$@")

eval set -- "$options"

while true; do
  case $1 in
    -h | --help )
      Help;
      exit 0;;
    -s | --source )
      searchDir="$2";
      shift 2 ;;
    -n | --name ) 
      envName="$2";
      shift 2 ;;
    -e | --exclude )
        excludeDir="$2";
        shift 2 ;;
    * )
      break;;
  esac
done

# Read env
envVariables=$(grep -oP '^[A-Z]\w+' .${envName:=env})

# Read envs from code
envCode=$(grep -r -h -oP --exclude-dir=${excludeDir:=node_modules} '(?<=process.env.)[A-Z]\w+' $searchDir)

for variable in $envCode
do
  if ! grep -q $variable <<<$envVariables
  then
    if ! grep -q $variable <<<$envNotFound
    then
      envNotFound+="$variable "
    fi
  fi
done

if ! [ -z "$envNotFound" ];
then
  echo "Variables not found:" ${envNotFound// /, }
fi