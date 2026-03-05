local win_agent_count = 0

function Split_Mode_Action(split_mode)
  -- Open window based on split mode
  if split_mode == 0 then
    -- Current buffer (do nothing, terminal will replace current buffer)
  elseif split_mode == 1 then
    vim.cmd 'vsplit'
  elseif split_mode == 2 then
    vim.cmd 'split'
  elseif split_mode == 3 then
    vim.cmd 'tabnew'
  end
end

function Create_New_Agent(split_mode)
  win_agent_count = win_agent_count + 1

  -- Default to new tab if no mode specified
  split_mode = split_mode or 3

  Split_Mode_Action(split_mode)

  -- Create a terminal buffer in the new window
  vim.cmd 'terminal'
  --vim.cmd("terminal sudo -E bash -c 'cd /var/ossec && exec bash'")

  vim.cmd('f agent' .. win_agent_count)
  -- vim.cmd 'f manager'
  -- The terminal starts in Normal mode, so we need to switch to Terminal mode
  -- to send input, using 'a' for insert-after.
  vim.api.nvim_feedkeys('a', 't', false)

  -- Define the Enter key terminal code
  local enter = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  -- Send the command string followed by Enter to execute it
  vim.api.nvim_chan_send(vim.bo.channel, 'sudo -S -E -s\n')
  vim.api.nvim_chan_send(vim.bo.channel, '2228\n')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'cd /var/ossec/')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
end
vim.api.nvim_create_user_command('Agt', function(opts)
  local split_mode = tonumber(opts.args) or 3
  Create_New_Agent(split_mode)
end, { nargs = '?', desc = 'Open a terminal and run a command (0=current, 1=vsplit, 2=split, 3=tab)' })

function Open_Git()
  -- Open a new horizontal split
  vim.cmd 'tabnew'
  -- Create a terminal buffer in the new window
  vim.cmd 'terminal'

  vim.cmd 'f git'
  -- The terminal starts in Normal mode, so we need to switch to Terminal mode
  -- to send input, using 'a' for insert-after.
  vim.api.nvim_feedkeys('a', 't', false)

  -- Define the Enter key terminal code
  local enter = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  -- Send the command string followed by Enter to execute it
  vim.api.nvim_chan_send(vim.bo.channel, 'cd ~/wazuh/')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'git status')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
end

vim.api.nvim_create_user_command('Gt', function()
  Open_Git()
end, { nargs = 0, desc = 'Open git on wazuh' })

function Create_New_Manager()
  -- Open a new horizontal split
  vim.cmd 'tabnew'
  -- Create a terminal buffer in the new window
  vim.cmd 'terminal'

  vim.cmd 'f manager'
  -- The terminal starts in Normal mode, so we need to switch to Terminal mode
  -- to send input, using 'a' for insert-after.
  vim.api.nvim_feedkeys('a', 't', false)

  -- Define the Enter key terminal code
  local enter = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  -- Send the command string followed by Enter to execute it
  vim.api.nvim_chan_send(vim.bo.channel, 'cd ~/basic_vagrant/')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'vagrant up ubuntumanager')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'vagrant ssh ubuntumanager')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'sudo -E -s')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'cd /var/wazuh-manager')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
end

vim.api.nvim_create_user_command('Mgr', function()
  Create_New_Manager()
end, { nargs = 0, desc = 'Open a terminal and run a command' })

local agent_count = 0
function Create_New_Winagent(split_mode)
  agent_count = agent_count + 1

  Split_Mode_Action(split_mode)

  -- Create a terminal buffer in the new window
  vim.cmd 'terminal'

  vim.cmd('f windows' .. agent_count)
  -- vim.cmd 'f manager'
  -- The terminal starts in Normal mode, so we need to switch to Terminal mode
  -- to send input, using 'a' for insert-after.
  vim.api.nvim_feedkeys('a', 't', false)

  -- Define the Enter key terminal code
  local enter = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  -- Send the command string followed by Enter to execute it
  vim.api.nvim_chan_send(vim.bo.channel, 'cd ~/basic_vagrant/')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'vagrant up win2022')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'vagrant ssh win2022')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'powershell')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  -- vim.api.nvim_chan_send(vim.bo.channel, 'cd c:\\Program Files(x86)\\ossec-agent')
  -- vim.api.nvim_chan_send(vim.bo.channel, enter)
end

vim.api.nvim_create_user_command('Win', function(opts)
  local split_mode = tonumber(opts.args) or 3
  Create_New_Winagent(split_mode)
end, { nargs = '?', desc = 'Open a terminal and run a command (0=current, 1=vsplit, 2=split, 3=tab)' })

function Create_New_Claude(split_mode)
  -- Default to new tab if no mode specified
  split_mode = split_mode or 3

  Split_Mode_Action(split_mode)

  -- Create a terminal buffer in the new window
  vim.cmd 'terminal'

  vim.cmd 'f claude'
  -- vim.cmd 'f manager'
  -- The terminal starts in Normal mode, so we need to switch to Terminal mode
  -- to send input, using 'a' for insert-after.
  vim.api.nvim_feedkeys('a', 't', false)

  -- Define the Enter key terminal code
  local enter = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  -- Send the command string followed by Enter to execute it
  vim.api.nvim_chan_send(vim.bo.channel, 'sudo -S -E -s\n')
  vim.api.nvim_chan_send(vim.bo.channel, '2228\n')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
  vim.api.nvim_chan_send(vim.bo.channel, 'claude')
  vim.api.nvim_chan_send(vim.bo.channel, enter)
end

vim.api.nvim_create_user_command('Claude', function(opts)
  local split_mode = tonumber(opts.args) or 3
  Create_New_Claude(split_mode)
end, { nargs = '?', desc = 'Open a claude (0=current, 1=vsplit, 2=split, 3=tab)' })
