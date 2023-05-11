vim.cmd[[
if exists("g:neovide") " neovide settings :o
	" set guifont=Fira\ Code\ Nerd\ Font:h18
	set guifont=SauceCodePro\ Nerd\ Font:h17
	let g:neovide_scale_factor = 0.7
	let g:neovide_transparency = 0.95
	let g:neovide_hide_mouse_when_typing = v:true
endif
]]

require('user.reload') -- allows you to reload your config
local _, plenary_status = pcall(require, "plenary")
if not plenary_status then return nil end
require('user')

--[[
Capitalized, short (50 chars or less) summary

More detailed explanatory text, if necessary.  Wrap it to about 72
characters or so.  In some contexts, the first line is treated as the
subject of an email and the rest of the text as the body.  The blank
line separating the summary from the body is critical (unless you omit
the body entirely); tools like rebase can get confused if you run the
two together.

Write your commit message in the imperative: "Fix bug" and not "Fixed bug"
 or "Fixes bug."  This convention matches up with commit messages generated
by commands like git merge and git revert.

Further paragraphs come after blank lines.
- Bullet points are okay, too
- Typically a hyphen or asterisk is used for the bullet, followed by a single space, with blank lines in between, but conventions vary here
- Use a hanging indent

https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
--]]
