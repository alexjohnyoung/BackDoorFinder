--[[
	Nothing to really add for clientside..
	Might add stuff later
--]]

net.Receive("bdf.print", function(ply) print(net.ReadString()) end ) 

concommand.Add("backdoorfinder", function(ply)
	print("This server is running Tyguy's BackDoorFinder addon!")
end ) 
