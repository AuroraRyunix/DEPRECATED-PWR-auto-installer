#!/bin/bash

# Define the user's home directory and the application directory
USER_HOME="$HOME"
APP_DIR="$USER_HOME/PWR-runner"

# Create the application directory if it doesn't exist
if [ ! -d "$APP_DIR" ]; then
    mkdir -p "$APP_DIR"
fi

# Change to the application directory
cd "$APP_DIR" || exit

# Create or update the argument configuration file
ARG_FILE="$APP_DIR/arguments.txt"
if [ ! -f "$ARG_FILE" ]; then
    touch "$ARG_FILE"
fi

# Create or update the password file
PASSWORD_FILE="$APP_DIR/password.txt"
if [ ! -f "$PASSWORD_FILE" ]; then
    touch "$PASSWORD_FILE"
fi

# Check if the argument configuration file is empty
if [ ! -s "$ARG_FILE" ]; then
    response=$(zenity --error --title="PWR system ERROR" --text="The arguments.txt file is empty. Please open it and specify the commands." --extra-button="Edit Arguments")
    if [ "$response" = "Edit Arguments" ]; then
        xdg-open "$ARG_FILE"
        exit 1
    fi
fi

# Check if the password file is empty
if [ ! -s "$PASSWORD_FILE" ]; then
    response=$(zenity --error --title="PWR system ERROR" --text="The password.txt file is empty. Please open it and provide a password." --extra-button="Edit Password")
    if [ "$response" = "Edit Password" ]; then
        xdg-open "$PASSWORD_FILE"
        exit 1
    fi
fi

# Download the JAR file from GitHub
JAR_URL="https://github.com/pwrlabs/PWR-Validator-Node/raw/main/validator.jar"
wget -O app.jar "$JAR_URL"

# Read arguments from the configuration file
ARGS=$(<"$ARG_FILE")

# Read the password from the password file
PASSWORD=$(<"$PASSWORD_FILE")

# Define the command to run the downloaded JAR file with the arguments and password
RUN_COMMAND="java -jar app.jar $ARGS $PASSWORD"

# Start the application
$RUN_COMMAND

# Ensure the script exits only when the application terminates
while true; do
    if ! pgrep -f "$RUN_COMMAND" > /dev/null; then
        response=$(zenity --error --title="PWR system ERROR" --text="The application has crashed. Restarting..." --extra-button="Edit Files")
        if [ "$response" = "Edit Files" ]; then
            if [ -s "$ARG_FILE" ]; then
                response_arg=$(zenity --question --title="Edit Arguments" --text="Edit arguments.txt?")
                if [ "$response_arg" = "1" ]; then
                    xdg-open "$ARG_FILE"
                fi
            fi
            if [ -s "$PASSWORD_FILE" ]; then
                response_password=$(zenity --question --title="Edit Password" --text="Edit password.txt?")
                if [ "$response_password" = "1" ]; then
                    xdg-open "$PASSWORD_FILE"
                fi
            fi
        fi
        $RUN_COMMAND
    fi
    sleep 10
done
