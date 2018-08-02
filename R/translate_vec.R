#' Translates a character vector.
#'
#' @return A character vector. If source.lang = "detect" also the detected languages.
#'
#' @param dataset A character vector.
#' @param source.lang Source language. Either "detect" or one of "EN", "FR", etc.
#' @param target.lang Target language. One of "EN", "FR", etc.
#' @param auth_key Your API key.
#' @param url Url to DeepL API.
#'
#' @examples
#' \dontrun{
#' dat <- c("La seule facon de savoir ce qui se passe est de perturber le systeme.",
#'          "The whole problem with the world is that fools are always so certain of themselves"))
#'
#'  translate_vec(dataset = dat,
#'               source.lang = "EN",
#'               target.lang = "DE",
#'               auth_key = "enter you auth key here")
#'
#' dat <- c("A dog.",
#'          "Un chien.",
#'          "Un perro.",
#'          "Un cane.",
#'          "Een hond.")
#'
#'  translate_vec(dataset = dat,
#'               source.lang = "detect",
#'               target.lang = "DE",
#'               auth_key = "enter you auth key here")
#' }


translate_vec <- function(dataset = NULL,
                      source.lang = "DE",
                      target.lang = "EN",
                      auth_key = NULL,
                      url = "https://api.deepl.com/v1/translate?text="
                      ) {



if(is.null(auth_key)){cat("You need an API key. See https://www.deepl.com/api-contact.html.")}else{


  if(inherits(dataset,"character")==TRUE&length(dataset)>1){
    responses <- NULL
    languages <- NULL
    z <- 0
    for(i in dataset){
      svMisc::progress(z, max.value = length(dataset))
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
      result.i <- jsonlite::fromJSON(respcontent.i)$translations$text
      responses <- c(responses, result.i)


    # Source language: "detect" vs. "X"
      if(source.lang == "detect"){
        source.lang.i <- jsonlite::fromJSON(respcontent.i)$translations$detected_source_language
      }else{
        source.lang.i <- jsonlite::fromJSON(respcontent.i)$translations$detected_source_language
      }
      languages <- c(languages, source.lang.i)



     }

# OUPUT

    if(source.lang == "detect"){
      return(cbind(responses, languages))
    }else{
      return(responses)
    }




  }else{
    cat("The input is not a character vector of length > 1.")
  }





} # API KEY

} # End of function









