# Makes data to be used for tests
fastDummies_example <- data.frame(numbers = 1:3,
                    gender  = c("male", "male", "female"),
                    animals = c("dog", "dog", "cat"),
                    dates   = as.Date(c("2012-01-01", "2011-12-31",
                                          "2012-01-01")))
fastDummies_example_tibble <- tibble::as.tibble(fastDummies_example)
fastDummies_example_DT <- data.table::as.data.table(fastDummies_example)


fastDummies_full <- data.frame(numbers = c(1:3, rep(NA, 5)),
                               gender = c("male",
                                          "male",
                                          "female",
                                          "female",
                                          "male",
                                          "female",
                                          "male",
                                          "female"),
                                animals = c("dog",
                                            "dog",
                                            "cat",
                                            "cat",
                                            "cat",
                                            "dog",
                                            "cat",
                                            "dog"),
                               dates = as.Date(c("2012-01-01",
                                                 "2011-12-31",
                                                 "2012-01-01",
                                                 "2011-12-31",
                                                 "2011-12-31",
                                                 "2011-12-31",
                                                 "2012-01-01",
                                                 "2012-01-01")))
fastDummies_full_tibble <- tibble::as.tibble(fastDummies_full)
fastDummies_full_DT <- data.table::as.data.table(fastDummies_full)

crime <- data.frame(city = c("SF", "SF", "NYC"),
                    year = c(1990, 2000, 1990),
                    crime = 1:3)
crime_tibble <- tibble::as.tibble(crime)
crime_DT <- data.table::as.data.table(crime)

crime_full <- data.frame(city = c("SF", "SF", "NYC", "NYC"),
                         year = c(1990, 2000, 1990, 2000),
                         crime = c(1:3, NA))
crime_full_tibble <- tibble::as.tibble(crime_full)
crime_full_DT <- data.table::as.data.table(crime_full)

no_dummies_needed <- data.frame(animals = c("lion",
                                            "lion",
                                            "tiger",
                                            "tiger"),
                                food    = c("bread",
                                            "cake",
                                            "bread",
                                            "cake"))
no_dummies_needed_tibble <- tibble::as.tibble(no_dummies_needed)
no_dummies_needed_DT <- data.table::as.data.table(no_dummies_needed)


devtools::use_data(crime, crime_DT, crime_tibble,
                   crime_full, crime_full_DT, crime_full_tibble,
                   fastDummies_example, fastDummies_example_DT,
                   fastDummies_example_tibble, fastDummies_full,
                   fastDummies_full_DT, fastDummies_full_tibble,
                   no_dummies_needed, no_dummies_needed_DT,
                   no_dummies_needed_tibble,
                   internal = TRUE)
