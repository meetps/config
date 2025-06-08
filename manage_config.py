import argparse
import ansible_runner

def run_playbook(playbook_path):
    """
    Runs the given Ansible playbook.
    """
    print(f"Running playbook: {playbook_path}")
    r = ansible_runner.run(playbook=playbook_path)
    print("{}: {}".format(r.status, r.rc))
    # Successful Ansible run results in rc=0
    if r.rc != 0:
        print(f"Ansible playbook failed: {r.events}")
    return r.rc

def create_parser():
    parser = argparse.ArgumentParser(description="Manage system configuration.")
    subparsers = parser.add_subparsers(dest="command", required=True)

    # Install command
    install_parser = subparsers.add_parser("install", help="Install system configuration.")
    install_parser.add_argument("--type", type=str, choices=["server", "laptop"], required=True,
                                help="Type of installation (server or laptop).")

    # Update command
    update_parser = subparsers.add_parser("update", help="Update system components.")
    update_parser.add_argument("--component", type=str,
                               choices=["zsh", "tmux", "nvim", "urxvt", "i3"], # Added new components
                               help="Component to update (e.g., vim, tmux, zsh, nvim, urxvt, i3).")
    return parser

def main():
    parser = create_parser()
    args = parser.parse_args()

    print(f"Parsed arguments: {args}")

    playbook_to_run = None

    if args.command == "install":
        if args.type == "server":
            playbook_to_run = 'playbooks/install_server.yml'
        elif args.type == "laptop":
            playbook_to_run = 'playbooks/install_laptop.yml' # Updated for laptop
        # No else needed here due to choices in argparse for --type

    elif args.command == "update":
        if args.component == "zsh":
            playbook_to_run = 'playbooks/update_zsh.yml'
        elif args.component == "tmux":
            playbook_to_run = 'playbooks/update_tmux.yml'
        elif args.component == "nvim": # Added nvim
            playbook_to_run = 'playbooks/update_nvim.yml'
        elif args.component == "urxvt": # Added urxvt
            playbook_to_run = 'playbooks/update_urxvt.yml'
        elif args.component == "i3": # Added i3
            playbook_to_run = 'playbooks/update_i3.yml'
        elif args.component: # This case might not be reachable if choices are strict
            print(f"Update for component '{args.component}' not specifically implemented. Running basic setup.")
            playbook_to_run = 'playbooks/basic_setup.yml'
        else: # If --component is not provided at all
            print("No specific component specified for update. Running basic setup for now.")
            # Potentially, this could run a general "update all installed components" playbook in the future.
            playbook_to_run = 'playbooks/basic_setup.yml'


    if playbook_to_run:
        run_playbook(playbook_to_run)
    else:
        # This condition should ideally not be met if arguments are handled correctly
        print("No playbook determined for the given arguments. This might indicate an issue.")

if __name__ == "__main__":
    main()
