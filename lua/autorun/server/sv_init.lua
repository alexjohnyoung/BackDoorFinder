local Enable = true --Make false to disable


	if Enable then
		local BackDoorFinder = {} --make a table for our uses
		BackDoorFinder.Advertising = false --Set to false to turn off my 'advertising' and true to enable
		BackDoorFinder.AdvertisingDelay = 300 --Set to how long it will 'advertise' (in seconds: def 5 min)
		BackDoorFinder.Found = {} 

		-----------------Table Detours----------------------------
		BackDoorFinder.TI = table.insert
		-----------------Debug Detours----------------------------
		BackDoorFinder.d = debug.getinfo
		BackDoorFinder.reg = debug.getregistry()
		-----------------Util Detours-----------------------------
		BackDoorFinder.uTn = util.AddNetworkString
		-----------------Timer Detours----------------------------
		BackDoorFinder.tC = timer.Create
		-----------------Hook Detours-----------------------------
		BackDoorFinder.hA = hook.Add
		-----------------File Detours-----------------------------
		BackDoorFinder.cD = file.CreateDir
		BackDoorFinder.Ap = file.Append
		BackDoorFinder.fR = file.Read
		BackDoorFinder.fW = file.Write
		BackDoorFinder.fE = file.Exists
		-----------------Net Detours------------------------------
		BackDoorFinder.nS = net.Start 
		BackDoorFinder.wS = net.WriteString 
		BackDoorFinder.nSS = net.Send 
		-----------------String Detours------------------------------
		BackDoorFinder.sE = string.Explode
		BackDoorFinder.tS = tostring
		-----------------Math Detours--------------------------------
		BackDoorFinder.mR = math.Rand
		-----------------Concommand Detours--------------------------
		BackDoorFinder.cA = concommand.Add
		-----------------Other Detours-------------------------------
		BackDoorFinder.type = type --same as above?
		BackDoorFinder.MsgC = MsgC
		-------------------------------------------------------------
		BackDoorFinder.pr = function(col, str)  --printing function, yolo
			BackDoorFinder.MsgC(color_white, "\n // ", col, str, color_white, " //\n")
		end
		---------------------------------------
		BackDoorFinder.uTn("bdf.print")
		BackDoorFinder.cD("backdoorfinder")
		---------------------------------------
		BackDoorFinder.printPlayer = function(str, ply) 
			BackDoorFinder.nS("bdf.print")
			BackDoorFinder.wS(str)
			BackDoorFinder.nSS(ply) 
		end 
		---------------------------------------
		if BackDoorFinder.Advertising then
			BackDoorFinder.tC("plzDontremove", BackDoorFinder.AdvertisingDelay, 0, function()
				for k,v in pairs(player.GetAll()) do 
					BackDoorFinder.printPlayer("This server is running Tyguy's BackDoorFinder addon!", v)
				end 
			end )
		end
		---------------------------------------

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
		local copyPlz = {}

		BackDoorFinder.log = {}

		BackDoorFinder.hA("Think", BackDoorFinder.tS(BackDoorFinder.mR(1, 500000)), function() 
			BackDoorFinder.bad = reCop
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
