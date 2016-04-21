

# A function for killing off a bunch of worker nodes
terminateAWSNodes = function(instanceIds)
{
	# aws ec2 terminate-instances --instance-ids i-657dc9ba
	baseCommand = "aws ec2 terminate-instances --instance-ids "
	toFileCommand = " > aws/.awsInstanceTermination.json 2>&1"
	for(i in 1:length(instanceIds))
	{
		thisCommand = paste0(baseCommand, instanceIds[i], toFileCommand)
		system(thisCommand)
	}
}
