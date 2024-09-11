library(fun)
X11(type = 'Xlib') 

lights_out(
  width = 5,
  height = 5,
  steps = 3,
  cheat = FALSE,
  col.off = "black",
  col.on = "white",
  col.frame = "lightblue",
  seed = NULL
)

mine_sweeper(width = 10, height = 10, mines = 20, cheat = FALSE)
