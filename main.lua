local Mod = require("modloader.mod")
local ModTypes = require("modloader.modtypes")

--ArSpr = ModTypes.ModImage(self, "ArSpr")
local ThisMod = self

onEnable(function(self)

spriteKeys = {}

spriteKeys['snkrx'] = {}

spriteKeys['snkrx']['archer'] = ModTypes.ModImage(ThisMod, 'SNKRX custom sprites/ArSpr.png')
spriteKeys['snkrx']['magician'] = ModTypes.ModImage(ThisMod, 'SNKRX custom sprites/MagSpr.png')
spriteKeys['snkrx']['dual_gunner'] = ModTypes.ModImage(ThisMod, 'SNKRX custom sprites/DGSpr.png')
spriteKeys['snkrx']['scout'] = ModTypes.ModImage(ThisMod, 'SNKRX custom sprites/ScoSpr.png')
spriteKeys['snkrx']['outlaw'] = ModTypes.ModImage(ThisMod, 'SNKRX custom sprites/OutSpr.png')
spriteKeys['snkrx']['wizard'] = ModTypes.ModImage(ThisMod, 'SNKRX custom sprites/WizSpr.png')

function setNewDraw(mod, unit)
	ModLoader.loadedMods[mod][unit].mySprite = spriteKeys[mod][unit]
	ModLoader.loadedMods[mod][unit].draw = newDraw
end

newDraw = function(self, player)
	local col = player.color
	graphics.rectangle(player.x, player.y, player.shape.w, player.shape.h, 3, 3, (player.hfx.hit.f or player.hfx.shoot.f) and fg_transparent_weak or Color(col.r, col.g, col.b, 0.25))
	
	if not(player.mySprite == nil) then
		player.mySprite:draw(player.x, player.y, 0, player.shape.w, player.shape.h, 3, 3, player.color)
	end
	
	if player.leader and state.arrow_snake then
        local x, y = player.x + 0.9*player.shape.w, player.y
        graphics.line(x + 3, y, x, y - 3, player.color, 1)
        graphics.line(x + 3, y, x, y + 3, player.color, 1)
      end

      if player.ouroboros_def_m and player.ouroboros_def_m > 1 then
        graphics.rectangle(player.x, player.y, 1.25*player.shape.w, 1.25*player.shape.h, 3, 3, yellow_transparent)
      end

      if player.divined then
        graphics.rectangle(player.x, player.y, 1.25*player.shape.w, 1.25*player.shape.h, 3, 3, green_transparent)
      end

      if player.fairyd then
        graphics.rectangle(player.x, player.y, 1.25*player.shape.w, 1.25*player.shape.h, 3, 3, blue_transparent)
      end
    end
	
	setNewDraw('snkrx', 'archer')
	setNewDraw('snkrx', 'dual_gunner')
	setNewDraw('snkrx', 'scout')
	setNewDraw('snkrx', 'outlaw')
	setNewDraw('snkrx', 'magician')
	setNewDraw('snkrx', 'wizard')
end)
