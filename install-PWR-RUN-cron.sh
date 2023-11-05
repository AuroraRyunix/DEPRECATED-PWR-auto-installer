#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script should be run as root."
    exit 1
fi

# Check if Java is installed
if ! command -v java &>/dev/null; then
    echo "Java is not installed. Checking your system..."

    # Check for Debian/Ubuntu
    if [ -f /etc/debian_version ]; then
        echo "Debian/Ubuntu based system detected. Installing OpenJDK 19..."
        apt-get update
        apt-get install openjdk-19-jre -y
    # Check for CentOS/RHEL
    elif [ -f /etc/redhat-release ]; then
        echo "CentOS/RHEL based system detected. Installing OpenJDK 19..."
        yum install java-19-openjdk -y
    # Check for Fedora
    elif [ -f /etc/fedora-release ]; then
        echo "Fedora based system detected. Installing OpenJDK 19..."
        dnf install java-19-openjdk -y
    # Check for Arch Linux
    elif [ -f /etc/arch-release ]; then
        echo "Arch Linux detected. Installing OpenJDK 19..."
        pacman -S jre-openjdk-headless -y
    else
        echo "Unsupported system. Please install OpenJDK 19 manually."
        exit 1
    fi

    # Verify Java installation
    if ! command -v java &>/dev/null; then
        echo "Java installation failed. Please install OpenJDK 19 manually."
        exit 1
    else
        echo "Java installed successfully."
    fi
fi

# Create the PWR-runner directory in the home folder
DEST_DIR="$HOME/PWR-runner"
SCRIPT_NAME="PWR-RUN.sh"

# Check if the PWR-RUN.sh script exists and is not empty
if [ ! -s "$SCRIPT_NAME" ]; then
    echo "The PWR-RUN.sh script is missing or empty. Please ensure it exists and contains your script."
    exit 1
fi

# Create the destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
fi

# Copy the PWR-RUN.sh script to the PWR-runner directory
cp "$SCRIPT_NAME" "$DEST_DIR/$SCRIPT_NAME"

# Make the script executable
chmod +x "$DEST_DIR/$SCRIPT_NAME"

echo "Script copied to $DEST_DIR."

# Check if the crontab entry already exists for the root user
CRONTAB_ENTRY="@reboot sh $DEST_DIR/$SCRIPT_NAME"
if ! (crontab -l -u root | grep -Fxq "$CRONTAB_ENTRY"); then
    # Add a cron job to run the script at boot for the root user
    (crontab -l -u root; echo "$CRONTAB_ENTRY") | crontab -u root -
    echo "Crontab entry added to run the script at boot for the root user."
else
    echo "Crontab entry for the root user already exists. No changes made."
fi

# Provide instructions for setting up the PWR-RUN alias
echo -e "\033[1mSuccessfully installed PWR-RUN. To run it, you can set up the alias 'PWR-RUN' in your shell configuration. Here's an example of how to do it:"
echo "1. Open your shell configuration file (e.g., .bashrc, .zshrc, or .bash_aliases) in a text editor."
echo "2. Add the following line to the file:"
echo "   alias PWR-RUN='pkill -f PWR-RUN.sh && sh \$HOME/PWR-runner/PWR-RUN.sh'"
echo "3. Save the file and reopen your terminal."
echo -e "After doing this, you can use the \033[1m'PWR-RUN'\033[0m command to start or restart the PWR-RUN.sh script."
echo "Made by Aurora Ryunix"
