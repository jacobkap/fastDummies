# Makes data to be used for tests
fastDummies_example <- data.frame(numbers = 1:3,
                    gender  = c("male", "male", "female"),
                    animals = c("dog", "dog", "cat"),
                    dates   = as.Date(c("2012-01-01", "2011-12-31",
                                          "2012-01-01")))


fastDummies_full <- data.frame(numbers = c(1:3, rep(NA, 5)),
                               gender = c("male", "male", "female",
                                          "female", "male", "female",
                                          "male", "female"),
                                animals = c("dog", "dog", "cat", "cat", "cat",
                                            "dog", "cat", "dog"),
                               dates = as.Date(c("2012-01-01", "2011-12-31",
                                                 "2012-01-01", "2011-12-31",
                                                 "2011-12-31", "2011-12-31",
                                                 "2012-01-01", "2012-01-01")))

crime <- data.frame(city = c("SF", "SF", "NYC"),
                    year = c(1990, 2000, 1990),
                    crime = 1:3)

crime_full <- data.frame(city = c("SF", "SF", "NYC", "NYC"),
                         year = c(1990, 2000, 1990, 2000),
                         crime = c(1:3, NA))

no_dummies_needed <- data.frame(animals = c("lion", "lion", "tiger", "tiger"),
                                food    = c("bread", "cake", "bread", "cake"))


