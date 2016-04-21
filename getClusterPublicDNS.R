
getClusterPublicDNS = function(region)
{
	fn = "aws/.awsInstancesLaunched.json"
	baseCommand = paste0("aws --region ", region, " ec2 describe-instances --instance-ids")
	writeToFile = paste0(" > ", fn, " 2>&1")
	instanceIdString = " "
	for(i in 1:length(clusterInfo$InstanceId))
	{
		instanceIdString = paste(instanceIdString, clusterInfo$InstanceId[i], sep = " ")
	}
	baseCommand = paste0(baseCommand, instanceIdString, writeToFile)
	system(baseCommand)
	awsInstanceJSON = readChar(fn, file.info(fn)$size)
	parser <- newJSONParser()
	awsInstanceInfo = parser$addData(awsInstanceJSON)
	awsInstanceList = parser$getObject()
	n = length(awsInstanceList[[1]][[1]][[4]])
	publicDNS = rep(NA, n)
	for(i in 1:n)
	{
		publicDNS[i] = awsInstanceList[[1]][[1]][[4]][[i]]$PublicDnsName
	}
	return(publicDNS)
}
