getwd()

# read the knitted HTML
html <- readLines("econ-8300-spring-2026-homework/homework-assignments/exam02.html", warn = FALSE)

# add scope="col" to any <th> that doesn't already have it
html <- gsub(
  "<th(?![^>]*scope=)",
  "<th scope=\"col\"",
  html,
  perl = TRUE
)

# write out a fixed version
writeLines(html, "econ-8300-spring-2026-homework/homework-assignments/exam02-scoped.html")
