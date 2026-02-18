-- lua/options/filetypes.lua

-- C header files as C
vim.filetype.add {
  extension = {
    h = "c",
  },
}

-- Scheme files
vim.filetype.add {
  extension = {
    scheme = "scheme",
  },
}

-- Arduino files as C++
vim.filetype.add {
  extension = {
    ino = "cpp",
  },
}

vim.filetype.add {
  filename = {
    ["CMakeLists.txt"] = "cmake",
  },
  extension = {
    cmake = "cmake",
  },
}
