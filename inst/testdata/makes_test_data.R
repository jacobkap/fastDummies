gender <- data.frame(gender = c("male", "male", "male", "female"))

animals <- data.frame(animals = c("cat", "cat", "dog", "bear", "bear",
                                  "cat", "dog"))

multi <- data.frame(numbers = rnorm(5),
                    gender = c("male", "male", "female", "female", "male"),
                    animals = c("dog", "dog", "dog", "cat", "bear"))

all_nums <- data.frame(num1 = rnorm(5),
                       num2 = 1:5,
                       num3 = rep(0, 5))

all_dates <- data.frame(dates = as.Date(c("2007-06-22", "2004-02-13",
                                          "2012-01-01", "2015-12-31",
                                          "2017-12-25")))

all_nums_or_dates <- data.frame(cbind(all_nums, all_dates))
