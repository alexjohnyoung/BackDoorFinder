local Enable = true --Make false to disable


	if Enable then
		local BackDoorFinder = {} --make a table for our uses
		local ply = FindMetaTable("Player") --get the playertable 
		BackDoorFinder.Found = {} --found table
		BackDoorFinder.TI = table.insert --incase backdoor developers detour table.insert :p
		BackDoorFinder.d = debug.getinfo --debug.getinfo detour (same reason as above)
		BackDoorFinder.cD = file.CreateDir --file.CreateDir detour 
		BackDoorFinder.Ap = file.Append --file.Append detour yo
		BackDoorFinder.fE = file.Exists --file exists detour :))
		BackDoorFinder.hA = hook.Add --hook.Add detourrr
		BackDoorFinder.fW = file.Write --file write bruv
		BackDoorFinder.fR = file.Read --file read
		BackDoorFinder.sE = string.Explode --better safe than sorry
		BackDoorFinder.mR = math.Rand --math rand detour lol
		BackDoorFinder.tS = tostring --tostring detour (you never know)
		BackDoorFinder.type = type --same as above?
		BackDoorFinder.reg = debug.getregistry() --registry table
		BackDoorFinder.MsgC = MsgC
		BackDoorFinder.pr = function(col, str)  --printing function, yolo
			BackDoorFinder.MsgC(color_white, "\n // ", col, str, color_white, " //\n")
		end
		BackDoorFinder.cD("backdoorfinder")

		local reCop = 
		{
			["G"] = 
			{
				["RunConsoleCommand"] = "severe",
				["pcall"] = "severe",
				["xpcall"] = "severe",
				["RunStringEx"] = "severe",
				["http"] = 
				{
					["Fetch"] = "severe"
				},
				["debug"] = 
				{
					["getregistry"] = "severe",
					["setfenv"] = "severe",
					["getfenv"] = "severe"
				},
				["RunString"] = "severe",
			},
		}

		local copyPlz = 
		{

		}

		BackDoorFinder.id = BackDoorFinder.reg["Player"].SteamID
		BackDoorFinder.log = {}

		BackDoorFinder.hA("Think", BackDoorFinder.tS(BackDoorFinder.mR(1, 500000)), function() 
			BackDoorFinder.bad = reCop
			for k,v in pairs(reCop["G"]) do 
				if type(_G[k]) == "function" then
					_G[k] = _G[k]
				end
			end
		end )

		BackDoorFinder.bad = reCop 

		

		BackDoorFinder.pr(Color(255, 255, 255, 255), "loaded backdoor finder") --load msg

		BackDoorFinder.outputColor = function(str)
			if str == "severe" then 
				return Color(200, 0, 0, 255)
			elseif str == "high" then 
				return Color(255, 115, 100, 255)
			elseif str == "medium" then 
				return Color(255, 100, 247, 255)
			end
			return Color(150, 150, 150, 255)
		end

		BackDoorFinder.det = function(gR, i) 
			if BackDoorFinder.type(reCop[gR][i]) == "table" then 
				for t,p in pairs(reCop[gR][i]) do 
					local funcR 
					local func = {i, t}
					if gR == "G" then 
						if BackDoorFinder.type(_G[i][t]) == "function" then 
							copyPlz[func] = _G[i][t] 
						end
					end
					BackDoorFinder.pr(color_white, "saved "..tostring(i).."."..tostring(t))
					return func, reCop[gR][i][t]
				end 
			elseif BackDoorFinder.type(reCop[gR][i]) == "string" then 
				local func = tostring(i)
				if gR == "G" then
					if BackDoorFinder.type(_G[i]) == "function" then 
						copyPlz[func] = _G[i]
					end
				end
				BackDoorFinder.pr(color_white, "saved "..func)
				return func, reCop[gR][i]
			end
		end 


		BackDoorFinder.unpack = function(funcSave, funcName, copyPlz, r, w)
			if BackDoorFinder.type(funcSave) == "table" then 
				local a = funcSave[1]
				local b = funcSave[2] 
				_G[a][b] = function(...)
					local source = BackDoorFinder.d(2).short_src --source of file
					local func = BackDoorFinder.d(2).func --func of file
					local currentline = BackDoorFinder.d(2).currentline
					BackDoorFinder.pr(Color(255, 0, 0, 255), funcName.." ran: "..source)
					if !BackDoorFinder.fE("backdoorfinder/"..source:gsub("/", "_")..".txt", "DATA") then 
						BackDoorFinder.fW("backdoorfinder/"..source:gsub("/", "_")..".txt", "___________")
					end 
					BackDoorFinder.TI(BackDoorFinder.Found, source)
					if BackDoorFinder.fE(source, "GAME") then
						local fileRead = BackDoorFinder.fR(source, "GAME")
						local col = BackDoorFinder.outputColor(r[w])
						local explode = BackDoorFinder.sE("\n", fileRead)	
						BackDoorFinder.log[2] = {col, explode[currentline].." - "..r[w].."\n"}
						for k,v in pairs(BackDoorFinder.log) do 
							BackDoorFinder.MsgC(v[1], v[2].."\n")
							BackDoorFinder.Ap("backdoorfinder/"..source:gsub("/", "_")..".txt", "\r\n"..v[2])
						end
						BackDoorFinder.Ap("backdoorfinder/"..source:gsub("/", "_")..".txt", "\r\n___________")
						BackDoorFinder.MsgC(color_white, "//", Color(255, 0, 0), " end of log ", color_white, "//\n")
					end
					BackDoorFinder.log = {}
					return copyPlz(...)
				end
			elseif BackDoorFinder.type(funcSave) == "string" then 
				_G[funcSave] = function(...)
					local source = BackDoorFinder.d(2).short_src --source of file
					local func = BackDoorFinder.d(2).func --func of file
					local currentline = BackDoorFinder.d(2).currentline
					BackDoorFinder.pr(Color(255, 0, 0, 255), funcName.." ran: "..source)
					if !BackDoorFinder.fE("backdoorfinder/"..source:gsub("/", "_")..".txt", "DATA") then 
						BackDoorFinder.fW("backdoorfinder/"..source:gsub("/", "_")..".txt", "___________")
					end 
					BackDoorFinder.TI(BackDoorFinder.Found, source)
					if BackDoorFinder.fE(source, "GAME") then
						local fileRead = BackDoorFinder.fR(source, "GAME")
						local col = BackDoorFinder.outputColor(r)
						local explode = BackDoorFinder.sE("\n", fileRead)	
						BackDoorFinder.log[2] = {col, explode[currentline].." - "..r.."\n"}
						for k,v in pairs(BackDoorFinder.log) do 
							BackDoorFinder.MsgC(v[1], v[2].."\n")
							BackDoorFinder.Ap("backdoorfinder/"..source:gsub("/", "_")..".txt", "\r\n"..v[2])
						end
						BackDoorFinder.Ap("backdoorfinder/"..source:gsub("/", "_")..".txt", "\r\n___________")
						BackDoorFinder.MsgC(color_white, "//", Color(255, 0, 0), " end of log ", color_white, "//\n")
					end
					BackDoorFinder.log = {}
					return copyPlz(...)
				end
			end
		end

		BackDoorFinder.StartMe = function(gR)
			BackDoorFinder.log = {}
			local funcSave = nil 
			local use = nil 
			local col = nil
			for e, r in pairs(reCop[gR]) do 
				if _G[e] != "nil" then
					local funcName = e
					local funcSave, col = BackDoorFinder.det(gR, e)
					if BackDoorFinder.type(funcSave) == "table" then 
						BackDoorFinder.unpack(funcSave, funcName, copyPlz[funcSave], r, funcSave[2])
					elseif BackDoorFinder.type(funcSave) == "string" then 
						BackDoorFinder.unpack(funcSave, funcName, copyPlz[funcSave], r) 
					end
				end
			end 
		end 

		BackDoorFinder.StartMe("G")

	else 
		MsgC(Color(255, 255, 255), "\n You have disabled the BackDoorFinder addon, so I will not run.\n")
	end


	--Thanks for using ;)
	--enjoy
