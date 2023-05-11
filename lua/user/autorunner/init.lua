--[[
Plugin for autorunning commands (Run, compile, make, Test all, Test one, custom)
fzf cumstom or Test one <3
at first : keymaps = * for no commands setted up (which key) ex :
(after "<leader>r" for Run)
a -> Add/change command
s -> Show basics commands
p -> print run command
S -> Show commands (fzf)
r -> *Run
f -> *RunFile
c -> *Compile
t -> *Test All
n -> *Test one (fzf + Telescope??)
h -> *Custom (fzf + Telescope)
If I press 'r' for example, it is asking me the commands to record.
Then : new keymap / interface :
r -> Run (bc a command has been setted up)


how to store them now for each project? Harpoon model?
Other commands? :
# RunCode
# RunFile
# RunFile Tab?
# RunProject
# RunClose?
# CRFiletype?
# CRProjects?

# Run Selected (selection mod 'v' or 'x'?)
]]

require("user.autorunner.run")
