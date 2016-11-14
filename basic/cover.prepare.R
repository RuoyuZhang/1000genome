
library('optparse')

option_list <- list(
    make_option(c("--raw_file_list"),type="character",help="raw file",default = "f:/Cornell/experiment/1000genome/1000genome/basic/test.list" ),
    
    make_option(c("--out_file"), type="character", help="output file", default="f:/Cornell/experiment/1000genome/1000genome/basic/test.out.txt")
    
)
opt <- parse_args(OptionParser(option_list=option_list))

#file = "f:/Cornell/experiment/1000genome/1000genome/basic/HG00096.raw"

cal_one_file = function(file){
    data=read.table(file,fill = T,stringsAsFactors = F)
    data = data[,c(2,4)]
    
    cover = c()
    for (i in 1:16569){
        if (i %in% data[,1]){
            cover = c(cover,data[which(data[,1]==i),2])
        }else{
            cover = c(cover,0)
        }
    }
    cover
}

files = read.table(opt$raw_file_list,stringsAsFactors = F)[,1]

cover.mat = NULL
file.names = c()
for (file in files){
    file.name = basename(file)
    file.name = sub('.raw','',file.name)
    file.names = c(file.names,file.name)
    
    line = cal_one_file(file)
    cover.mat = cbind(cover.mat,line)
}

colnames(cover.mat) = file.names
write.table(cover.mat,file=opt$out_file,quote = F,row.names = F)
