# library(swirl)
# install_from_swirl("Getting and Cleaning Data")
# swirl()
#
library(dplyr) # check version packageVersion("dplyr").
path2csv = 2014-07-08.csv
mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
# always analyze what data you have got ...
dim(mydf)
# and preview the data
head(mydf)
# load data into a data frame table 
cran <- tbl_df(mydf).
# remove orig data frame -> rm("mydf")
# the main advantage of deplyr over usual data frame is printing 
rm("mydf")

# FUNDAMENTAL DATA MANIPULATION : select(), filter(), arrange(), mutate(), and summarize().
# now selcting specific attributes
select(cran, ip_id,package, country)

# find a sequence of columns .. all columns starting from r_arch .. ending with country
select(cran, r_arch:country)
# print in reverse order
select(cran, country:r_arch)

# specify columns not required
select(cran, -time) 
# first sequence , then -ve numbers -> -(5:20)
select(cran, -(X:size)) 
# Now that we selected reqd columns !
# How do we select subset of rows ?
filter(cran, package == "swirl")
# return all rows of cran corresponding to downloads from users in the US running R version 3.1.1.
filter(cran, r_version == "3.1.1", country == "US")
# all users in India , downloading versions < 3.0.2
filter(cran, r_version <= "3.0.2", country == "IN")

filter(cran, country == "US" | country == "IN")

filter(cran, size > 100500 AND r_os == "linux-gnu")

// add multiple criteria
filter(cran, size > 100500, r_os == "linux-gnu")
# return rows for which r_version not missing
is.na(c(3, 5, NA, 10))
> !is.na(c(3, 5, NA, 10))
[1]  TRUE  TRUE FALSE  TRUE

# filter out rows with a non_na version
filter(cran, !is.na(r_version))

# we want to order the rows of a dataset according to the values of a particular variable
cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id) , arrange(cran2, package, ip_id)
arrange(cran2, country, desc(r_version), ip_id)

cran3 <- select(cran, ip_id, package, size)

##  Now mutating the result
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)


## Oaao .. now collapse all the result into a single row
summarize(cran, avg_bytes = mean(size))
by_package <- group_by(cran, package)
summarize(by_package, mean(size))
# now summarize will return the mean value of size column for each package type
# 
# Compute four values, in the following order, from
# the grouped data:
#
# 1. count = n()
# 2. unique = n_distinct(ip_id)
# 3. countries = n_distinct(country)
# 4. avg_bytes = mean(size)
#
# A few thing to be careful of:
#
# 1. Separate arguments by commas
# 2. Make sure you have a closing parenthesis
# 3. Check your spelling!
# 4. Store the result in pack_sum (for 'package summary')
#
# You should also take a look at ?n and ?n_distinct, so
# that you really understand what is going on.

pack_sum <- summarize(by_package,
                      count = n(), # total rows for each pkg
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

# NOW the BIG FUN
# TOP 1% packages or BOTTOM 99% based on total downloads
quantile(pack_sum$count, probs = 0.99)
# answer is 679
top_counts <- filter(pack_sum, count > 679)
top_counts_sorted <- arrange(top_counts, desc(count))

# so we find most popular package
# Not surprisingly, ggplot2 leads the pack with 4602 downloads, followed by Rcpp, plyr, rJava
| Perhaps we're more interested in the number of *unique*
| downloads on this particular day. In other words, if a package
| is downloaded ten times in one day from the same computer, we
| may wish to count that as only one download. That's what the
| 'unique' column will tell us.
top_unique <- quantile(pack_sum$unique, probs = 0.99)
top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted)


#####

| Less readbale , but more optimal
result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(countries),
    avg_bytes
  )

print(result2)

### Chaining
cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb))

##### tidy the messy data 
gather(students, sex, count, -grade)

> students2
grade male_1 female_1 male_2 female_2
1     A      3        4      3        4
2     B      6        4      3        5
3     C      7        4      3        8

> res <- gather(students2, sex_class, count, -grade)
> res
grade sex_class count
1      A    male_1     3
2      B    male_1     6
3      C    male_1     7
4      D    male_1     4

