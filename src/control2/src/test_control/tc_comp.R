x <- './test_control_ano_T/ct_1_10_ddg/ddg.txt'

get.ddginfo <- function(x){
    info <- readLines(x)
    start.time <- tail(strsplit(info[grep('ProcessFileTimestamp',info)],'\\"')[[1]])
    
}
