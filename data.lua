require "prototypes.factory"
require "prototypes.component"
require "prototypes.utility"
require "prototypes.recipe"
require "prototypes.technology"
require "prototypes.tile"
require "prototypes.borehole-pump"
require "prototypes.roboport"
require "prototypes.greenhouse"
require "prototypes.space-age-rebalance"
require "graphics.space-platform-build-anim.entity-build-animations"

data:extend {
	{
		type = "item-subgroup",
		name = "factorissimo2",
		group = "logistics",
		order = "e-e"
	},
	{
		type = "custom-input",
		name = "factory-rotate",
		key_sequence = "R",
	},
	{
		type = "custom-input",
		name = "factory-increase",
		key_sequence = "SHIFT + R",
	},
	{
		type = "custom-input",
		name = "factory-decrease",
		key_sequence = "CONTROL + R",
	},
	{
		type = "custom-input",
		name = "factory-open-outside-surface-to-remote-view",
		key_sequence = "",
		linked_game_control = "build-ghost"
	},
	{
		type = "custom-event",
		name = "on_script_setup_blueprint"
	},

  {
    type = "sprite",
    name = "factorissimo-gui-icon-lens",
    filename = "__factorissimo-2-notnotmelon__/graphics/icon/factorissimo-gui-icon-lens.png",
    priority = "extra-high-no-scale",
    width = 64,
    height = 64,
    flags = {"gui-icon"},
    scale = 0.5
  },
  {
    type = "sprite",
    name = "factorissimo-gui-icon-no-lens",
    filename = "__factorissimo-2-notnotmelon__/graphics/icon/factorissimo-gui-icon-no-lens.png",
    priority = "extra-high-no-scale",
    width = 64,
    height = 64,
    flags = {"gui-icon"},
    scale = 0.5
  },
}

if mods["power-grid-comb"] then
	require "compat.powergridcomb"
end
