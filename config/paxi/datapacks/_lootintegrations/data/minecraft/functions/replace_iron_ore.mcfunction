execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:iron_ore"}}] run data merge entity @s {Item:{id:"minecraft:raw_iron_block",Count:1b}}
execute as @e[type=minecraft:block_display,nbt={block_state:{Name:"minecraft:iron_ore"}}] run data merge entity @s {block_state:{Name:"minecraft:raw_iron_block"}}
execute as @e[type=minecraft:block,nbt={Name:"minecraft:iron_ore"}] run setblock ~ ~ ~ minecraft:raw_iron_block
