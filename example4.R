# File name:    example4.R
# Author:       Felix Thoemmes             
# Date:         11/1/2022


# Load packages ----------------------------------------------------------------
library(dagitty)
library(ggdag)

#generate DAG ------------------------------------------------------------------


d1 <- dagitty("dag{
  w2
  w3
  m 
  x [exposure]
  y [outcome]
  w2 -> m
  w2 -> x
  w2 <-> w3
  w3 -> x
  w3 -> y
  m -> y
  x -> m
  x -> y
}")

#descendants
descendants(d1,"x")

#for x to y (total effect)
adjustmentSets(d1, type = "all")

#set C1 for M -> Y, while holding X constant
adjustmentSets(d1,exposure = "m", outcome = "y", type = "all") -> setc1

isAdjustmentSet(d1, exposure = "m", outcome = "y", Z = c(setc1[[1]], "x"))
isAdjustmentSet(d1, exposure = "m", outcome = "y", Z = c(setc1[[2]], "x"))
isAdjustmentSet(d1, exposure = "m", outcome = "y", Z = c(setc1[[3]], "x"))

#confirming that it does not contain descendants of X
intersect(setc1[[1]], descendants(d1,"x"))
intersect(setc1[[2]], descendants(d1,"x"))
intersect(setc1[[3]], descendants(d1,"x"))

#set C2 for X -> M
adjustmentSets(d1,exposure = "x", outcome = "m", type = "all") -> setc2

#check that union C1 and C2 is adjustment set for X to M
union(setc1[[1]], setc2[[1]]) -> union1_1
union1_1
union(setc1[[2]], setc2[[1]]) -> union1_2
union1_2
union(setc1[[3]], setc2[[1]]) -> union1_3
union1_3

#all unions the same except union1
isAdjustmentSet(d1, exposure = "x", outcome = "y", Z = union1_1)
isAdjustmentSet(d1, exposure = "x", outcome = "y", Z = union1_2)

#set C3 for x,m to y
adjustmentSets(d1, exposure = c("x","m"), outcome = "y", type = "all") -> setc3

union(setc1[[1]], setc3[[1]]) -> union2_1
union(setc1[[2]], setc3[[1]]) -> union2_2
union(setc1[[3]], setc3[[1]]) -> union2_3
union(setc1[[1]], setc3[[2]]) -> union2_4
union(setc1[[2]], setc3[[2]]) -> union2_5
union(setc1[[3]], setc3[[2]]) -> union2_6


#all unions the same except union2
isAdjustmentSet(d1, exposure = "x", outcome = "y", Z = union2_1)
isAdjustmentSet(d1, exposure = "x", outcome = "y", Z = union2_2)

#final adjustment set for M-Y
union1_1
union1_2

#final adjustment set for X,M -Y
union(union1_1, union2_1)
union(union1_1, union2_2)
union(union1_2, union2_1)
union(union1_2, union2_2)

