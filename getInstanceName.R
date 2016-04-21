getInstanceName = function(numProcessors = 0, ram = 0, diskSpace = 0, numGPUs = 0, budget = Inf, instanceType = "")
{
	if(is.na(numProcessors))
	{
		numProcessors = 0
	}
	if(is.na(ram))
	{
		ram = 0
	}
	if(is.na(diskSpace))
	{
		diskSpace = 0
	}
	if(is.na(numGPUs))
	{
		numGPUs = 0
	}
	
	instanceName_T2 = c("t2.nano", "t2.micro", "t2.small", "t2,medium", "t2.large")
	vCPUs_T2 = c(1,1,1,2,2)
	memory_T2 = c(0.5, 1, 2, 4, 8)
	storage_T2 = rep(0, 5)
	gpu_T2 = rep(0, 5)
	prices_T2 = c(0.01, 0.02, 0.04, 0.08, 0.16)
	
	instanceName_M4 = c("m4.large", "m4.xlarge", "m4.2xlarge", "m4.4xlarge", "m4.10xlarge")
	vCPUs_M4 = c(2,4,8,16, 40)
	memory_M4 = c(8, 16, 32, 64, 160)
	storage_M4 = rep(0, 5)
	gpu_M4 = rep(0, 5)
	prices_M4 = c(0.168, 0.336, 0.673, 1.345, 3.363)
	
	instanceName_M3 = c("m4.medium", "m3.large", "m3.xlarge", "m3.2xlarge")
	vCPUs_M3 = c(1,2,4,8)
	memory_M3 = c(3.75, 7.5, 15, 30)
	storage_M3 = c(4, 32, 80, 160)
	gpu_M3 = rep(0, 4)
	prices_M3 = c(0.093, 0.186, 0.372, 0.745)
	
	instanceName_C4 = c("c4.large", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "c4.8xlarge")
	vCPUs_C4 = c(2, 4, 8, 16, 36)
	memory_C4 = c(3.75, 7.5, 15, 30, 60)
	storage_C4 = rep(0, 5)
	gpu_C4 = rep(0, 5)
	prices_C4 = c(0.137, 0.275, 0.549, 1.097, 2.195)
	
	instanceName_C3 = c("c3.large", "c3.xlarge", "c3.2xlarge", "c3.4xlarge", "c3.8xlarge")
	vCPUs_C3 = c(2, 4, 8, 16, 36)
	memory_C3 = c(3.75, 7.5, 15, 30, 60)
	storage_C3 = c(32, 80, 160, 320, 640)
	gpu_C3 = rep(0, 5)
	prices_C3 = c(0.132, 0.265, 0.529, 1.058, 2.117)
	
	instanceName_G2 = c("g2.2xlarge", "g2.8xlarge")
	vCPUs_G2 = c(8, 32)
	memory_G2 = c(15, 60)
	storage_G2 = c(60, 240)
	gpu_G2 = c(1,4)
	prices_G2 = c(0.898, 3.592)
	
	instanceName_R3 = c("r3.large", "r3.xlarge", "r3.2xlarge", "r3.4xlarge", "r3.8xlarge")
	vCPUs_R3 = c(2,4,8,16,32)
	memory_R3 = c(15.25, 30.5, 61, 122, 244)
	storage_R3 = c(32, 180, 160, 320, 640)
	gpu_R3 = rep(0, 5)
	prices_R3 = c(0.2, 0.399, 0.798, 1.596, 3.192)
	
	instanceName_I2 = c("i2.xlarge", "i2.2xlarge", "i2.4xlarge", "i2.8xlarge")
	vCPUs_I2 = c(4,8,16,32)
	memory_I2 = c(30.5, 61, 122, 244)
	storage_I2 = c(800, 1600, 3200, 6400)
	gpu_I2 = rep(0, 4)
	prices_I2 = c(1.018, 2.035, 4.07, 8.14 )
	
	instanceName_D2 = c("d2.xlarge", "d2.2xlarge", "d2.4xlarge", "d2.8xlarge")
	vCPUs_D2 = c(4,8,16,36)
	memory_D2 = c(30.5, 61, 122, 244)
	storage_D2 = c(6000, 12000, 24000, 48000)
	gpu_D2 = rep(0, 4)
	prices_D2 = c(0.87, 1.74, 3.48, 6.96)
	
	instanceNames = c(instanceName_R3, instanceName_T2, instanceName_M4, instanceName_M3, instanceName_C4, instanceName_C3, instanceName_G2, instanceName_I2, instanceName_D2)
	vCPUs = c(vCPUs_R3, vCPUs_T2, vCPUs_M4, vCPUs_M3, vCPUs_C4, vCPUs_C3, vCPUs_G2, vCPUs_I2, vCPUs_D2)
	memory = c(memory_R3, memory_T2, memory_M4, memory_M3, memory_C4, memory_C3, memory_G2, memory_I2, memory_D2)
	storage = c(storage_R3, storage_T2, storage_M4, storage_M3, storage_C4, storage_C3, storage_G2, storage_I2, storage_D2)
	gpu = c(gpu_R3, gpu_T2, gpu_M4, gpu_M3, gpu_C4, gpu_C3, gpu_G2, gpu_I2, gpu_D2)
	prices = c(prices_R3, prices_T2, prices_M4, prices_M3, prices_C4, prices_C3, prices_G2, prices_I2, prices_D2)
	
	gotCPU = (vCPUs >= numProcessors)
	gotMemory = (memory >= ram)
	gotStorage = (storage >= diskSpace)
	gotGPU = (gpu >= numGPUs)
	gotPrice = (prices <= budget)

	ind = which(gotCPU & gotMemory & gotStorage & gotGPU & gotPrice)
	return(list(instanceNames = instanceNames[ind], CPUs = vCPUs[ind], RAM = memory[ind], HD = storage[ind], GPU = gpu[ind], PriceAUD = prices[ind]))
}

