
# Makes data for dummy_rows tests -----------------------------------------

rows_no_dummies <- data.frame(animals = c("lion", "lion", "tiger", "bear"),
                         food    = c("bread", "cake", "bread", "cupcake"))

small_rows <- data.frame(animals = c("lion", "lion", "tiger", "bear"),
                         food    = c("bread", "cake", "bread", "cupcake"),
                         numbers = 1:4)

rows_dates <- data.frame(animals = c("lion", "lion", "tiger", "bear"),
                         food    = c("bread", "cake", "bread", "cupcake"),
                         dates   = as.Date(c("2007-06-22", "2007-06-22",
                                             "2012-01-01", "2012-01-01")),
                         numbers = 1:4)

all_numbers <- data.frame(numbers = 1:4)

all_numbers_vector <- 1:4

all_characters_vector <-  c("lion", "lion", "tiger", "bear")

all_date_vector <- as.Date(c("2007-06-22", "2004-02-13",
                             "2012-01-01", "2015-12-31"))

no_dummies_needed <- data.frame(animals = c("lion", "lion", "tiger", "tiger"),
                                food    = c("bread", "cake", "bread", "cake"))
