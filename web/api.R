library(BCRA)
#* @filter cors
cors <- function(res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    plumber::forward()
}

#' @get /ohai
function(req){
    list("ohai - version 1.0.5 with proj_age default at 90")
}

#' Absolute Risk
#' @post /absolute.risk
#' @get /absolute.risk
#' @param id
#' @param age
#' @param proj_age
#' @param biopsies
#' @param hyperplasia
#' @param menstruation
#' @param first_birth
#' @param relatives
#' @param race
#' @param Raw_Ind
#' @param Avg_white

function(req, age=39, proj_age=90,  biopsies=1, hyperplasia=1, menstruation=1, first_birth=1, relatives=1, race=1, Raw_Ind=1, Avg_White=0) {
    cat(" age::", age, biopsies, hyperplasia, menstruation, first_birth, relatives, race, Raw_Ind, Avg_White)
    absolute.risk(data.frame(ID=1,
                             T1=as.numeric(age),
                             T2=as.numeric(proj_age),
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
#* @get /relative.risk
#* @post /relative.risk
#* @param id
#* @param age
#* @param proj_age
#* @param biopsies
#* @param hyperplasia
#* @param menstruation
#* @param first_birth
#* @param relatives
#* @param race
#* @param Raw_Ind

function(id=0, age=35, proj_age=90, biopsies=0, hyperplasia=0, menstruation=16, first_birth=22, relatives=0, race=1, Raw_Ind=1) {
    input_df <- data.frame(ID=id,
                             T1=as.numeric(age),
                             T2=as.numeric(proj_age),
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
#* @get /check.summary
#* @post /check.summary
#' @param id
#' @param age
#' @param proj_age
#' @param biopsies
#' @param hyperplasia
#' @param menstruation
#' @param first_birth
#' @param relatives
#' @param race
#' @param Raw_Ind
#' @param Avg_white
#* @param Raw_Ind
#* @param Avg_white

function(id=0, age=35, proj_age=90, biopsies=0, hyperplasia=0, menstruation=16, first_birth=22, relatives=0, race=1, Raw_Ind=1, Avg_White=0) {
    check.summary(data.frame(ID=id,
                             T1=as.numeric(age),
                             T2=as.numeric(proj_age),
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
#* @get /risk.summary
#* @post /risk.summary
#' @param id
#' @param age
#' @param proj_age
#' @param biopsies
#' @param hyperplasia
#' @param menstruation
#' @param first_birth
#' @param relatives
#' @param race
#' @param Raw_Ind
#' @param Avg_white
#* @param Raw_Ind

function(id=0, age=35, proj_age=90, biopsies=0, hyperplasia=0, menstruation=16, first_birth=22, relatives=0, race=1, Raw_Ind=1) {
    risk.summary(data.frame(ID=id,
                            T1=as.numeric(age),
                            T2=as.numeric(proj_age),
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
