return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 12,
  nextobjectid = 6,
  backgroundcolor = { 128, 128, 128 },
  properties = {
    ["map_center"] = { id = 2 }
  },
  tilesets = {
    {
      name = "arena-tileset",
      firstgid = 1,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "arena-spritesheet.png",
      imagewidth = 256,
      imageheight = 256,
      transparentcolor = "#ff00ff",
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 256,
      tiles = {
        {
          id = 17,
          objectGroup = {
            type = "objectgroup",
            draworder = "index",
            id = 2,
            name = "",
            class = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            parallaxx = 1,
            parallaxy = 1,
            properties = {},
            objects = {
              {
                id = 3,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0,
                y = 0,
                width = 16,
                height = 16,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 42,
          properties = {
            ["type"] = "goal"
          }
        },
        {
          id = 43,
          properties = {
            ["is_spawn"] = true
          }
        },
        {
          id = 48,
          properties = {
            ["is_solid"] = true
          }
        },
        {
          id = 49,
          properties = {
            ["is_solid"] = true
          }
        },
        {
          id = 64,
          properties = {
            ["is_solid"] = true
          }
        },
        {
          id = 65,
          properties = {
            ["is_solid"] = true
          }
        },
        {
          id = 130,
          properties = {
            ["is_solid"] = true
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      id = 7,
      name = "grid",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 42, 42, 42, 42, 42, 42, 42, 0, 0,
        0, 42, 42, 42, 42, 42, 42, 42, 0, 0,
        0, 42, 42, 42, 41, 41, 41, 42, 0, 0,
        0, 0, 41, 42, 41, 42, 41, 0, 0, 0,
        0, 42, 41, 41, 41, 42, 42, 42, 0, 0,
        0, 42, 42, 42, 42, 42, 42, 42, 0, 0,
        0, 42, 42, 42, 42, 42, 42, 42, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      id = 9,
      name = "spawns",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 44, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      id = 6,
      name = "walls",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 49, 0, 0, 0, 0, 85, 87, 0, 0,
        0, 0, 0, 88, 0, 0, 117, 119, 0, 0,
        0, 0, 0, 104, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 120, 0, 88, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 104, 0, 0, 0, 0,
        0, 85, 87, 0, 0, 120, 0, 0, 0, 0,
        0, 117, 119, 0, 0, 0, 0, 49, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      id = 10,
      name = "entities",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 43, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "map_center",
          type = "",
          shape = "point",
          x = 80,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = false,
          properties = {}
        },
        {
          id = 4,
          name = "spawn",
          type = "",
          shape = "point",
          x = 16,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = false,
          properties = {
            ["direction"] = "right",
            ["is_spawn"] = true
          }
        }
      }
    }
  }
}
