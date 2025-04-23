#! /bin/bash

# Parse args to retrieve script input args.
while getopts "p:s:e:f:a:o:m:" option; do
    case "$option" in
        p) path=${OPTARG};;
        s) scope="${OPTARG}";;
        e) email="${OPTARG}";;
        f) forge="${OPTARG}";;
        a) asp=${OPTARG};;
        o) organization=${OPTARG};;
        m) mode=${OPTARG};;
    esac
done

signKeyPath=~/.ssh/${forge}-signing-${organization}-$(hostname)
echo "Signing key path: ${signKeyPath}"
echo " "

if [[ "$(echo ${mode} | tr '[:upper:]' '[:lower:]')" == "full" ]]; then
    # Ensure the .ssh and git config folders are available.
    mkdir -p ~/.ssh
    mkdir -p ~/.config
    mkdir -p ~/.config/git

    echo "Generating the SSH key..."
    ssh-keygen -t ed25519 -C ${email} -f ${signKeyPath}
    echo " "

    cat ${signKeyPath}.pub
    echo " "
    echo "Copy the above public key content and add it to your SSH *signing* keys here: https://github.com/settings/keys"
    echo " "

    echo "Storing the signing key in ${asp}"
    echo "${email} $(cat ${signKeyPath}.pub)" > ${asp}
    echo " "
fi

echo "Setting the user signing key in the ${scope} Git config..."
git -C ${path} config --${scope} user.signingkey ${signKeyPath}.pub
echo " "
