# Vault on Nomad

Need to run a Consul container in dev mode or it'll throw errors (known bug - https://github.com/hashicorp/waypoint/issues/3376)

Run Nomad in dev mode:

`nomad agent -dev -bind 0.0.0.0`

cd into this directory.

Launch Vault as a Nomad job:
`nomad job run vault_nomad_raft.hcl`

Check the status of Vault:
`nomad status vault`


The port will be forwarded by Nomad. 

### To access Vault:

In the Nomad UI, you can find the host port information by following these steps:

Open the Nomad UI in your web browser by navigating to http://<nomad_server_ip>:4646, where <nomad_server_ip> is the IP address of your Nomad server.

Click on the "Jobs" tab in the left-hand menu.

Find your job in the list (in your case, the "vault" job) and click on it.

Click on the "Allocations" tab under your job's details.

Find the allocation that you're interested in and click on the allocation ID.

In the Allocation details page, scroll down to the "Task Resources" section.

In the "Task Resources" section, find the "Network" resource. You will see a table with columns labeled "Label", "Dynamic Port", "Host", and "To". The "Dynamic Port" column shows the host ports allocated for your container's ports.

For example, if you see the following table:

css
Copy code
| Label   | Dynamic Port | Host    | To  |
|---------|--------------|---------|-----|
| vault   | 32100        | 10.0.0.1| 8200|
| cluster | 32101        | 10.0.0.1| 8201|
This means that the vault port (8200) inside the container is mapped to port 32100 on the host machine with IP address 10.0.0.1, and the cluster port (8201) inside the container is mapped to port 32101 on the same host machine.

You can use these host IP and port information to connect to your container's services from your host machine or external network.

Demonstrating the above:

```
[15:43] conormccullough | ~ -> curl http://127.0.0.1:32101/v1/sys/health
{"initialized":false,"sealed":true,"standby":true,"performance_standby":false,"replication_performance_mode":"unknown","replication_dr_mode":"unknown","server_time_utc":1680932620,"version":"1.13.1"}
```

# Additional Stuff

## Exec into Nomad container

### Find the Nomad allocation ID:

```
16:03] conormccullough | ~ -> nomad job status vault
ID            = vault
Name          = vault
Submit Date   = 2023-04-08T15:29:02+10:00
Type          = service
Priority      = 50
Datacenters   = dc1
Namespace     = default
Status        = running
Periodic      = false
Parameterized = false

Summary
Task Group  Queued  Starting  Running  Failed  Complete  Lost  Unknown
vault       0       0         1        0       0         0     0

Latest Deployment
ID          = 27dd8ca7
Status      = failed
Description = Failed due to progress deadline

Deployed
Task Group  Desired  Placed  Healthy  Unhealthy  Progress Deadline
vault       1        1       0        1          2023-04-08T15:39:02+10:00

Allocations
ID        Node ID   Task Group  Version  Desired  Status   Created    Modified
36d3cc8f  19a97257  vault       0        run      running  34m9s ago  29m9s ago
```

### Exec into container:

```
[16:03] conormccullough | ~ -> nomad alloc exec 36d3cc8f /bin/sh
/ # ps
PID   USER     TIME  COMMAND
    1 root      0:00 {docker-entrypoi} /usr/bin/dumb-init /bin/sh /usr/local/bin/docker-entrypoint.sh server -config=/local/vault.hcl
    7 vault     0:05 vault server -config=/vault/config -dev-root-token-id= -dev-listen-address=0.0.0.0:8200 -config=/local/vault.hcl
   53 root      0:00 /bin/sh
   59 root      0:00 ps
```