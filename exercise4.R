# File name:    exercise4.R
# Author:       Felix Thoemmes             
# Date:         11/1/2022


# Load packages ----------------------------------------------------------------
library(dagitty)
library(ggdag)

#generate DAG ------------------------------------------------------------------
#dag 1


d1 <- dagitty("dag{
  u1
  m 
  x [exposure]
  y [outcome]
  x -> m
  x -> y
  m -> y
  u1 -> m
  u1 -> y
  m <-> y
}")

d2 <- dagitty("dag{
  u1
  u2
  m 
  x [exposure]
  y [outcome]
  x -> m
  x -> y
  m -> y
  u1 -> m
  u1 -> y
  x -> u2
  u2 -> m
  u2 -> y
}")



d3 <- dagitty("dag{
  u1
  u2
  m 
  x [exposure]
  y [outcome]
  x -> m
  x -> y
  m -> y
  u1 -> y
  u2 -> m
  u1 <-> u2
  x <-> u2
  x <-> u1
}")





