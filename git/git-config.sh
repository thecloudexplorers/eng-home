#! /bin/bash

# Set default script values.
# Change the path in case you do a local run and want to change git config settings in a specific local git repo only.
# Scope set to system or global *will not do anything in the designated path*.
path=.
# The scope at which git config --scope <system/global/local> will run.
scope="global"
# Default pick from the list of organization options 
organization="bearmannl"
# Are you using VS Code instead of Codium? Replace with `code --wait`. Just ensure the git core editor can be run from commandline when adding it here.
editor="codium --wait"
# full/FULL will result in a 'complete run' also generating keys.
# Partial will set all the relevant configuration options, *without* creating the keys. This option is to be used when populating other repos, after having created keys in a full run.
# Light only sets the user name and email, no SSH keys or other config.
mode="FULL"

# Parse args to retrieve script input args and override default script values if present.
while getopts "p:s:n:e:f:c:m:o:" option; do
    case ${option} in
        p) path=${OPTARG};;
        s) scope="${OPTARG}";;
        n) name="${OPTARG}";;
        e) email="${OPTARG}";;
        f) forge="${OPTARG}";;
        c) editor="${OPTARG}";;
        m) mode="${OPTARG}";;
        o) organization="${OPTARG}";;
    esac
done

# Use a case statement to switch between different default name, email, and forge values.
case "$(echo "$organization" | tr '[:upper:]' '[:lower:]')" in
  "contoso")
    # The 'organization name' can be anything here.
    # For instance, it could be 'tailspin', or 'contoso'.
    # Set the username and email as relevant per that organization, and relevant forge (ado? github?).
    if [ -z "$name" ]; then
      # This propery will go into your .gitconfig file under '[user].name'.
      name='My Name'
    fi
    if [ -z "$email" ]; then
      # This propery will go into your .gitconfig file under '[user].name'.
      email='my.name@contoso.com'
    fi
    if [ -z "$forge" ]; then
      # This propery will tag the file name with the specific purpose (which forge it is for) of the SSH key.
      # This can be any value you prefer, valid for a file path (so don't use odd path variables). I prefer abbreviating azuredevops to ado.
      forge='ado'
    fi
    ;;
  "bearmannl")
    if [ -z "$name" ]; then
      name='Mike Bearman'
    fi
    if [ -z "$email" ]; then
      email='29874229+bearmannl@users.noreply.github.com'
    fi
    if [ -z "$forge" ]; then
      forge='github'
    fi
    ;;
  *)
    echo "Unknown forge!"
    ;;
esac

echo "Script execution path: $(realpath ${path})"
echo "Configuration scope: ${scope}"
echo "User name: ${name}"
echo "User e-mail: ${email}"
echo " "

echo "Setting user name & password..."
echo " "
# Set the config for username and email
./git-config-user.sh -p ${path} -s "${scope}" -n "${name}" -e "${email}"

allowedSignersPath=~/.config/git/allowed_signers

# Only execute next bit if runsegment=true
if [[ "$(echo ${mode} | tr '[:upper:]' '[:lower:]')" == "full" ]]; then
    echo "Targeted organization: ${organization}"
    echo " "

    echo "Generating SSH key for authentication purposes..."
    echo " "
    ./git-config-ssh-auth.sh -e "${email}" -f "${forge}" -o "${organization}"

    echo "Generating SSH key for signing purposes..."
    echo " "
    ./git-config-ssh-sign.sh -p ${path} -s "${scope}" -e "${email}" -f "${forge}" -a ${allowedSignersPath} -o "${organization}" -m "${mode}"

    echo "Setting base configuration..."
    echo " "
    # Set the base configuration for Git including init and ssh config options.
    ./git-config-base.sh -p ${path} -s "${scope}" -a ${allowedSignersPath} -c "${editor}"
fi

if [[ "$(echo ${mode} | tr '[:upper:]' '[:lower:]')" == "partial" ]]; then
    echo "Targeted organization: ${organization}"
    echo " "

    echo "Setting (*not generating*) SSH key for signing purposes..."
    echo " "
    ./git-config-ssh-sign.sh -p ${path} -s "${scope}" -e "${email}" -f "${forge}" -a ${allowedSignersPath} -o "${organization}" -m "${mode}"

    echo "Setting base configuration..."
    echo " "
    # Set the base configuration for Git including init and ssh config options.
    ./git-config-base.sh -p ${path} -s "${scope}" -a ${allowedSignersPath} -c "${editor}"
fi

if [[ "$(echo ${mode} | tr '[:upper:]' '[:lower:]')" == "light" ]]; then
    echo "Light execution finished, skipping SSH generation & configuration."
    echo " "
fi
