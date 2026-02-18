function Open_and_Run_Term_Command()
  -- Open a new horizontal split
  vim.cmd 'below split'
  -- Create a terminal buffer in the new window
  vim.cmd 'terminal'

  -- The terminal starts in Normal mode, so we need to switch to Terminal mode
  -- to send input, using 'a' for insert-after.
  vim.api.nvim_feedkeys('a', 't', false)

  -- Define the Enter key terminal code
  local enter = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  -- Send the command string followed by Enter to execute it
  vim.api.nvim_chan_send(vim.bo.channel, 'ls')
end
