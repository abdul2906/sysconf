local function distro_traits(name)
  local icons = {
    [ "unknown" ] = {
      icon = "",
      color = "#f3be25",
    },
    [ "debian" ] = {
      icon = "",
      color = "#d70a53",
    },
    [ "gentoo" ] = {
      icon = "",
      color = "#54487A",
    },
    [ "nixos" ] = {
      icon = "",
      color = "#5277C3",
    },
    [ "\"opensuse-tumbleweed\"" ] = {
      icon = "",
      color = "#73ba25",
    },
  }

  if os.getenv("CONTAINER_ID") ~= nil then
    icons["distrobox"] = {
      icon = "[󰏗 " .. os.getenv("CONTAINER_ID") .. "]",
      color = "#917d62",
    }
  end

  local icon = icons[name]
  if icon == nil then
    icon = icons["unknown"]
  end

  return icon
end

return function()
  if os.getenv("CONTAINER_ID") ~= nil then
    return {
      name = "distrobox",
      traits = distro_traits("distrobox"),
    }
  end

  local release_file = io.open("/etc/os-release", "rb")
  if release_file == nil then
    return {
      name = "unknown",
      traits = distro_traits("unknown"),
    }
  end

  local content = vim.split(release_file:read("*a"), "\n")
  local distro_id = nil
  for _, line in ipairs(content) do
    if string.sub(line, 0, 3) == "ID=" then
      distro_id = string.sub(line, 4, -1)
      goto distro_id_found
    end
  end
  ::distro_id_found::

  release_file:close()

  return {
    name = distro_id,
    traits = distro_traits(distro_id)
  }
end

