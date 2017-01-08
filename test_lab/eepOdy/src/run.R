## Import from sh
args <- tail(as.character(commandArgs(trailingOnly=TRUE)))
script <- tail(args,2)[1]
ddgdir <- script
ddgdir <- tail(strsplit(ddgdir,'/')[[1]],1)
ddgdir <- sub('.R','',ddgdir)
ddgdir <- paste(ddgdir,tail(args,1),sep='_')

## Check package space
if (!('devtools' %in% installed.packages()[,1])){
    install.packages('devtools')
}

if (!('RDataTracker' %in% installed.packages()[,1])){
    install_github('tfjmp/RDataTracker',ref='development')
}

sapply(c('devtools','RDataTracker'),require,character.only=TRUE,quietly=TRUE)

ddg.run(script,ddgdir=ddgdir)
