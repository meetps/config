import unittest
from unittest.mock import patch, MagicMock, ANY
import sys
import argparse

# Add project root to sys.path to allow importing manage_config
# This might need adjustment based on the actual execution environment of tests
sys.path.insert(0, '.')
import manage_config

class TestManageConfig(unittest.TestCase):

    def _run_main_with_args(self, args_list):
        # Patch sys.argv to simulate command line arguments
        with patch.object(sys, 'argv', ['manage_config.py'] + args_list):
            # Patch manage_config.run_playbook to prevent actual playbook execution
            # and to allow us to assert it was called correctly.
            with patch('manage_config.run_playbook') as mock_run_playbook:
                # We also need to ensure that print calls within main() do not cause issues
                # if they are not expected or if they go to stdout during tests.
                with patch('builtins.print') as mock_print:
                    manage_config.main()
                return mock_run_playbook

    def test_install_server(self):
        mock_run_playbook = self._run_main_with_args(['install', '--type', 'server'])
        mock_run_playbook.assert_called_once_with('playbooks/install_server.yml')

    def test_install_laptop(self):
        mock_run_playbook = self._run_main_with_args(['install', '--type', 'laptop'])
        mock_run_playbook.assert_called_once_with('playbooks/install_laptop.yml')

    def test_update_zsh(self):
        mock_run_playbook = self._run_main_with_args(['update', '--component', 'zsh'])
        mock_run_playbook.assert_called_once_with('playbooks/update_zsh.yml')

    def test_update_tmux(self):
        mock_run_playbook = self._run_main_with_args(['update', '--component', 'tmux'])
        mock_run_playbook.assert_called_once_with('playbooks/update_tmux.yml')

    def test_update_nvim(self):
        mock_run_playbook = self._run_main_with_args(['update', '--component', 'nvim'])
        mock_run_playbook.assert_called_once_with('playbooks/update_nvim.yml')

    def test_update_urxvt(self):
        mock_run_playbook = self._run_main_with_args(['update', '--component', 'urxvt'])
        mock_run_playbook.assert_called_once_with('playbooks/update_urxvt.yml')

    def test_update_i3(self):
        mock_run_playbook = self._run_main_with_args(['update', '--component', 'i3'])
        mock_run_playbook.assert_called_once_with('playbooks/update_i3.yml')

    def test_update_no_component(self):
        # When 'update' is called but no '--component' is specified.
        mock_run_playbook = self._run_main_with_args(['update'])
        mock_run_playbook.assert_called_once_with('playbooks/basic_setup.yml')

    def test_install_missing_type(self):
        # Test that argparse causes a SystemExit if --type is missing for install
        with patch.object(sys, 'argv', ['manage_config.py', 'install']):
            with patch('builtins.print') as mock_print: # Mock print to suppress error messages from argparse
                with self.assertRaises(SystemExit):
                    manage_config.main()


    def test_update_invalid_component(self):
        # Test that argparse causes a SystemExit if --component has an invalid choice
        with patch.object(sys, 'argv', ['manage_config.py', 'update', '--component', 'invalid_choice']):
            with patch('builtins.print') as mock_print: # Mock print to suppress error messages from argparse
                with self.assertRaises(SystemExit):
                    manage_config.main()

if __name__ == '__main__':
    # To run tests from the command line (e.g. python tests/test_manage_config.py)
    # Need to ensure that the script can find 'manage_config' module.
    # If running directly, make sure PYTHONPATH includes the project root or use 'python -m tests.test_manage_config' from root.
    unittest.main(argv=['first-arg-is-ignored'], exit=False)
