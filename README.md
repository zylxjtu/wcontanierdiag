# wcontanierdiag
Diagnostic for windows container

This is to deploy a HPC container to collect diagnostic logs from customer's container to MSFT, this will apply to AKS cluster.

In order to help MSFT to facilitate the windows container related diagnostics, customer will: 

(1): Collect the AKS cluster related config info and update the env.sh file.

(2): If AKS cluster does not exist yet, please run the createcluster.sh.

(3): Run addmitocluster.sh to create/assign the user-assigned MI to the AKS node pool, this will be used to auth the MSFT logging server, customer will need to let MSFT know the tenantIdd/principalId of the MI, which will be outputted from the addmitocluster.sh.

(4): Customer can always get the USMI info from the getmis.sh script.

(5): Run the startmonagent.sh to deploy the HPC container and start the diagnostic logging. 

(6): After the finishing of the diagnostics, run cleanup.sh to clean the HPC container and USMI resource.
