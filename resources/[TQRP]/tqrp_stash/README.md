# monster_vault
 Vault Script By Monster TaerAttO Please credit me. This Script for ESX Framework

 # Vault Box

### Requirements
------------
The following dependencys are required for this script to operate successfully without issues. please ensure you have them started in your resources and working correctly before hand.

- [tqrp_addonaccount](https://github.com/ESX-Org/tqrp_addonaccount)
- [tqrp_addoninventory](https://github.com/ESX-Org/tqrp_addoninventory)
- [tqrp_datastore](https://github.com/ESX-Org/tqrp_datastore)
- [tqrp_inventoryhud 2.3+](https://github.com/Trsak/tqrp_inventoryhud)

## addons that are supported
- [tqrp_inventoryhud-trunk](https://forum.fivem.net/t/addon-esx-inventory-hud-vehicle-trunk/458152)
# Works with 
- [tqrp_inventoryhud]--modified for shops (https://forum.fivem.net/t/inventoryhud-shops/685775)
### Features

-Vault Box inventory

### Intergrating Inventorys Tutorial

To enable the inventory hud to work correctly with Motels you will need to add the files from the tqrp_inventoryhud/client/vault.lua folder to the Inventory Hud
and move them to the following folder

"tqrp_inventoryhud/client"

Secondly we need to load these files from the Inventory Hud resource within tqrp_inventoryhud open the __resource.lua file and add the following lines in the client_scripts section

```
"client/vault.lua",
```

The end result would look something similar to

```
client_scripts {
  "@es_extended/locale.lua",
  "client/main.lua",
  "client/trunk.lua",
  "client/property.lua",
  "client/vault.lua", -- Add this By TaerAttO
  "client/player.lua",
  "locales/en.lua",
  "config.lua"
}
```

We now need to adjust the Javascript files for inventory hud, to allow the loading of the Inventorys successfully
Open tqrp_inventoryhud/html/js/inventory.js

### Search for

```
        if (type === "normal") {
            $(".info-div").hide();
        } else if (type === "trunk") {
            $(".info-div").show();
        } else if (type === "property") {
            $(".info-div").hide();
        } else if (type === "player") {
            $(".info-div").show();
        }
```

### And replace with

```
        if (type === "normal") {
            $(".info-div").hide();
        } else if (type === "trunk") {
            $(".info-div").show();
        } else if (type === "property") {
            $(".info-div").hide();
        } else if (type === "vault") {
            $(".info-div").show(); -- edit from hide() to show() on this version by TaerAttO 
        } else if (type === "player") {
            $(".info-div").show();
        }
```

### Then further down the file search for the following

```
$('#playerInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/TakeFromProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });
```

### and replace with

```
$('#playerInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/TakeFromProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "vault" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/TakeFromVault", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });
```

### A few more lines down search for

```
$('#otherInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/PutIntoProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/PutIntoPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });
```

### And replace with

```
$('#otherInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/PutIntoProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "vault" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/PutIntoVault", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://tqrp_inventoryhud/PutIntoPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });
```

In your server.cfg file 

```
start monster_vault
```

And restart your server, you should then be able to use the resource

