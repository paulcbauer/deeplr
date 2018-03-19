translate <- function(dataset = NULL,
                      column.name = NULL,
                      source.lang = "DE",
                      target.lang = "EN",
                      auth_key = NULL,
                      url = "https://api.deepl.com/v1/translate?text="
                      ) {


if(is.null(auth_key)){cat("You need an API key. See https://www.deepl.com/api-contact.html.")}else{

# INPUT: Character vector of length 1 ####
if(inherits(dataset,"character")==TRUE&length(dataset)==1){
    i <- dataset
    i <- stringr::str_replace(gsub("\\s+", "%20", stringr::str_trim(i)), "B", "b")
    response <- GET(paste(url,
                          i,
                          "&source_lang=", source.lang,
                          "&target_lang=", target.lang,
                          "&auth_key=", auth_key
                          , sep = ""))



    respcontent <- httr::content(response, as="text", encoding = "UTF-8")
    return(jsonlite::fromJSON(respcontent)$translations$text)
}



# INPUT: Character vector of length > 1 ####
if(inherits(dataset,"character")==TRUE&length(dataset)>1){
    responses <- NULL
    z <- 0
    for(i in dataset){
      svMisc::progress(z, max.value = length(dataset))
      z <- z+1
      i <- stringr::str_replace(gsub("\\s+", "%20", stringr::str_trim(i)), "B", "b")
      response.i <- GET(paste(url,
                              i,
                              "&source_lang=", source.lang,
                              "&target_lang=", target.lang,
                              "&auth_key=", auth_key
                              , sep = ""))
      respcontent.i <- httr::content(response.i, as="text", encoding = "UTF-8")
      result.i <- jsonlite::fromJSON(respcontent.i)$translations$text
      responses <- c(responses, result.i)
    }
    return(responses)

}



# INPUT: Dataframe with text in column ####
  if(inherits(dataset,"data.frame")==TRUE&!is.null(column.name)){

    dataset2 <- dataset %>% dplyr::pull(column.name) %>% as.character()

    responses <- NULL
    z <- 0
    for(i in dataset2){
      svMisc::progress(z, max.value = length(dataset2))
      z <- z+1
      i <- stringr::str_replace(gsub("\\s+", "%20", stringr::str_trim(i)), "B", "b")
      response.i <- GET(paste(url,
                              i,
                              "&source_lang=", source.lang,
                              "&target_lang=", target.lang,
                              "&auth_key=", auth_key
                              , sep = ""))
      respcontent.i <- httr::content(response.i, as="text", encoding = "UTF-8")
      result.i <- jsonlite::fromJSON(respcontent.i)$translations$text
      responses <- c(responses, result.i)
    }
    dataset <- cbind(dataset, translation = responses)
    return(dataset)
  }

  if(inherits(dataset,"data.frame")==TRUE&is.null(column.name)){cat("If input is a data.frame you have to specify a column name, e.g. translate(dataset = dat, column.name = 'text'.")}




}

} # End of function









