\name{translate}
\alias{translate}
\title{translate using DeepL}
\usage{
translate(dataset = NULL,
          column.name = NULL,
          source.lang = "EN",
          target.lang = "DE",
          url = "https://www.deepl.com/jsonrpc")
}
\arguments{

  \item{dataset}{A character vector or dataframe (with a column containing the text to be translated).}
  \item{column.name}{If a dataframe is passed to "dataset", the name of the column containing the text
must be passed to "column.name".}
  \item{source.lang}{The language code that corresponds with the language in which the source text
is written. One of "EN", "DE", "FR", "ES", "IT", "NL", "PL". Default is "EN".}
  \item{target.lang}{The language code that corresponds with the language into which the source
text is to be translated. One of "EN", "DE", "FR", "ES", "IT", "NL", "PL". Default is "DE".}
  \item{url}{Url to the inofficial DeepL API.}
}
\description{
Translates relying on https://www.deepl.com/translator.
}
\examples{

# Load the package
  library(deeplr)

# Translate a single string
  dat <- "Essentially, all models are wrong, but some are useful"
  translate(dataset = dat)

# Translate a character vector
  dat <- c("The only way to find out what happens is to disturb the system",
           "The whole problem with the world is that fools are always so certain of themselves")
  translate(dataset = dat)

# Translate a column in a dataframe
  dat <- data.frame(text = c("The only way to find out what happens is to disturb the system",
           "The whole problem with the world is that fools are always so certain of themselves"))
  translate(dataset = dat, column.name = "text", source.lang = "EN", target.lang = "ES")


  swiss$country <- rownames(swiss)
  translate(dataset = swiss, column.name = "country", source.lang = "FR", target.lang = "EN")
  # well...

}


