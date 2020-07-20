library(BCRA)
#* @filter cors
cors <- function(res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    plumber::forward()
}

#' @get /ohai
function(req){
    list("ohai - you made it")
}

#' Absolute Risk
#' @post /absolute.risk
#' @param id
#' @param age
#' @param biopsies
#' @param hyperplasia
#' @param menstruation
#' @param first_birth
#' @param relatives
#' @param race
#' @param Raw_Ind
#' @param Avg_white
#' @get /absolute.risk
#' all params need to be there or bad result
function(req, age=35, biopsies=1, hyperplasia=1, menstruation=1, first_birth=1, relatives=1, race=1, Raw_Ind=1, Avg_White=1) {
    cat(" age::", age, biopsies, hyperplasia, menstruation, first_birth, relatives, race, Raw_Ind, Avg_White)
    absolute.risk(data.frame(ID=1,
                             T1=as.numeric(age),
                             T2=as.numeric(age)+5,
                             N_Biop=as.integer(biopsies),
                             HypPlas=ifelse(as.integer(biopsies) == 0 |
                                              as.integer(biopsies) == 99,
                                            99,as.integer(hyperplasia)),
                             AgeMen=as.numeric(menstruation),
                             Age1st=as.numeric(first_birth),
                             N_Rels=as.numeric(relatives),
                             Race =as.integer(race)), Raw_Ind, Avg_White
    )
}
#* Relative Risk 
#* @param id
#* @param age
#* @param biopsies
#* @param hyperplasia
#* @param menstruation
#* @param first_birth
#* @param relatives
#* @param race
#* @param Raw_Ind
#* @get /relative.risk
function(id=0, age=35, biopsies=0, hyperplasia=0, menstruation=16, first_birth=22, relatives=0, race=1, Raw_Ind=1) {
    input_df <- data.frame(ID=id,
                             T1=as.numeric(age),
                             T2=as.numeric(age)+5,
                             N_Biop=as.integer(biopsies),
                             HypPlas=ifelse(as.integer(biopsies) == 0 |
                                              as.integer(biopsies) == 99,
                                            99,as.integer(hyperplasia)),
                             AgeMen=as.numeric(menstruation),
                             Age1st=as.numeric(first_birth),
                             N_Rels=as.numeric(relatives),
                             Race =as.integer(race))


    list(method=jsonlite::unbox("relative.risk"),data=jsonlite::unbox(relative.risk(input_df, Raw_Ind)))
}

#* Check Summary
#* @param data_name The template data name
#* @param Raw_Ind
#* @param Avg_white
#* @get /check.summary
function(id=0, age=35, biopsies=0, hyperplasia=0, menstruation=16, first_birth=22, relatives=0, race=1, Raw_Ind=1, Avg_White=0) {
    check.summary(data.frame(ID=id,
                             T1=as.numeric(age),
                             T2=as.numeric(age)+5,
                             N_Biop=as.integer(biopsies),
                             HypPlas=ifelse(as.integer(biopsies) == 0 |
                                              as.integer(biopsies) == 99,
                                            99,as.integer(hyperplasia)),
                             AgeMen=as.numeric(menstruation),
                             Age1st=as.numeric(first_birth),
                             N_Rels=as.numeric(relatives),
                             Race =as.integer(race)), Raw_Ind, Avg_White
    )
}

#* Risk Summary
#* @param data_name The template data name
#* @param Raw_Ind
#* @get /risk.summary
function(id=0, age=35, biopsies=0, hyperplasia=0, menstruation=16, first_birth=22, relatives=0, race=1, Raw_Ind=1) {
    #attach(file.path("..","data",data))
    risk.summary(data.frame(ID=id,
                            T1=as.numeric(age),
                            T2=as.numeric(age)+5,
                            N_Biop=as.integer(biopsies),
                            HypPlas=ifelse(as.integer(biopsies) == 0 |
                                             as.integer(biopsies) == 99,
                                           99,as.integer(hyperplasia)),
                            AgeMen=as.numeric(menstruation),
                            Age1st=as.numeric(first_birth),
                            N_Rels=as.numeric(relatives),
                            Race =as.integer(race)), Raw_Ind
    )
}


#* @get /version
#* @serializer unboxedJSON
function() {
    v<-read.csv("../version.txt", header = FALSE)    
    list(version=jsonlite::unbox(v[[1]]))
}
