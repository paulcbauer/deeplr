#' Translates a column in a dataframe.
#'
#' @return Dataframe with original columns, translated column and column indicated detected or set source language.
#'
#' @param dataset Dataframe with column of class character.
#' @param column.name Name of column that should be translated.
#' @param source.lang Source language. Either "detect" or one of "EN", "FR", etc.
#' @param target.lang Target language. One of "EN", "FR", etc.
#' @param auth_key Your API key.
#' @param url Url to DeepL API.
#'
#' @examples
#' \dontrun{
#' dat <- data.frame(text = c("La seule facon de savoir ce qui se passe est de perturber le systeme.",
#'                            "The whole problem with the world is that fools are always so certain of themselves"))
#'
#'  translate_df(dataset = dat,
#'               column.name = "text",
#'               source.lang = "EN",
#'               target.lang = "DE",
#'               auth_key = "enter you auth key here")
#'
#' dat <- data.frame(text = c("A dog.",
#'                            "Un chien.",
#'                            "Un perro.",
#'                            "Un cane.",
#'                            "Een hond."))
#'
#'  translate_df(dataset = dat,
#'               column.name = "text",
#'               source.lang = "detect",
#'               target.lang = "DE",
#'               auth_key = "enter you auth key here")
#' }


translate_df <- function(dataset = NULL,
                      column.name = NULL,
                      source.lang = "DE",
                      target.lang = "EN",
                      auth_key = NULL,
                      url = "https://api.deepl.com/v1/translate?text="
                      ) {



if(is.null(auth_key)){cat("You need an API key. See https://www.deepl.com/api-contact.html.")}else{

# INPUT: Dataframe with text in column ####
  if(inherits(dataset,"data.frame")==TRUE&!is.null(column.name)){

    dataset2 <- dataset %>% dplyr::pull(column.name) %>% as.character()

    responses <- NULL
    languages <- NULL
    z <- 0



    for(i in dataset2){
      svMisc::progress(z, max.value = length(dataset2))
      z <- z+1
      i <- stringr::str_replace(gsub("\\s+", "%20", stringr::str_trim(i)), "B", "b")

    # Source language: "detect" vs. "X"
      if(source.lang=="detect"){


        response.i <- httr::GET(paste(url,
                                i,
                                "&target_lang=", target.lang,
                                "&auth_key=", auth_key
                                , sep = ""))
      }else{
        response.i <- httr::GET(paste(url,
                                      i,
                                      "&source_lang=", source.lang,
                                      "&target_lang=", target.lang,
                                      "&auth_key=", auth_key
                                      , sep = ""))
      }


      respcontent.i <- httr::content(response.i, as="text", encoding = "UTF-8")
      #print(respcontent.i)
      result.i <- jsonlite::fromJSON(respcontent.i)$translations$text

    # Source language: "detect" vs. "X"
      if(source.lang == "detect"){
      source.lang.i <- jsonlite::fromJSON(respcontent.i)$translations$detected_source_language
      }else{
      source.lang.i <- jsonlite::fromJSON(respcontent.i)$translations$detected_source_language
      }

      #print(result.i)
      responses <- c(responses, result.i)
      #print(responses)
      languages <- c(languages, source.lang.i)
    }
    column.name.new <- paste0(column.name, "_", target.lang)
    dataset <- dplyr::bind_cols(dataset, newtranslation = responses, source_lang = languages)
    names(dataset)[names(dataset)=="newtranslation"] <- column.name.new
    return(dataset)
  }else{
    cat("The input is not of class() dataframe or you forgot to specify the name of the column that shall be translated.")
  }



} # API KEY

} # End of function









