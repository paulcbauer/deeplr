<!-- README.md is generated from README.Rmd. Please edit that file -->
deeplr
======

<b>This repository is currently not regularly maintained. Please use the following package that is also officially published on CRAN and regularly maintained: See here https://github.com/zumbov2/deeplr and here https://cran.r-project.org/web/packages/deeplr/index.html. If you want to contribute please do so by creating pull-requests in this latter repository.</b>


The DeepL Translator made headlines for providing better translations than Google etc. `deeplr` is a quick & dirty coded package that contains functions - `translate_vec()` and `translate_df()` - that access the DeepL API. I was inspired by the [translateR package](https://github.com/ChristopherLucas/translateR) package.

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

You can feed `translate_vec()` with a single string, a vector of strings (class "character"). You can feed `translate_df()` with a dataframe that contains a column of class "character".

``` r
# Load the package
  library(deeplr)

# Translate a single string/character vector
  dat <- c("La seule facon de savoir ce qui se passe est de perturber le systeme.",
           "The whole problem with the world is that fools are always so certain of themselves")

# Without language detection and without adding set/detected source language.
  translate_vec(dataset = dat,
                source.lang = "EN",
                target.lang = "DE",
                auth_key = "enter you auth key here")

  dat <- c("A dog.",
           "Un chien.",
           "Un perro.",
           "Un cane.",
           "Een hond.")

# With language detection and with adding set/detected source language.
  translate_vec(dataset = dat,
                source.lang = "detect",
                target.lang = "DE",
                add.source.lang = TRUE,
                auth_key = "enter you auth key here")

  
  
  
  
# Translate a column in a dataframe
  dat <- data.frame(text = c("La seule facon de savoir ce qui se passe est de perturber
                              le systeme.",
                              "The whole problem with the world is that fools are always so
                              certain of themselves"))


# Without language detection and without adding set/detected source language.
  translate_df(dataset = dat,
               column.name = "text",
               source.lang = "EN",
               target.lang = "DE",
               auth_key = "enter you auth key here")

  dat <- data.frame(text = c("A dog.",
                             "Un chien.",
                             "Un perro.",
                             "Un cane.",
                             "Een hond."))

# With language detection and with adding set/detected source language.
  translate_df(dataset = dat,
               column.name = "text",
               source.lang = "detect",
               target.lang = "DE",
               add.source.lang = TRUE,
               auth_key = "enter you auth key here")
  # well...
```

Next steps
----------

-   Increase efficiency of code
-   Add option to output multiple languages
-   Test robustness.. encoding issues etc.

License
-------

License: CC BY-NC-SA 4.0
