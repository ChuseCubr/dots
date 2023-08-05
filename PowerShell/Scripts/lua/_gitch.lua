#! nvim -l

local function args_parse(args)
	local command
	local paths = {}
	for k, v in ipairs(args) do
		if k == 4 then
			command = v
		elseif k > 4 then
			table.insert(paths, v)
		end
	end
	return command, paths
end

local function root_find(path)
	for dir in vim.fs.parents(path) do
		if vim.fn.isdirectory(dir .. "/.gitch") == 1 then
			return dir
		end
	end
end

local function dotfiles_init(path)
	local full_path = vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
	vim.fn.mkdir(full_path .. "/.gitch", "p")
end

local function command_init(paths)
	if vim.fn.empty(paths) == 1 then
		dotfiles_init(vim.fn.getcwd())
	end
end

local function main()
	local command, paths = args_parse(vim.fs.normalize(vim.fn.getcwd()))
	if command == "init" then
		command_init(paths)
	end

	local root = root_find(vim.fs.normalize(vim.fn.getcwd()))
	if root == nil then
		vim.print("Not a gitch repository")
		os.exit(1)
	end
end

-- main()
