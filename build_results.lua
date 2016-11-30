local module = {} 

module.build_results = {
    status = {},
    result = {}
}

module.status = {
    completed = "completed",
    inProgress = "inProgress", 
    completed = "completed",
    cancelling = "cancelling", 
    postponed = "postponed", 
    notStarted = "notStarted",

}

module.result = {
    succeeded = "succeeded",
    partiallySucceeded = "partiallySucceeded", 
    failed = "failed", 
    canceled = "canceled"
}


return module
