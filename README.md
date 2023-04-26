Replace `redhat_servers` in the `hosts` line with the group name of your Red Hat-based servers in the inventory file.

To run the playbook, use the following command:

```sh
ansible-playbook -i /path/to/inventory/hosts jenkins_install.yml
```

Once the playbook has completed, you can access the Jenkins web interface by navigating to `http://<your_server_ip>:8080`. To unlock Jenkins, follow the instructions provided on the web interface to retrieve the initial admin password from the target server.
