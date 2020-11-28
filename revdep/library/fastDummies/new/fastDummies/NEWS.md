# fastDummies 1.6.3

* Fix bug where inputting a vector or a one column data.frame returned an issue. Now
  will convert the vector to a data.frame and return that. Will name each column ".data_". Closes #23 by @Garyf20.
* Fix bug where `remove_most_frequent_dummy` wasn't working right when there was a 
  tie for which value was the most frequent. Closes #22 by eden70.
  

# fastDummies 1.6.2

* Dummy columns are now returned in alphabetical order including numeric order (e.g. photos_2 is before photos_11).

# fastDummies 1.6.1

* Bug fixes.
* Dummy columns are now returned in alphabetical order. 

# fastDummies 1.6.0

* Adds the parameter `remove_selected_columns` to `dummy_columns()`. If TRUE (not default),
  removes the columns which are used to create the dummy columns.

# fastDummies 1.5.0

* Removes `sort_columns` parameter. Now by default will order by level if the variable is a 
  factor type.
* Fix bug where `split` parameter didn't work properly. 
* If value is NA, sets to NA in dummy column rather than value of 0. Closes #18 by @DLustenBerger.

# fastDummies 1.4.1

* Fix bug when column is factor type when using `split` parameter. 
  Thanks to Matthew Sigal for submitting issue on GitHub. 

# fastDummies 1.4.0 

* Adds option to ignore NA values in dummy_cols (doesn't make a variable_NA) 
  column is selected. Thanks to juribep5 for the GitHub suggestion.
* Adds `split` parameter in dummy_cols to handle if a row has multiple categories.
  Thanks to Matthew Sigal and Andrew Fernandes for the GitHub suggestion. 

# fastDummies 1.3.0

* Adds option to sort dummy columns following the order of the original factor 
  variable. Thanks to Patrick Baylis for the pull request with the code
  for this feature!
 
# fastDummies 1.2.0

* Adds option to exclude the most frequently observed category rather than the first
  category as is default. Thanks to GitHub user S-UP for the suggestion!

# fastDummies 1.1.0

* Thanks to GitHub user yu45020 dummy_cols() is now about >20% faster
  and much more memory efficient.

* Both dummy_cols() and dummy_rows() now return the same data type inputted
  e.g. data.frame input returns data.frame, tibble returns tibble.

* Fix documentation that incorrectly said default value for new dummy rows
is 0. It is in fact a value of NA.

# fastDummies 1.0.0

* Reduces number of parameter that were in previous version.

* Significant speed increases for both dummy_cols() and dummy_rows() functions.

* dummy_cols() now accepts numeric columns.