separate(res, sex_class, c("sex", "class"))

| in another word , divide sex_class into sex and class columns.
students2 %>%
  gather(sex_class, count, -grade) %>%
  separate(sex_class, c("sex", "class")) %>%
  print

# more examples .. of messy data
> students3
name    test class1 class2 class3 class4 class5
1  Sally midterm      A   <NA>      B   <NA>   <NA>
  2  Sally   final      C   <NA>      C   <NA>   <NA>
  3   Jeff midterm   <NA>      D   <NA>      A   <NA>

  students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  print
  
  name    test  class grade
1  Sally midterm class1     A
2  Sally   final class1     C
9  Brian midterm class1     B

#
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  print
>> extract_numeric("class5") (convert class5 to 5) i.e.
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  mutate(class = extract_numeric(class)) %>%
  print

##### Normalization
> students4
id  name sex class midterm final
1  168 Brian   F     1       B     B
2  168 Brian   F     5       A     C

student_info <- students4 %>%
  select(id, name, sex) %>%
  unique %>%
  print

gradebook <- students4 %>%
  select(id, class, midterm, final) %>%
  print

#### Denormalization
> passed
name class final
1 Brian     1     B
2 Roger     2     A

> failed
name class final
1 Brian     5     C
2 Sally     1     C
3 Sally     3     C

>>> now ...
> passed <- passed %>% mutate(status = "passed")
bind_rows(passed, failed)
# http://research.collegeboard.org/programs/sat/data/cb-seniors-2013
score_range read_male read_fem read_total math_male math_fem
(chr)     (int)    (int)      (int)     (int)    (int)
1     700-800     40151    38898      79049     74461    46040
2     600-690    121950   126084     248034    162564   133954
3     500-590    227141   259553     486694    233141   257678

# Accomplish the following three goals:
#
# 1. select() all columns that do NOT contain the word "total",
# since if we have the male and female data, we can always
# recreate the total count in a separate column, if we want it.
# Hint: Use the contains() function, which you'll
# find detailed in 'Special functions' section of ?select.
#
# 2. gather() all columns EXCEPT score_range, using
# key = part_sex and value = count.
#
# 3. separate() part_sex into two separate variables (columns),
# called "part" and "sex", respectively. You may need to check
# the 'Examples' section of ?separate to remember how the 'into'
# argument should be phrased.
#
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  print

score_range  part   sex  count
(chr) (chr) (chr)  (int)
1      700-800  read  male  40151
2      600-690  read  male 121950
3      500-590  read  male 227141
4      400-490  read  male 242554


# Append two more function calls to accomplish the following:
#
# 1. Use group_by() (from dplyr) to group the data by part and
# sex, in that order.
#
# 2. Use mutate to add two new columns, whose values will be
# automatically computed group-by-group:
#
#   * total = sum(count)
#   * prop = count / total
#
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part, sex) %>%
  mutate(total = sum(count),
         prop = count / total
  ) %>% print

score_range  part   sex  count  total       prop
(chr) (chr) (chr)  (int)  (int)      (dbl)
1      700-800  read  male  40151 776092 0.05173485
2      600-690  read  male 121950 776092 0.15713343
3      500-590  read  male 227141 776092 0.29267278

#################


#####  Date and Time formatting
Sys.getlocale("LC_TIME") , this_day <- today() , month(this_day) , wday(this_day)
this_moment <- now()

my_date <- ymd("1989-05-17")
parsing "March 12, 1975" >> mdy("March 12, 1975")
> dmy(25081985)
[1] "1985-08-25 UTC"
> ymd("1920/1/2")
hms("03:22:14")
update(this_moment, hours = 8, minutes = 34, seconds = 55)

>> play with timezones
nyc <- now("America/New_York")
depart <- nyc + days(2)
depart <- update(depart, hours = 17, minutes = 34)
arrive <- depart + hours(15) + minutes(50)
>> Keep track of tz
arrive <- with_tz(arrive, "Asia/Hong_Kong")

## 