while getopts a: opt
do 
  case ${opt} in
    a) a_option="$OPTARG" ;;
  esac
done

cd Targets/Platform/Utils/Sources
echo "import Foundation\n\npublic struct Keys {\npublic static let SUBWAY_API_KEY = \"${a_option}\"\n}" >> Keys.swift
ls