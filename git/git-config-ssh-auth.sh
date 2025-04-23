#! /bin/bash

# Parse args to retrieve script input args.
while getopts "e:f:o:" option; do
    case "$option" in
        e) email="${OPTARG}";;
        f) forge="${OPTARG}";;
        o) organization="${OPTARG}";;
    esac
done

# Set path for storing of SSH keys.
authKeyPath=~/.ssh/${forge}-authentication-${organization}-$(hostname)
echo "Authentication key path: ${authKeyPath}"
echo " "

# Ensure the .ssh folder is available.
mkdir -p ~/.ssh

echo "Generating SSH Authentication key..."
echo " "
ssh-keygen -t ed25519 -C ${email} -f ${authKeyPath}
echo " "

cat ${authKeyPath}.pub
echo " "
echo "Copy the above public key content and add it to your SSH *authentication* keys here: https://github.com/settings/keys"
echo " "

echo "Adding authentication key to the local ssh-agent..."
echo " "
eval "$(ssh-agent -s)"
ssh-add $authKeyPath
echo " "

echo "The following identities have been listed in the local ssh-agent:"
ssh-add -l -E sha256

# Execute next line only if the forge is GitHub, to test the SSH authentication with GitHub.
# NOTE: This will fail if you do not paste the .pub key into the GitHub SSH authentication settings.
# ssh -vT git@github.com
