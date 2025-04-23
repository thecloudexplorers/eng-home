#! /bin/bash

while getopts "p:s:a:c:" option; do
    case "$option" in
        p) path=${OPTARG};;
        s) scope="${OPTARG}";;
        a) asp=${OPTARG};;
        c) editor="${OPTARG}";;
    esac
done

echo "Setting the config options for init, core, commit, tag, and gpg."
git -C ${path} config --${scope} init.defaultBranch main
git -C ${path} config --${scope} core.editor ${editor}
git -C ${path} config --${scope} commit.gpgsign true
git -C ${path} config --${scope} tag.gpgsign true
git -C ${path} config --${scope} gpg.format ssh
git -C ${path} config --${scope} gpg.ssh.allowedSignersFile ${asp}
echo "Done."
echo " "