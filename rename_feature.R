rename_feature <- function(s = character()) {
  x <- unlist(strsplit(s,split = " "))[2]
  sub("\\()","",x)
}