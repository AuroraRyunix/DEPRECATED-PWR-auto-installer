# PWR-RUN

PWR-RUN is a simple shell script for managing the PWR Validator Nodes. It automates the process of starting and restarting the PWR Runner application and provides a convenient way to configure the application's arguments (like IP wallet adres etc) and password.

## Features

- **Easy Installation:** Install and set up PWR-RUN with a few simple steps.
- **Automatic Restart:** PWR-RUN automatically restarts the application if it crashes.
- **Argument Configuration:** Edit the `arguments.txt` file to specify the commands you want to run.
- **Password Configuration:** Edit the `password.txt` file to provide the required password.
- **ERROR HANDLING** automatically shows errors in a GTK window, and allows you to directly fix them using interactive buttons
![Error Image](https://github.com/AuroraRyunix/PWR-auto-installer/blob/main/error-images/error-typical.png)


## Prerequisites

- Linux-based operating system (e.g., Debian, Ubuntu, CentOS, Fedora, Arch Linux)
- OpenJDK 19 (Java Runtime Environment) will be automatically installed

## Installation

1. Clone or download this repository to your local machine.

```shell
git clone https://github.com/your-username/PWR-RUN.git
```

2. Run the installation script with root privileges to set up PWR-RUN and make sure it's executable:

```shell
cd PWR-RUN
sudo bash install-PWR-RUN-cron.sh
```

This script will check if Java is installed and install it if necessary, create the necessary directories and files, and add a cron job for automatic startup.

**Note:** If you encounter any issues during installation, please follow the instructions provided by the script.

## Usage

### Running the Application

After installation, the PWR Runner application will automatically start on system reboot. If you wish to run it manually, execute the following command:

```
PWR-RUN.sh
```

The `PWR-RUN.sh` script can be used to manually start or restart the PWR Runner application.

## License

This project is licensed under the **GNU General Public License v3.0**. See the [LICENSE](LICENSE) file for details.

---

Made by [Aurora Ryunix]

Questions or feedback? [Create an issue](https://github.com/AuroraRyunix/PWR-auto-installer/issues).

