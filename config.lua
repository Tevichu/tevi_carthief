config = {}

config.Locale = 'en'

config.InteractKey = 38 -- Don't forget to change the local.

config.spawnponts = { -- Possible spawn points for cars
{x=283.24,y=-239.8,z=53.61,h=69.64},
{x=-1269.74,y=233.04,z=60.82,h=99.8},
{x=-1183.65,y=-1268.58,z=5.84,h=26.37},
{x=-903.75,y=1087.5,z=220.09,h=9.45},
{x=-3003.39,y=1456.03,z=26.83,h=331.48}
}

config.vehicles = {-- Possible models that can spawn
{m="cogcabrio"},
{m="oracle2"},
{m="zion"},
{m="panto"},
{m="felon"},
{m="jackal"},
{m="windsor2"},
{m="f620"},
{m="ruiner"},
{m="virgo2"},
{m="asea"},
{m="exemplar"}
}

--                        Min - Max
config.paid = math.random(750, 2500) -- amount of money you earn by delivering a car


--enable / disable the blip where the npc is located
config.blip = false