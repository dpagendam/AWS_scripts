
waitForClusterLaunch = function(instanceIds)
{
	Sys.sleep(30)
	fn = "aws/.instanceStatus.json"
	baseCommand = "aws ec2 describe-instance-status --instance-ids "
	writeToFile = paste0(" > ", fn, " 2>&1")
	done = FALSE
	checkCounter = 0
	while(!done)
	{
		okCount = 0
		for(i in 1:length(instanceIds))
		{
			thisCommand = paste0(baseCommand, instanceIds[i], writeToFile)
			system(thisCommand)
			awsInstanceStatusJSON = readChar(fn, file.info(fn)$size)
			parser <- newJSONParser()
			parser$addData(awsInstanceStatusJSON)
			awsInstanceList = parser$getObject()
			if(awsInstanceList[[1]][[1]][[4]]$Status == "ok")
			{
				okCount = okCount + 1
			}
		}
		if(okCount == length(instanceIds))
		{
			done = TRUE
		}
		else
		{
			checkCounter = checkCounter + 1
			if(checkCounter > 20)
			{
				return("timed out")
			}
			Sys.sleep(30)
		}

	}
	return("all ok")
}
