import os
import subprocess

def install_packages(package_manager, packages):
    for package in packages:
        try:
            subprocess.run([package_manager, 'install', '-y', package], check=True)
        except subprocess.CalledProcessError:
            print(f"Failed to install {package}")
            exit(1)

def configure_git():
    gitconfig = input("Want to configure git? (y/n): ")
    if gitconfig.lower() == 'y':
        username = input("What is your GitHub username? ")
        subprocess.run(['git', 'config', '--global', 'user.name', username])
        useremail = input("What is your email address? ")
        subprocess.run(['git', 'config', '--global', 'user.email', useremail])

def add_ssh_key():
    sshready = input("Ready to add ssh-key? (y/n): ")
    if sshready.lower() == 'y':
        print("Do not change the default file location and name in the following!!!")
        email = input("What is your email address? ")
        subprocess.run(['ssh-keygen', '-t', 'ed25519', '-C', email])
        subprocess.run(['ssh-add', os.path.expanduser('~/.ssh/id_ed25519')])
        with open(os.path.expanduser('~/.ssh/id_ed25519.pub'), 'r') as f:
            print("Paste the following content in your ssh-key section on GitHub:")
            print(f.read())

def add_wallpaper():
    wallpaper_dir = os.path.expanduser('~/Pictures/wallpaper')
    if not os.path.exists(wallpaper_dir):
        os.makedirs(wallpaper_dir)
    src = os.path.expanduser('~/Linux/wallpaper/')
    try:
        for item in os.listdir(src):
            subprocess.run(['cp', '-a', os.path.join(src, item), wallpaper_dir])
        print("Finished adding wallpapers!")
    except Exception as e:
        print(f"Failed to add wallpapers: {e}")

def setup_configurations(shell_type):
    config_map = {
        'btop': 'btop.conf',
        'fish': f'fedora.fish' if shell_type == 'fedora' else 'debian.fish',
        'zsh': f'fedorazshrc' if shell_type == 'fedora' else 'debianzshrc',
    }
    
    for app, config_file in config_map.items():
        config_path = os.path.expanduser(f'~/.config/{app}')
        if not os.path.exists(config_path):
            os.makedirs(config_path)
        
        if config_file:
            subprocess.run(['cp', os.path.expanduser(f'~/Linux/{app}/{config_file}'), config_path])
        else:
            src = os.path.expanduser(f'~/Linux/{app}/.')
            subprocess.run(['cp', '-a', src, config_path])
        
        print(f"Finished adding {app} config!")

def main():
    package_managers = {
        '1': ('apt', 'debian'),
        '2': ('dnf', 'fedora'),
    }
    
    print("What package manager do you use?")
    print("(1) apt (Debian)")
    print("(2) dnf (Fedora)")

    answer = input("Select an option: ")
    package_manager, shell_type = package_managers.get(answer, (None, None))

    if not package_manager:
        print("Do not know what to do, Bye!!")
        exit(223)

    packages = ["zip", "zsh", "openrgb", "fish", "unzip", "wget", "curl",
                "neovim", "eza", "neofetch", "btop", "gamemode", "mangohud",
                "zoxide", "fzf", "bat", "kitty"]

    install_packages(package_manager, packages)
    configure_git()
    add_ssh_key()
    setup_configurations(shell_type)

    print("Adding kitty config")
    kitty_path = os.path.expanduser(f'~/.config/kitty')
    if not os.path.exists(kitty_path):
        os.makedirs(kitty_path)

    subprocess.run(['cp', '-a', os.path.expanduser(f'~/Linux/kitty/.'), kitty_path])

    print("Finished!")
    
    add_wallpaper()

    print("Adding font and cursor")
    try:
        subprocess.run(['sudo', 'cp', os.path.expanduser('~/Linux/Fonts/MesloLGS NF Regular.ttf'), '/usr/share/fonts/'])
        subprocess.run(['sudo', 'cp', '-r', os.path.expanduser('~/Linux/Cursor/Bibata-Modern-Ice/'), '/usr/share/icons/'])
        print("Finished!")
    except Exception as e:
        print(f"Failed to add font and cursor: {e}")

if __name__ == "__main__":
    main()
