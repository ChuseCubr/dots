#! nvim --clean --headless -l

local tmp = vim.fn.stdpath("state") .. "/last_dir_path"
if vim.fn.filereadable(tmp) == 1 then
	local dir = vim.fn.readfile(tmp)[1]
	vim.fn.delete(tmp)
	if vim.fn.isdirectory(dir) == 1 then
		os.execute("echo " .. dir)
	end
end
