Config = {
  Locale      = 'en',
  Debug       = true,

  UseMLO    = true,
  UseDoors  = false,

  AllowHouseSales = true,               -- can players sell their house after purchase?
  SpawnOffset = vector3(0.0,0.0,0.0),   -- global house spawn offset (location + SpawnOffset) (use negative z-value to lower the shells position)
                                        -- note: if you already have houses spawned, I wouldn't go changing this. Will result in furniture dissappearing.

  WaitToRender = true,    -- might help reduce MS when you have lots of houses
  WaitToRenderTime = 3000, -- time to sleep between distance checks (if WaitToRender is true)

  -- FRAMEWORK
  UsingESX   = true,    -- Recommended, otherwise you have LOTS to change.
  UsingVSync = true,    -- Really only applies if you're using the modified vSync provided, else set false.

  -- SOUND FILE NOT SUPPLIED.
  UsingInteractSound = false,

  -- MENUS
  UsingESXMenu      = true,
  UsingNativeUI     = false,

  UseHouseInventory = true, -- if using the inventory inside of houses.

  -- ESX JARGON (IGNORE IF NOT USING ESX)
  -- Refer to this when you receive the error for line 118 in framework_functions.
  -- It means you either set UsingESX_V1.2.0 incorrectly, or you've set your account names incorrectly.
  ["UsingKashacters"]   = true,          -- are you using esx_kashacters?
  ["UsingESX_V1.2.0"]   = false,          -- self explainatory. True if newer aswell.
  ["BankAccountName"]   = "bank",
  ["DirtyAccountName"]  = "black_money",
  ["CashAccountName"]   = "money",        -- ignore if not using esx v.1.2 + 

  -- BLIPS/MARKERS/3DTEXT
  UseHelpText       = false,  -- if using HelpText (instead of 3DText).
  Use3DText         = true,   -- if using 3DText (instead of HelpText).
  UseMarkers        = false,  -- if you want markers.
  UseBlips          = false,   -- if you want blips.

  -- RENDER DISTANCE
  MarkerDistance    = 3.0,
  TextDistance3D    = 3.0,
  HelpTextDistance  = 2.0,
  InteractDistance  = 2.0,  

  -- Allow house owners to move their garage?
  AllowGarageMovement = false,

  -- MORTGAGE BS
  AllowMortgage = false,
  MortgagePercent = 10,
  MortgageMinRepayment = 10,

  -- BLIP COLORS/SPRITES
  UseZoneSprites    = false,  -- if you want to set the blip sprite by zone.
  UseZoneColoring   = false,  -- if you want to set the blip color by zone.

  BlipEmptyColor      = 1,     -- must be set regardless of option above.
  BlipOwnerColor      = 2,     -- must be set regardless of option above.
  BlipOwnedColor      = 3,     -- must be set regardless of option above.
  ZoneBlipColors      = {      -- set house blip colors based on zone. Optional.
    [9] = {
      EmptyColor  = 1,
      OwnerColor  = 2,
      OwnedColor  = 3,
    }, 
    [205] = {      
      EmptyColor  = 1,
      OwnerColor  = 2,
      OwnedColor  = 3,
    }
  },

  BlipEmptySprite   = 350,    -- must be set regardless of option above.
  BlipOwnerSprite   = 40,     -- must be set regardless of option above.
  BlipOwnedSprite   = 357,    -- must be set regardless of option above.
  ZoneBlipSprites   = {       -- set house blip colors sprites on zone. Optional.
    [9] = {
      EmptySprite  = 350,
      OwnerSprite  = 40,
      OwnedSprite  = 357,
    }, 
    [205] = {      
      EmptySprite  = 350,
      OwnerSprite  = 40,
      OwnedSprite  = 357,
    }
  },

  -- Marker colors and text color.
  MarkerSelection = 1,
  MarkerColors = {
    [1] = {r = 0, g = 255, b = 0, a = 155},
    [2] = {r = 255, g = 0, b = 0, a = 155},
    [3] = {r = 0, g = 0, b = 0, a = 155},
    [4] = {r = 0, g = 0, b = 255, a = 155},
    [5] = {r = 255, g = 255, b = 0, a = 155},
    [6] = {r = 0, g = 255, b = 255, a = 155},
    [7] = {r = 255, g = 255, b = 255, a = 155},
  },
  TextColors = {
    [1] = "~g~",
    [2] = "~r~",
    [3] = "~b~",
    [4] = "~o~",
    [5] = "~p~",
    [6] = "~y~",
    [7] = "~w~",
  },

  Controls = {
    Interact  = 38, -- Access most things.
    Accept    = 58, -- Accept/validate decision.
    Cancel    = 49, -- Cancel/discard deicsion.
    Furni     = 49, -- Furni UI.
  },

  HideOwnBlips    = true,    -- hide blips for players owned houses?
  HideSoldBlips   = true,    -- hide blips for other player houses?
  HideEmptyBlips  = true,    -- hide blips for empty houses/for sale houses?

  -- OWNER STUFF  
  RemoveFurniture  = true,  -- Remove all furniture on sale.
  RefundFurniture  = true,  -- Only if RemoveFurniture enabled.
  RefundPercent    = 50,    -- percent of price to refund for furniture.

  -- THEFT STUFF
  HouseTheft                = false,         -- can the player break into the house?
  GarageTheft               = false,         -- can the player break into garage?
  StoreStolenPlayerVehicles = false,        -- can players store other player vehicles at their house?
  LockpickRequired          = false,         -- does the player require a lockpick item to attempt to break in (garage AND house)?
  LockpickItem              = "thermal_charge",   -- lockpick item name.
  LockpickBreakOnFail       = false,         -- does the lockpick break if the minigame is failed?
  LockpickFailChance        = 5,            -- % failure chance, if not using minigames for lockpicking.
  LockpickTime              = 3,            -- seconds to lockpick, if not using minigames for lockpicking.

  UsingLockpickV1     = false,          -- if using MF_Lockpicking (free with this mod).
  UsingLockpickV2     = false,         -- if using MF_Lockpicking V2 (on modit.store). NOTE: Can only use either V1 or V2.
  UsingProgressBars   = false,         -- if not using either lockpicking versions, and want to use progress bars while performing lockpick animation.

  -- JOB STUFF
  CreateHouses = true, -- Can houses be created by jobs listed below?
  -- List a job like the example below to allow creation of houses.
  CreationJobs = {   
    police = {                        -- JOB NAME.
      minRank = 6,                    -- min rank to create house.
      society = false,                -- use society accounts?
      account = 'society_police',     -- society account name
      payCut  = 1,                    -- % of sale earnt by player, rest goes to realestate society account (if using esx_society, else goes nowhere).
    },
    realestateagent = {                    -- JOB NAME.
      minRank = 1,                    -- min rank to create house.
      society = false,                -- use society accounts?
      account = 'society_realestateagent', -- society account name
      payCut  = 1,                    -- % of sale earnt by player, rest goes to realestate society account (if using esx_society, else goes nowhere).
    }
  },

  PoliceCanRaid = true, -- Can houses be raided by jobs listed below?
  InventoryRaiding = true,
  -- These jobs also receive all notifications regarding police
  PoliceJobs = {
    police = {      -- JOB NAME
      minRank = 3,  -- min rank to raid house
    },
    police2 = {     -- JOB NAME
      minRank = 1,  -- min rank to raid house
    }
  },
}

mLibs = exports["meta_libs"]