<!-- README.md is generated from README.Rmd. Please edit that file -->
deeplr
======

The DeepL Translator made headlines for providing better translations than Google etc. `deeplr` is a quick & dirty coded package that contains a singular function - `translate()` - that accesses the DeepL API. I was inspired by the [translateR package](https://github.com/ChristopherLucas/translateR) package.

To access the API you need to get your own API key from deeplr: <https://www.deepl.com/api-contact.html>.

Beware of the API request limits. See <https://www.deepl.com/api-reference.html>.

-   "The request size should not exceed 30kbytes. The maximum number of texts to be translated within one request should not exceed 50."
-   "Please ensure your client does not exceed the limits as specified in the quota documentation delivered to you."

Installation: How do I get the package?
---------------------------------------

``` r
# Development version
# install.packages("devtools")
devtools::install_github("paulcbauer/deeplr")
```

Example: How do I use the package?
----------------------------------

You can feed `translate()` with a single string, a vector of strings (class "character") or a dataframe that contains a column of class "character".

``` r
# Load the package
  library(deeplr)

# Translate a single string
  dat <- "Essentially, all models are wrong, but some are useful"
  translate(dataset = dat,
            source.lang = "EN",
            target.lang = "DE",
            auth_key = "enter your key here")

# Translate a character vector
  dat <- c("The only way to find out what happens is to disturb the system",
           "The whole problem with the world is that fools are always so certain of themselves")
  translate(dataset = dat,
            source.lang = "EN",
            target.lang = "DE",
            auth_key = "enter your key here")

# Translate a column in a dataframe
  dat <- data.frame(text = c("The only way to find out what happens is to disturb the system",
           "The whole problem with the world is that fools are always so certain of themselves"))
  translate(dataset = dat,
            source.lang = "EN",
            target.lang = "DE",
            column.name = "text",
            auth_key = "enter your key here")


  swiss$country <- rownames(swiss)
  translate(dataset = swiss, column.name = "country", source.lang = "FR", target.lang = "EN")
  # well...
```

Next steps
----------

-   Increase efficiency of code
-   Add option to output multiple languages
-   Test robustness.. encoding issues etc.
