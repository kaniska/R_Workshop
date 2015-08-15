num_helper <- function(state_subset, col_num, num) {
  # get "attack", "failure" and "pneumonia" vector
  outcome_arr <- as.numeric(state_subset[, col_num])
  len <- dim(state_subset[!is.na(outcome_arr), ])[1]
  if (num == "best") {
    rank <- rank_helper(state_subset, outcome_arr, 1)
  } else if (num == "worst") {
    rank <- rank_helper(state_subset, outcome_arr, len)
  } else if (num > len) {
    rank <- NA
  } else {
    rank <- rank_helper(state_subset, outcome_arr, num)
  }
  result <- rank
  return(result)
}