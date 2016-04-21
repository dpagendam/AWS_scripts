library(snowfall)
library(rjson)

# start a cluster of AMIs and save all output into a .json file
amiID = "ami-xxxxxxx"
instanceType = "r3.xlarge"
numWorkers = 3
keyName = "myKey_syd"
securityGroupID = "sg-xxxxxxxxx"
system(paste0("aws ec2 run-instances --image-id ", amiID, " --count ", numWorkers, " --instance-type ", instanceType, " --key-name ", keyName, " --security-group-ids ", securityGroupID, " > .awsInstances.json 2>&1"))

fn <- 'aws/.awsInstances.json'

clusterInfo = getAWSNodeInfo(fn)

waitForClusterLaunch(clusterInfo$InstanceId)

region = "ap-southeast-2"
clusterDNSAddresses = as.list(getClusterPublicDNS(region))

masterIP = readLines("aws/.amazonip")

mySSH_key = "~/.ssh/myKey.pem"
setDefaultClusterOptions(rshcmd = "ssh -o StrictHostKeyChecking=no -i " mySSH_key, user = " ubuntu", homogeneous = FALSE, master = masterIP)
sfInit(parallel = TRUE, cpus = numWorkers, type = "SOCK", socketHosts = clusterDNSAddresses, slaveOutfile="~/snow.out")

sfExportAll()

#Do something here with parLapply
clusterOutputs = parLapply())

sfStop()

# Kill all the instances
terminateAWSNodes(clusterInfo$InstanceId)
