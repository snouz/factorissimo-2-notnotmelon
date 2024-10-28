local entities_to_extend = {}

local function downscale(picture)
    if not picture then return end

    if type(picture) == "table" and picture.layers then
        for _, layer in pairs(picture.layers or {}) do
            downscale(layer)
        end
        return
    end

    picture.scale = (picture.scale or 1) / 2
    if picture.shift then
        local x, y = picture.shift[1] or picture.shift.x or 0, picture.shift[2] or picture.shift.y or 0
        picture.shift = {x = x / 2, y = y / 2}
    end
end

local function vector_downscale(vector)
    if not vector then return end

    if vector.x and type(vector.x) == "number" then vector.x = vector.x / 2 end
    if vector.y and type(vector.y) == "number" then vector.y = vector.y / 2 end
    if vector[1] and type(vector[1]) == "number" then vector[1] = vector[1] / 2 end
    if vector[2] and type(vector[2]) == "number" then vector[2] = vector[2] / 2 end

    for _, subvector in pairs(vector) do
        if type(subvector) == "table" then
            vector_downscale(subvector)
        end
    end
end

local roboport = table.deepcopy(data.raw["roboport"]["roboport"])
roboport.name = "factory-construction-roboport"
roboport.collision_box = {{-0.9, -0.9}, {0.9, 0.9}}
roboport.selection_box = {{-1, -1}, {1, 1}}
roboport.recharging_light.size = roboport.recharging_light.size / 2
roboport.charging_station_count_affected_by_quality = true
roboport.logistics_radius = 4
roboport.construction_radius = 128
roboport.radar_range = 0
downscale(roboport.base)
downscale(roboport.base_patch)
downscale(roboport.frozen_patch)
downscale(roboport.base_animation)
downscale(roboport.door_animation_up)
downscale(roboport.door_animation_down)
downscale(roboport.recharging_animation)
vector_downscale(roboport.charging_station_shift)
vector_downscale(roboport.stationing_offset)
vector_downscale(roboport.charging_offsets)
entities_to_extend[#entities_to_extend + 1] = roboport

local storage_chest = table.deepcopy(data.raw["logistic-container"]["passive-provider-chest"])
storage_chest.name = "factory-construction-chest"
entities_to_extend[#entities_to_extend + 1] = storage_chest

for _, factory_name in pairs{"factory-1", "factory-2", "factory-3"} do
    -- all materials are delivered via the construction network. there is no need for this to be a requester.
    local requester_chest = table.deepcopy(data.raw["logistic-container"]["requester-chest"])
    requester_chest.name = "factory-requester-chest-" .. factory_name
    requester_chest.collision_box = data.raw["storage-tank"][factory_name].collision_box
    requester_chest.selection_box = nil
    requester_chest.picture = nil
    requester_chest.localised_name = {"entity-name.factory-requester-chest"}
    entities_to_extend[#entities_to_extend + 1] = requester_chest
end

for _, prototype in pairs(entities_to_extend) do
    prototype.collision_mask = {layers = {}}
    prototype.minable = nil
    flags = {"placeable-neutral", "player-creation"}
end

data:extend(entities_to_extend)