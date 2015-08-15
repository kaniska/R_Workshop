rank_helper <- function(state_subset, outcome_arr, num) {
  result <- state_subset[, 2][order(outcome_arr, state_subset[, 2])[num]]
  return(result)
}