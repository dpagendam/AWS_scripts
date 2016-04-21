
getAWSNodeInfo = function(awsInstanceJSON)
{
	awsInstanceJSON = readChar(awsInstanceJSON, file.info(awsInstanceJSON)$size)

	parser <- newJSONParser()
	parser$addData(awsInstanceJSON)
	awsInstanceList = parser$getObject()$Instances
	nodeDNSName = rep(NA, length(awsInstanceList))
	nodeInstanceId = rep(NA, length(awsInstanceList))
	for(i in 1:length(nodeDNSName))
	{
		nodeDNSName[i] = awsInstanceList[[i]]$PrivateDnsName
		nodeInstanceId[i] = awsInstanceList[[i]]$InstanceId
	}
	return(list(DNSName = nodeDNSName, InstanceId = nodeInstanceId))
}
