local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local TopbarUI = Player.PlayerGui:FindFirstChild("TopbarUI")
local MainUI = Player.PlayerGui:FindFirstChild("MainUI")
local Main_Game = MainUI.Initiator:FindFirstChild("Main_Game")

local RemotesFolder = ReplicatedStorage:FindFirstChild("RemotesFolder")
local LiveModifiers = ReplicatedStorage:FindFirstChild("LiveModifiers")
local GameData = ReplicatedStorage:FindFirstChild("GameData")
local PlayAgain = RemotesFolder:FindFirstChild("PlayAgain")
local Lobby = RemotesFolder:FindFirstChild("Lobby")
local CreateElevator = RemotesFolder:FindFirstChild("CreateElevator")
local Statistics = RemotesFolder:FindFirstChild("Statistics")
local RequestShop = RemotesFolder:FindFirstChild("RequestShop")
local PurchaseShopItem = RemotesFolder:FindFirstChild("PurchaseShopItem")
local Floor = GameData:FindFirstChild("Floor")

local CanLeave = false
local Count = 0
local ModifierCount = 0
local Modifier = {
	Ordinary = {
		AdminPanel = -999,
		StreamerMode = -50,
		CustomSeed = -999,
		BeforePlus = -100,
		SuperHardMode = -100,
		RetroMode = -90,
		Voicelines = -20,
		Chaos1 = 10,
		Chaos2 = 30,
		Chaos3 = 50,
		LightsNeverFlicker = 10,
		LightsLess = 10,
		LightsLeast = 15,
		LightsOut = 25,
		GoldSpawnLess = 5,
		GoldSpawnNone = 15,
		ItemSpawnMore = -50,
		ItemSpawnLess = 5,
		ItemSpawnNone = 15,
		ItemDurabilityLess = 5,
		PlayerLessSlots = 5,
		PlayerLeastSlots = 10,
		NoGuidingLight = 5,
		NoKeySound = 5,
		Slippery = 10,
		Fog = 10,
		Firedamp = 5,
		FiredampMost = 15,
		LockMore = 10,
		LockMost = 15,
		LeastHidingSpots = 10,
		Jammin = 15,
		PlayerHealthLess = 5,
		PlayerHealthLeast = 10,
		PlayerDamageMore = 10,
		PlayerDamageMost = 20,
		PlayerFast = -50,
		PlayerFaster = -75,
		PlayerFastest = -125,
		PlayerCrouchSlow = 5,
		PlayerSlow = 10,
		PlayerSlowHealth = 5,
		EntitiesLess = -50,
		EntitiesMore = 10,
		EntitiesMost = 20,
		EntitiesMoster = 25,
		RushMore = 10,
		RushFaster = 10,
		RushQuiet = 10,
		RushLevel2 = 5,
		DupeMore = 5,
		DupeMost = 15,
		ScreechLight = 5,
		ScreechFast = 5,
		ScreechFaster = 10,
		TimothyLess = -10,
		TimothyMore = 5,
		EyesMore = 5,
		EyesMost = 10,
		EyesTwice = 15,
		EyesFour = 20,
		EyesLevel2 = 5,
		FigureFaster = 5,
		AmbushMore = 10,
		AmbushFaster = 10,
		HideTime = 15,
		HideLevel2 = 5,
		SnareMore = 5,
		SnareMost = 10,
		SnareMoster = 15,
		Dread = 5,
		DreadMost = 10,
		Giggle = 5,
		GiggleMore = 10,
		GiggleMost = 15,
		GiggleSunglasses = 5,
		Gloombat = 5,
		GloombatMore = 10,
		RoomsA90 = 15,
		Rooms = 20,
		BackdoorRush = 5,
		BackdoorLookman = 10,
		BackdoorVacuum = 10,
		BackdoorHaste = 25,
		SkipToLibrary = 0,
		SkipToEnd = 0,
		SkipToRooms = 0,
		MinesSkipSeek = 0,
		MinesSkipEnd = 0,
		Trailer = -999,
		SkipToMaze = 0
	},
	NoProgress = {
		AdminPanel = true, 
		StreamerMode = true,
		CustomSeed = true,
		BeforePlus = true,
		SuperHardMode = true,
		RetroMode = true,
		PlayerFaster = true,
		PlayerFastest = true,
		Trailer = true
	},
	Prohibited = {
		PlayerHealthLess = true,
		PlayerHealthLeast = true,
		PlayerDamageMore = true,
		PlayerDamageMost = true,
		GoldSpawnLess = true,
		GoldSpawnNone = true
	}
}
local Color = {
	White = Color3.fromRGB(255, 255, 255),
	Red =  Color3.fromRGB(255, 189, 198)
}
local function Caption()
	local CaptionHit = Instance.new("Sound", workspace)
	CaptionHit.SoundId = "rbxassetid://3848738542"
	CaptionHit.Volume = 0.1
	CaptionHit.PlaybackSpeed = 1
	CaptionHit.RollOffMode = Enum.RollOffMode.Inverse
	CaptionHit:Play()
	CaptionHit.Ended:Connect(function()
		CaptionHit:Destroy()
	end)
	return CaptionHit
