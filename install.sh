#!/usr/bin/env bash
set -eu

# Defines the home directory for the user,
# bash-breadcrumbs would be installed $USER_HOME/.bash-breadcrumbs directory.
USER_HOME="${HOME}"

# Checks if the script is running with sudo, and identify the invoking user.
if [[ -n "${SUDO_COMMAND+x}" &&  -n "${SUDO_USER+x}" ]]; then
    # If the command is not "sudo su", use the home directory of the sudo user.
    # This allows installations to be performed under the correct user's home directory.
    if [[ "${SUDO_COMMAND}" != "/usr/bin/su" ]]; then
        USER_HOME=$(eval echo ~$SUDO_USER)
    fi
fi

install() {
    local workdir="${USER_HOME}/.bash-breadcrumbs"
    local workfile=bash-breadcrumbs
    local sourceline="source \"\${HOME}/.bash-breadcrumbs/${workfile}\""
    local confile=""

    mkdir -p "${workdir}"

    pushd . >/dev/null
    cd "${workdir}"

    curl -L -o bash-breadcrumbs \
         "https://raw.githubusercontent.com/anrs/bash-breadcrumbs/main/${workfile}"

    chmod +x "${workfile}"

    popd >/dev/null

    if [[ -f "${USER_HOME}/.bashrc" ]]; then
        confile="${USER_HOME}/.bashrc"
    elif [[ -f "${USER_HOME}/.bash_profile" ]]; then
        confile="${USER_HOME}/.bash_profile"

    else
        echo 'bash configuration file was not found, please execute the following line manually:'
        echo "echo -e \"\\n${sourceline}\" >> <YOUR BASH CONFIG FILE>\""
        exit 1
    fi

    echo -e "\n${sourceline}" >>"${confile}"
    echo "${workdir}/${workfile} has been installed."
    echo "You may need to reload your bash configuration ${confile}"
}

install
