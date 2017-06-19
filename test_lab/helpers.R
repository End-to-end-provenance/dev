ddg2net <- function(x = "PROV-JSON list",group = "rdt:type",value = "rdt:elapsedTime"){
    activity <- do.call(rbind,x$activity[names(x$activity) != "environment"])
    entity <- do.call(rbind,x$entity)
    wasInformedBy <- do.call(rbind,x$wasInformedBy)
    wasGeneratedBy <- do.call(rbind,x$wasGeneratedBy)
    used <- do.call(rbind,x$used)
    val <- unlist(activity[,value])
    val <- as.numeric(val)
    val <- cumsum(val[-1] - val[1])
    val <- val / max(val)
    val <- c(val,rep(0,nrow(wasGeneratedBy) + nrow(used)))
    val <- val + 1
    links <- data.frame(rbind(wasInformedBy,
                              wasGeneratedBy[,2:1],
                              used[,2:1]),
                        val)
    colnames(links) <- c("source","target","value")
    nodes <- data.frame(name = c(unlist(activity[,group]),
                            unlist(entity[,group])),
                        group = c(rownames(activity),rownames(entity)))
    rownames(nodes) <- 1:nrow(nodes)
    rownames(links) <- 1:nrow(links)
    list(nodes = nodes,links = links)
}

