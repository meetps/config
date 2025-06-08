import pytest
from unittest.mock import patch, MagicMock
import sys

# Add the parent directory to sys.path to allow importing manage_config
sys.path.insert(0, '.')
import manage_config

@pytest.fixture
def parser():
    return manage_config.create_parser()

def test_install_server(parser):
    args = parser.parse_args(["install", "--type", "server"])
    assert args.command == "install"
    assert args.type == "server"

def test_install_laptop(parser):
    args = parser.parse_args(["install", "--type", "laptop"])
    assert args.command == "install"
    assert args.type == "laptop"

def test_update_component(parser):
    args = parser.parse_args(["update", "--component", "vim"])
    assert args.command == "update"
    assert args.component == "vim"

def test_update_no_component(parser):
    args = parser.parse_args(["update"])
    assert args.command == "update"
    assert args.component is None

@patch('manage_config.ansible_runner.run')
def test_run_playbook_called_on_install(mock_ansible_run):
    mock_ansible_run.return_value = MagicMock(rc=0, status='successful')
    with patch.object(sys, 'argv', ['manage_config.py', 'install', '--type', 'server']):
        manage_config.main()
    mock_ansible_run.assert_called_once_with(playbook='playbooks/basic_setup.yml')

@patch('manage_config.ansible_runner.run')
def test_run_playbook_called_on_update(mock_ansible_run):
    mock_ansible_run.return_value = MagicMock(rc=0, status='successful')
    with patch.object(sys, 'argv', ['manage_config.py', 'update', '--component', 'vim']):
        manage_config.main()
    mock_ansible_run.assert_called_once_with(playbook='playbooks/basic_setup.yml')

@patch('manage_config.ansible_runner.run')
def test_run_playbook_called_on_update_no_component(mock_ansible_run):
    mock_ansible_run.return_value = MagicMock(rc=0, status='successful')
    with patch.object(sys, 'argv', ['manage_config.py', 'update']):
        manage_config.main()
    mock_ansible_run.assert_called_once_with(playbook='playbooks/basic_setup.yml')