end
local function KnobsFarmUI()
	local CoreGui = gethui()

	local ScreenGui = Instance.new("ScreenGui", CoreGui)
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.DisplayOrder = 99999
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Name = "Knobs Farm"
	
	local MainUI = Instance.new("Frame", ScreenGui)
	MainUI.Size = UDim2.new(1, 0, 1, 0)
	MainUI.BackgroundTransparency = 1
	MainUI.Name = "MainUI"
	
	local Template = Instance.new("Frame", MainUI)
	Template.Visible = false
	Template.BackgroundColor3 = Color3.fromRGB(255, 222, 189)
	Template.Size = UDim2.new(0.2, 0, 0.07, 0)
	Template.Name = "Template"
	
	local UICorner = Instance.new("UICorner", Template)
	UICorner.CornerRadius = UDim.new(1, 0)
	
	local UIGradient = Instance.new("UIGradient", Template)
	UIGradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0.000, 0),
		NumberSequenceKeypoint.new(1.000, 1)
	}
	
	local UIListLayout = Instance.new("UIListLayout", Template)
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	
	local Icon = Instance.new("ImageLabel", Template)
	Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Icon.ScaleType = Enum.ScaleType.Crop
	Icon.Image = ""
	Icon.Size = UDim2.new(0.9, 0, 0.9, 0)
	Icon.BackgroundTransparency = 1
	Icon.LayoutOrder = 1
	Icon.Name = "Icon"
	
	local UIPadding = Instance.new("UIPadding", Template)
	UIPadding.PaddingLeft = UDim.new(0, 10)
	
	local TextValue = Instance.new("TextLabel", Template)
	TextValue.TextWrapped = true
	TextValue.TextScaled = true
	TextValue.TextXAlignment = Enum.TextXAlignment.Left
	TextValue.FontFace = Font.new(
		"rbxasset://fonts/families/Oswald.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	TextValue.TextColor3 = Color3.fromRGB(255, 222, 189)
	TextValue.BackgroundTransparency = 1
	TextValue.Size = UDim2.new(1, 0, 0.9, 0)
	TextValue.Text = "0"
	TextValue.LayoutOrder = 2
	TextValue.Name = "TextValue"
	
	local UIStroke = Instance.new("UIStroke", TextValue)
	UIStroke.Thickness = 3
	
	local UIPadding = Instance.new("UIPadding", TextValue)
	UIPadding.PaddingLeft = UDim.new(0, 10)
	
	local ImageValue = Instance.new("ImageLabel", Template)
	ImageValue.SizeConstraint = Enum.SizeConstraint.RelativeYY;
	ImageValue.ScaleType = Enum.ScaleType.Fit
	ImageValue.ImageColor3 = Color3.fromRGB(255, 223, 190)
	ImageValue.Image = ""
	ImageValue.Size = UDim2.new(1, 0, 0.9, 0)
	ImageValue.Visible = false
	ImageValue.BackgroundTransparency = 1
	ImageValue.LayoutOrder = 2
	ImageValue.Name = "ImageValue"
	
	local UIListLayout = Instance.new("UIListLayout", MainUI)
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.Padding = UDim.new(0, 10)
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	local UIPadding = Instance.new("UIPadding", MainUI)
	UIPadding.PaddingRight = UDim.new(0, 10)
	
	local Title = Instance.new("TextLabel", MainUI)
	Title.TextScaled = true
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Right
	Title.FontFace = Font.new(
		"rbxasset://fonts/families/Oswald.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	Title.TextColor3 = Color3.fromRGB(255, 223, 190)
	Title.BackgroundTransparency = 1
	Title.RichText = true
	Title.Size = UDim2.new(0.2, 0, 0.07, 0)
	Title.Text = "Knobs Farm\nBy Munciseek"
	Title.LayoutOrder = -2
	Title.Name = "Title"
	
	local UIStroke = Instance.new("UIStroke", Title)
	UIStroke.Thickness = 3
	
	local Button = Instance.new("Frame", MainUI)
	Button.Size = UDim2.new(0.2, 0, 0.07, 0)
	Button.Name = "Button"
	Button.LayoutOrder = 99999
	Button.BackgroundTransparency = 1
	
	local Leave = Instance.new("TextButton", Button)
	Leave.TextScaled = true
	Leave.TextWrapped = true
	Leave.TextColor3 = Color3.fromRGB(64, 42, 36)
	Leave.BackgroundColor3 = Color3.fromRGB(255, 223, 190)
	Leave.FontFace = Font.new(
		"rbxasset://fonts/families/Oswald.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	Leave.Size = UDim2.new(0.45, 0, 1, 0)
	Leave.LayoutOrder = 1
	Leave.Text = "Leave"
	Leave.Name = "Leave"
	
	local UICorner = Instance.new("UICorner", Leave)
	UICorner.CornerRadius = UDim.new(1, 0)
	
	local Buy = Instance.new("TextButton", Button)
	Buy.TextScaled = true
	Buy.TextWrapped = true
	Buy.TextColor3 = Color3.fromRGB(64, 42, 36)
	Buy.BackgroundColor3 = Color3.fromRGB(255, 223, 190)
	Buy.FontFace = Font.new(
		"rbxasset://fonts/families/Oswald.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	Buy.Size = UDim2.new(0.45, 0, 1, 0)
	Buy.LayoutOrder = 2
	Buy.Text = "Buy All Skin"
	Buy.Name = "Buy"
	
	local UICorner = Instance.new("UICorner", Buy)
	UICorner.CornerRadius = UDim.new(1, 0)
	
	local UIListLayout = Instance.new("UIListLayout", Button)
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 10)
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	
	local UIPadding = Instance.new("UIPadding", Button)
	UIPadding.PaddingTop = UDim.new(0, 10)
	UIPadding.PaddingBottom = UDim.new(0, 10)
	
	local TextLabel = Instance.new("TextLabel", MainUI)
	TextLabel.TextWrapped = true
	TextLabel.TextScaled = true
	TextLabel.FontFace = Font.new(
		"rbxasset://fonts/families/Oswald.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	TextLabel.TextColor3 = Color3.fromRGB(255, 223, 190)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Size = UDim2.new(0.2, 0, 0.04, 0)
	TextLabel.Text = ""
	TextLabel.LayoutOrder = 100000
	TextLabel.Name = "Tips"
	
	return ScreenGui
end
local function Enable()
	if Floor.Value ~= "Mines" then
		RunService.Heartbeat:Connect(function()
			local Main_Game = MainUI.Initiator:FindFirstChild("Main_Game")
			require(Main_Game).freemouse = true
			require(Main_Game).caption("Please select The Mines", true)
		end)
		task.wait(3)
		Lobby:FireServer()
		return
	end
	
	local LatestRoom = ReplicatedStorage.GameData.LatestRoom
	if LatestRoom.Value ~= 0 then
		PlayAgain:FireServer()
		RunService.Heartbeat:Connect(function()
			local Main_Game = MainUI.Initiator:FindFirstChild("Main_Game")
			require(Main_Game).freemouse = true
			require(Main_Game).caption("Don't open the door!", true)
		end)
		return
	end
	
	for ProhibitedModifierName, _ in pairs(Modifier.Prohibited) do
		if LiveModifiers:FindFirstChild(ProhibitedModifierName) then
			RunService.Heartbeat:Connect(function()
				local Main_Game = MainUI.Initiator:FindFirstChild("Main_Game")
				require(Main_Game).freemouse = true
				require(Main_Game).caption("Cannot select"..ProhibitedModifierName, true)
			end)
			task.wait(3)
			Lobby:FireServer()
			return
		end
	end
	if Player.Gold.Value < 20 then
		local Main_Game = MainUI.Initiator:FindFirstChild("Main_Game")
		local CaveAtmosphere = Lighting:FindFirstChild("CaveAtmosphere")
		local CurrentRoom = workspace.CurrentRooms[LatestRoom.Value]
		local Assets = CurrentRoom:FindFirstChild("Assets")

		require(Main_Game).caption("The amount of Gold is less than 20", true)
		CurrentRoom:SetAttribute("Ambient", Color3.fromRGB(255, 255, 255))
		if CaveAtmosphere then
			CaveAtmosphere:Destroy()
		end
		for _, Container in ipairs(Assets:GetDescendants()) do
			if Container:GetAttribute("LoadModule") == "DrawerContainer" then
				if Container:GetAttribute("Category") == "LockedBox" then
					if not Container:GetAttribute("Tagged") then
						Container:SetAttribute("Tagged", true)
						local Highlight = Instance.new("Highlight")
						Highlight.FillTransparency = 0.7
						Highlight.OutlineTransparency = 0
						Highlight.FillColor = Color3.fromRGB(255, 0, 0)
						Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
						Highlight.Parent = Container
					end
				else
					if not Container:GetAttribute("Tagged") then
						local Highlight = Instance.new("Highlight")
						Highlight.FillTransparency = 0.7
						Highlight.OutlineTransparency = 0
						Highlight.FillColor = Color3.fromRGB(0, 255, 0)
						Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
						Highlight.Parent = Container
					end
				end
			end
		end
		return
	end

	local KnobsFarm = KnobsFarmUI()
	local function Data(Name, Icon, IconColor, Bool)
		local MainUI = KnobsFarm:FindFirstChild("MainUI")
		local Template = MainUI:FindFirstChild("Template"):Clone()
		Template.Parent = MainUI
		Template.Visible = true
		Template.Name = Name
		
		local IconFrame = Template:FindFirstChild("Icon")
		if IconFrame then
			IconFrame.Image = "rbxassetid://"..Icon
		end
		if IconColor then
			IconFrame.ImageColor3 = IconColor
		else
			IconFrame.ImageColor3 = Color3.fromRGB(255, 255, 255)
		end
		
		if Bool then
			local TextValue = Template:FindFirstChild("TextValue")
			local ImageValue = Template:FindFirstChild("ImageValue")
			TextValue.Visible = false
			ImageValue.Visible = true
		else
			local TextValue = Template:FindFirstChild("TextValue")
			local ImageValue = Template:FindFirstChild("ImageValue")
			TextValue.Visible = true
			ImageValue.Visible = false
		end
		
		return Template
	end
	
	local function FormatNumber(num)
		return tostring(num):reverse():gsub("%d%d%d", "%0,"):reverse():gsub("^,", "")
	end
	local Time = Data("Time", 96044600756321, Color.White)
	local Gold = Data("Gold", 16587947721, Color.White)
	local Knobs = Data("Knobs", 16587915599, Color.White)
	local Death = Data("Count", 11335379265, Color.Red)
	local Modifiers = Data("Modifiers", 14380950090, Color.Red)
	local Boosts = Data("Boosts", 10448639430, Color.White, true)
	
	local Topbar = TopbarUI:FindFirstChild("Topbar")
	if Topbar.Knobs.Boosted.Visible then
		Boosts.ImageValue.Image = "rbxassetid://10641141836"
	else
		Boosts.ImageValue.Image = "rbxassetid://126946411376860"
	end
	if LiveModifiers then
		local HasNoProgress = false
		for _, LiModifier in pairs(LiveModifiers:GetChildren()) do
			if Modifier.NoProgress[LiModifier.Name] then
				HasNoProgress = true
				break
			end
		end
		
		if HasNoProgress then
			ModifierCount = -999
		else
			for ModifierName, BonusValue in pairs(Modifier.Ordinary) do
				if LiveModifiers:FindFirstChild(ModifierName) then
					ModifierCount = ModifierCount + BonusValue
				end
			end
		end
	end
	Gold.TextValue.Text = FormatNumber(Player.Gold.Value)
	Modifiers.TextValue.Text = ModifierCount.."%"
	RunService.Heartbeat:Connect(function()
		local MainData = require(ReplicatedStorage:FindFirstChild("ReplicaDataModule"))
		local Data = MainData.players[Player]
		local KnobsData = Data.data.Knobs
		Knobs.TextValue.Text = FormatNumber(KnobsData)
		Time.TextValue.Text = os.date("%H:%M:%S")
		Death.TextValue.Text = "#" .. FormatNumber(Count)
	end)

	local Tips = KnobsFarm.MainUI:FindFirstChild("Tips")
	local Button = KnobsFarm.MainUI:FindFirstChild("Button")
	if Button then
		local Leave = Button:FindFirstChild("Leave")
		if Leave then
			Leave.MouseButton1Click:Connect(function()
				if CanLeave then
					Lobby:FireServer()
					Tips.Text = "Going back to lobby..."
					Buy.Active = false
					Leave.Active = false
					Caption()
				else
					CanLeave = true
					Tips.Text = "Click again to Leave"
					Caption()
					task.delay(3, function()
						CanLeave = false
						Tips.Text = ""
					end)
				end
			end)
		end
		local Buy = Button:FindFirstChild("Buy")
		if Buy then
			Buy.MouseButton1Click:Connect(function()
				local MainData = require(ReplicatedStorage:FindFirstChild("ReplicaDataModule"))
				local Data = MainData.players[Player]
				
				local ShopData = RequestShop:InvokeServer()
				local Categories = {"Daily", "Featured", "Seasonal", "Collab", "Visions"}
				
				for _, Category in ipairs(Categories) do
					local Items = ShopData[Category]
					if Items and #Items > 0 then
						for _, Item in ipairs(Items) do
							if Item and Item.Id then
								local KnobsData = Data.data.Knobs
								PurchaseShopItem:InvokeServer(Item.Id)
								Tips.Text = "Purchased: "..Item.Id
								Caption()
								task.wait()
							end
						end
					end
				end
				
				task.delay(3, function()
					Tips.Text = ""
				end)
			end)
		end
	end
	task.spawn(function()
		while true do
			task.wait(100)
			local Pos = Vector2.new(math.random(100, 500), math.random(100, 300))
			task.spawn(function()
				if UserInputService.TouchEnabled then
					VirtualInputManager:SendInputEvent({
						Position = Pos,
						KeyCode = Enum.KeyCode.ButtonA,
						UserInputState = Enum.UserInputState.Begin,
						UserInputType = Enum.UserInputType.Touch
					})
					task.wait(0.1)
					VirtualInputManager:SendInputEvent({
						Position = Pos,
						KeyCode = Enum.KeyCode.ButtonA,
						UserInputState = Enum.UserInputState.End,
						UserInputType = Enum.UserInputType.Touch
					})
				else
					VirtualUser:ClickButton2(Pos)
				end
			end)
		end
	end)
	
	local function Handle(Character)
		if not Character:GetAttribute("CalculatedKnobs") then
			Statistics:FireServer()
			replicatesignal(Player.Kill)
			Count = Count + 1
		elseif not Character then
			Player.CharacterAdded:Wait()
			Statistics:FireServer()
			replicatesignal(Player.Kill)
			Count = Count + 1
		else
			replicatesignal(Player.Kill)
			Count = Count + 1
		end
	end

	if Player.Character then
		Handle(Player.Character)
	else
		Player.CharacterAdded:Wait()
		Handle(Player.Character)
	end
	Player.CharacterAdded:Connect(Handle)
	for _, Map in pairs(workspace:GetChildren()) do
		if not Map:IsA("Terrain") and not Map:IsA("SpawnLocation") and Map ~= Player.Character then
			Map:Destroy()
		end
	end
	workspace.SpawnLocation.Size = Vector3.new(100, 1, 100)
	workspace.SpawnLocation.CanCollide = true
	Player.PlayerGui:Destroy()
end
if game.placeId == 6516141723 then
	CreateElevator:FireServer({
		Mods = {
			"NoGuidingLight", "ScreechFast", "RushFaster", "BackdoorVacuum",
			"BackdoorRush", "BackdoorLookman", "NoKeySound","LeastHidingSpots",
			"EyesFour", "ItemSpawnNone", "RushMore", "EntitiesMoster","DupeMore",
			"FiredampMost"
		},
		Settings = {},
		Destination = "Mines",
		FriendsOnly = true,
		MaxPlayers = "1"
	})
	
elseif game.placeId == 6839171747 then
	Enable()
else
	Player:Kick("You are not in DOORS")
end