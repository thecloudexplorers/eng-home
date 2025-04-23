#! /bin/bash

while getopts "p:s:n:e:" option; do
    case "$option" in
        p) path=${OPTARG};;
        s) scope="${OPTARG}";;
        n) name="${OPTARG}";;
        e) email="${OPTARG}";;
    esac
done

echo "Executing: git -C ${path} config --${scope} user.name ${name}"
git -C ${path} config --${scope} user.name "${name}"
echo "Executing: git -C ${path} config --${scope} user.email ${email}"
git -C ${path} config --${scope} user.email "${email}"
echo "Done configuring user name and email."
echo " "
