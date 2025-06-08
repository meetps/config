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
                               help="Component to update (e.g., vim, tmux, zsh).")
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
            # Placeholder for laptop install playbook
            # playbook_to_run = 'playbooks/install_laptop.yml'
            print(f"Laptop installation not yet fully implemented. Running basic setup.")
            playbook_to_run = 'playbooks/basic_setup.yml'
        else:
            print(f"Unknown install type: {args.type}. Running basic setup.")
            playbook_to_run = 'playbooks/basic_setup.yml'

    elif args.command == "update":
        if args.component == "zsh":
            playbook_to_run = 'playbooks/update_zsh.yml'
        elif args.component == "tmux":
            playbook_to_run = 'playbooks/update_tmux.yml'
        elif args.component:
            # Placeholder for other component updates
            # For example, could map components to specific update playbooks
            # if args.component == "vim":
            # playbook_to_run = 'playbooks/update_vim.yml'
            print(f"Update for component '{args.component}' not yet specifically implemented. Running basic setup.")
            playbook_to_run = 'playbooks/basic_setup.yml'
        else:
            # Generic update if no component is specified, could be a general update playbook
            print("No specific component specified for update. Running basic setup.")
            playbook_to_run = 'playbooks/basic_setup.yml'

    if playbook_to_run:
        run_playbook(playbook_to_run)
    else:
        print("No playbook determined for the given arguments.")

if __name__ == "__main__":
    main()
