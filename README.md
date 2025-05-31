# pf2e_template

A typst template for writing pathfinder 2nd edition documents

## Usage

Starts with dropping the package's folder in your project's directory and importing the package

<!--
```typst
#import "@preview/pf2e:1.0.0" : *
```
-->

```typst
#import "pf2e_template/lib.typ": *
```

Afterwards, if you want to write a full document, you can set the template. You do not have to if you only wanted the stats block.

```typst
#show: it => pf2e(
  it,
  title: "",
  subtitle: "",
  authors: (),
  content_table: true,
  title_page: true,
  columns: 1,
)
```

### Template Parameters

- `title`: `str` or `content`, the title of your document.
- `subtitle`: `str` or `content`, the subtitle of your document.
- `authors`: list of `str` or `content`, the authors of your document.
- `content_table`: if set to `true`, will generate a table of content after the title page.
- `title_page`: will generate a title page based on the precedent information if set to `true`, or not if set to `false`. If passed `content`, will use that content as the title page.
- `columns`: `int`, the default number of columns in the document.
- `theme`: modify this with the `theme()` function if you want to change font, colors and other details in the document.
- `mk_reg`: modify this if you want to register more _make_ functions.

## `banner()` Function

The `banner()` function creates a banner at the top of the page. By default, only headers in a banner appears in the outline.

### `banner()` Parameters

- `body`: `content`
- `theme`: `theme` object to change the theme of the banner.

## Actions

There are shortcuts to add the actions glyph to your document.

- 1 action: `#a`
- 2 actions: `#aa`
- 3 actions: `#aaa`
- reaction: `#r`
- free action: `#f`

There is also a show rule that applies to the same symbol written between colons. For example, 1 action can be written as `#a` or `:a:` in text. In code, only `a` works.

## Utility Functions

There are a couple of utility functions.

- `hr()` and `vr()`: creates an horizontal and vertical line, respectively.
- `split_args(..args, f)`: takes an array of array or strings, and split every comma separated value. Useful for things like traits. Optionally takes a function that maps all the resulting values.
- `straight(body)`: removes any hanging indent.
- `hang(body)`: adds a hanging indent.
- `clean_list(arr)`: removes duplicate and empty value from an array.

## `itembox()` Function

The `itembox()` function takes care of the layout for items, feats, spells, creatures and the likes. While using this function works, there is a better way to create your stats block by using objects and make function.

```typst
#itembox(
    "Item Name",
    actions: a,
    kind: "Item",
    level: 4,
    traits: "uncommon, magical, other traits",
)[
    Item Description
]
```

### `itembox()` Parameters

- `name`: `str` or `content`, the name that will be shown on the top left. Mandatory.
- `body`: `content`, everything that goes after the traits.
- `actions`: `content` or `none`, the actions are shown after the name.
- `kind`: `str` or `content`, the type of stat block, show at the top right before the level.
- `level`: `int` or `content`, the level of the stat block
- `traits`: `array` or `str`. Traits of the stat block. Accept a string of comma separated trait, or an array of strings.
- `size`: `relative`, if you, for some reason, wants to change the width of the stat block. By default it uses the full width.
- `breakable`: `bool`, can this block be broken across pages.
- `hanging`: `bool`, should the paragraph in the body have a hanging indent by default.
- `theme`: `theme()`, to change the theme of the stat block.

## `feature()` Function

`feature()` is used to create only the top part of an itembox. As the name suggest, it is mostly used for class features.

### `feature()` Parameters

- `name`: `str` or `content`, the name that will be shown on the left. Mandatory.
- `level`: `int` or `content`, the level that will be show on the right. Mandatory.
- `actions`: `content` or `none`, the actions are shown after the name.
- `theme`: `theme()`, to change the theme.

## `notebox()` Function

Creates a shaded box with a border to add extra context to your document.

### `notebox()` Parameters

- `body`: `content`
- `theme`: `theme()` to change the theme of the box

## `rulebox()` Function

Creates a small shaded box to put emphasis or precision on a rule.

## `rulebox()` Parameters

- `body`: `content`
- `theme`: `theme()` to change the theme of the box

## `infobox()` Function

Creates a box similar to the one used for key ability and hit points in class description. Can take any number of bodies, and separates them with a vertical line.

### `infobox()` Parameters

- `..body`: `..content`
- `theme`: `theme()` to change the theme of the box

## `sidebar()` Function

Creates a two columns section with the first column taking two third and the second taking the last third. Used in ancestries and classes definition.

### `sidebar()` Parameters

- `body`: `content`, body of the large column.
- `bar_body`: `content`, body of the small column.

## Objects and Make Functions

Objects and make functions separates the data of a stat block such as an item or creature, and the creation of the block.

They allow a uniform format across all statblocks and better control of the data, such as filtering and sorting.

There is multiple type of objects included in this module and each are created with a _new_ function and is associated with its own _make function_, which takes the data and creates the statblock.

There is a generic make function, `mk()`, which takes the object and call the appropriate make function. 

All make function take these four parameters:

- `object`: the object to make the stats block for. Mandatory.
- `breakable`: `bool`, wether the resulting stats block can be broken across pages.
- `short`: `array` or `bool`, a list of attacks, abilities, activations and other entries that will be shown in short form. If given the value `true`, every entry will be in short form. Default `()`. (Currently only implemented for activations and abilities)
- `hide`: `array`, similar to `short`, but the entries in this list will not be shown in the stat block. Default `()`. (Currently not implemented)

### Items

Items are for all sorts of mundane and magical items. Can be created with `new_item`and its associated make function is `mk_item()`

- `name`: `str` or `content`, the name of the object. Mandatory. Positional Argument.
- `body`: `content`, the description of the object. Mandatory. Positional Argument.
- `level`: `int`, the level of the item. Default `none`.
- `plus`: `bool`, decides if a '+' symbols should be shown after the level. Default `false`.
- `kind`: `str` or `content`, the type of statblock. Default `"Item"`.
- `variant`: `str` or `content`, shows the value in parenthesis after the name. Default `none`.
- `traits`: `str` or `array`, the traits of the items. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `price`: `number`, the price, in gp, of the item. Default `none`.
- `bulk`: `int` `none` or `L`, the bulk of the item. The special value `L` can be used. Default `none`.
- `usage`: `str` or `content`, the usage of the item. Default `none`.
- `activate`: `str` or `content`, the actions and traits it takes to activate the item. Default `none`.
- `dc`: `int`, the DC of the item's check. Automatically calculates the check bonus. Default `none`.
- `hardness`: `int`, the hardness of the item. Default `none`.
- `hp`: `int`, the HP of the object. Automatically calculates the BT. Default `none`.
- `requirements`: `str` or `content`, any requirements the item has. Default `none`.
- `runes`: `str` or `array`, any runes the item has. Default `()`.
- `others`: `dict`, dictionary of other entry to add in the upper part of the item's description. Format is `(EntryName: entry_value)`. Default `(:)`
- `notes`: `dict`, optional additional information to entry in the upper part of the item's description. Format is `(entry_name: notes)`. Not every entry supports notes. For those who does, the notes will appear in parenthesis after. Default `(:)`.
- `craft_requirements`: `str` or `content`, the crafting requirements of the item, if any. Is shown after the body, but in the same block. Default `none`.
- `activations`: `array`, list of activation objects. Are shown after crafting requirements in the same block. Default `()`.
- `spell_lists`: `array`, list of spell_list objects. Used for items that can cast spell like staves. Shown after activations in a different block. Default `()`.
- `after`: `str` or `content`, block of text shown after `spell_lists` in a different block. Default `none`.
- `variants`: `array`, list of variant objects for this item. Shown at the end, each in a different block. Default `()`.
- `runes`: `array`, list of runes on this object
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Activations

Lots of items can be activated and those activations can be represented with an object created with the `new_activation()` function. It's associated make function is `mk_activation()`.

- `name`: `str` or `content`, the name of the object. Mandatory. Positional Argument.
- `body`: `content`, the description of the object. Mandatory. Positional Argument.
- `actions`: `content`, the actions it takes to use this activation. Default `a`.
- `traits`: `str` or `array`, the traits of the activation. Default `()`.
- `frequency`: `str` or `content`, the frequency at which this activation can be used. Default `none`.
- `trigger`: `str` or `content`, the trigger of this activation, if any. Default `none`.
- `prerequisites`: `str` or `content`, the prerequisites of this activation, if any. Default `none`.
- `requirements`: `str` or `content`,  the requirements of this activation, if any. Default `none`.
- `duration`: `str` or `content`,  the duration of this activation, if any. Default `none`.
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Variants

Lots of items have variants, such as the Elixir of Life, which can be lesser, greater or major. These variants are represented by an object created with the `new_variant()` function. Its associated make function is `mk_variant()`.

- `name`: `str`, `int` or `content`, the name of the object. If given a number, the entry will be shown as **Rank**. If the name is in the `Item.grades` enumeration, the entry will be shown as **Grade**. Mandatory. Positional Argument.
- `body`: `content`, the description of the object. Mandatory. Positional Argument.
- `level`: `int`, the level of the variant. Default `none`.
- `price`: `number`, the price of the variant in gp. Default `none`.
- `bulk`: `int` `none` or `L`, the bulk of the item. The special value `L` can be used. Default `none`.
- `usage`: `str` or `content`, the usage of the variant, if different. Default `none`.
- `dc`: `int`, the dc of the variant, if any. Default `none`.
- `ac`: `int`, the AC of the variant, if any. Default `none`.
- `hardness`: `int`, the hardness of the variant. Default `none`.
- `hp`: `int`, the HP of the variant. Default `none`.
- `craft_requirements`: `str` or `content`, the crafting requirements, if any. Default `none`.
- `others`: `dict`, other entry to be added. Default `(:)`
- `notes`: `dict`, notes. Works the same as for items. Default `(:)`
- `activations`: `array` of activation object, list of the variant's activations. Default to `()`.
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Armors

Armors are a type of items, and as such they can take all of the parameter of items, plus a few more. They are created with `new_armor()` and the associated make function is `mk_armor()`.

- `ac_bonus`: `int`. Default `none`.
- `dex_cap`: `int`. Default `none`.
- `check_penalty`: `int`. Default `none`.
- `speed_penalty`: `int`. Default `none`.
- `group`: `str` or `content`, the critical specialization group of the armor. The `Armor.groups` enumeration can be used. Default `none`.
- `proficiency`: `str` or `content`, the armor's proficiency group. The `Armor.proficiencies` enumeration can be used. Default `none`.
- `strength`: `int`, the minimal strength required to reduce the armor's penalty. Default `none`.
- `save_bonus`: `int`, the armor's bonus to all saving throw, if any. Most likely due to a Resilient rune. Default `none`.
- `runes`: `array`, list of runes on this object
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Shields

Shields are a type of items, and as such they can take all of the parameter of items, plus a few more. They are created with `new_shield()` and the associated make function is `mk_shield()`.

- `ac_bonus`: `int`. Default `none`.
- `speed_penalty`: `int`. Default `none`.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Staves and Wands

Staff and Wand objects are a type of items and have the same parameters. They do not add any new parameters, but they automate some of the layout, such as adding the activation and the appropriate trait. They are created with the `new_staff()` and `new_wand()` function, and their associated make functions are `mk_staff()` and `mk_wand()` respectively.

### Weapons

Weapons are a type of items, and as such they can take all of the parameter of items, plus a few more. They are created with `new_weapon()` and the associated make function is `mk_weapon()`.

- `damage`: `int`, the size of the damage die of the weapon. Default `none`.
- `n_dice`: `int`, the number of damage dices of the weapon. Default `1`.
- `damage_type`: `str` or `content`, the damage type of the weapon. The `Weapon.damages` enumeration can be used. Default `none`.
- `atk_bonus`: `int`, the item bonus to attack roll of the weapon, such as the one given by a potency rune. Default `none`.
- `hands`: `int` or `content`, the number of hands it takes to wield the weapon. The `Weapon.hands` enumeration can be used. Default `none`.
- `type`: `str` or `content`, the type of the weapon, either "melee" or "ranged". The `Weapon.types` enumeration can be used. Default `none`.
- `category`: `str` or `content`, the category of the weapon, either "simple", "martial" or "advanced". The `Weapon.categories` enumeration can be used. Default `none`.
- `group`: `str` or `content`, the weapon's group. The `Weapon.groups` enumeration can be used. Default `none`.
- `range`: `int`, the range increment of the weapon in feet, if any. Default `none`.
- `reload`: `int`, the number of action it takes to reload the weapon, if any. Default `none`.
- `ammo`: `str` or `content`, the type of ammunition the weapon uses, if any. Default `none`.
- `ammo_price`: `number`, the price of an ammunition for this weapon. Default `none`.
- `ammo_bulk`: `int` or `L`, the bulk of an ammunition for this weapon. Default `none`.
- `configurations`: `array`, list of `configuration` objects representing combination weapon's configurations
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Configurations
Represents a single configuration, with damage die, group and traits for that configuration. Can be created with `new_configuration()`

- `name`: `str` or `content`, special name for the configuration. Default to `none`.
- `traits`: `str` or `array`, the traits of the configuration. Default `()`.
- `body`: `str` or `content`, optional description and effect of the configuration. Default to `none`
- `damage`: `int`, the damage die of the configuration. Default to `none`.
- `damage_type`: `str` or `content`, the damage type of the configuration. The `Weapon.damages` enumeration can be used. Default `none`.
- `n_dice`: `int`, the number of damage dices of the configuration. Default `1`.
- `type`: `str` or `content`, the type of the configuration, either "melee" or "ranged". The `Weapon.types` enumeration can be used. Default `none`. Will be used to identify the configuration if no name is specified.
- `group`: `str` or `content`, the configuration's group. The `Weapon.groups` enumeration can be used. Default `none`.
- `range`: `int`, the range increment of the configuration in feet, if any. Default `none`.
- `reload`: `int`, the number of action it takes to reload the configuration, if any. Default `none`.
- `ammo`: `str` or `content`, the type of ammunition the configuration uses, if any. Default `none`.
- `ammo_price`: `number`, the price of an ammunition for this configuration. Default `none`.
- `ammo_bulk`: `int` or `L`, the bulk of an ammunition for this configuration. Default `none`.
- `hands`: `int` or `content`, the number of hands it takes to wield the configuration. The `Weapon.hands` enumeration can be used. Default `none`.
- `activations`: `array` of activation object, list of the configuration special activations. Default to `()`.
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Feats

Feats can be created with the `new_feat()` function and its associated make function is `mk_feat()`.

- `name`: `str` or `content`, the name of the object. Mandatory. Positional Argument.
- `body`: `content`, the description of the object. Mandatory. Positional Argument.
- `level`: `int`, the level of the feat. Default `none`.
- `kind`: `str` or `content`, the kind of statblock. Default `"Feat"`.
- `actions`: `content`, the amount of action it takes to use this feat. Default `none`.
- `traits`: `str` or `array`, the traits of the feat. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `prerequisites`: `str` or `content`, prerequisites to take this feat, if any. Default `none`.
- `requirements`: `str` or `content`, requirements to use this feat, if any. Default `none`.
- `trigger`: `str` or `content`, trigger to use this feat, if any. Default `none`.
- `frequency`: `str` or `content`, the frequency at which this feat can be used, if any. Default `none`.
- `others`: `dict`, dictionary of other entry to add in the upper part of the feat's description. Format is `(EntryName: entry_value)`. Default `(:)`.
- `special`: `str` or `content`, special entry at the end of the feat's description. Default `none`.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Spells

Spells can be created with the `new_spell()` function and its associated make function is `mk_spell()`.

- `name`: `str` or `content`, the name of the object. Mandatory. Positional Argument.
- `body`: `content`, the description of the object. Mandatory. Positional Argument.
- `rank`: `int`, the rank of the spell. Default `none`.
- `kind`: `str` or `content`, the kind of statblock. Usually `"Spell"` or `"Focus"`. The `Spell.kinds` enumeration can be used. Default `"Spell"`.
- `actions`: `content`, the amount of action it takes to cast this spell. Default `none`.
- `traits`: `str` or `array`, the traits of the spell. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `prerequisites`: `str` or `content`, prerequisites to take this spell, if any. Default `none`.
- `requirements`: `str` or `content`, requirements to cast this spell, if any. Default `none`.
- `trigger`: `str` or `content`, trigger to cast this spell, if any. Default `none`.
- `duration`: `str` or `content`, the duration of the spell, if any. Default `none`.
- `range`: `str` or `content`, the range of the spell, if any. Default `none`.
- `target`: `str` or `content`, the target of the spell, if any. Default `none`.
- `defense`: `str` or `content`, the defense against the spell, usually a saving throw. Default `none`.
- `area`: `str` or `content`, the area of the spell, if any. Default `none`.
- `locus`: `str` or `content`, the locus required to cast the spell, if any. Default `none`.
- `cost`: `str` or `content`, the cost required to cast the spell, if any. Default `none`.
- `traditions`: `array`, list of the tradition that have access to this spell. The `Spell.traditions` enumeration can be used. Default `()`.
- `spell_lists`: `array`, list of other spell lists, such as class specific, that have access to this spell. Default `()`.
- `others`: `dict`, dictionary of other entry to add in the upper part of the spell's description. Format is `(EntryName: entry_value)`. Default `(:)`.
- `heightened`: `dict`, dictionary containing the information of the heightened spell for the entries after the description. Format is `("rank or +n": content)`. Default `(:)`.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Creatures

Creatures can be created with the `new_creature()` function and its associated make function is `mk_creature()`.

- `name`: `str` or `content`, the name of the creature. Mandatory. Positional Argument.
- `description`: `content`, the description of the creature. Mandatory. Positional Argument.
- `level`: `int`, the level of the creature. Default `none`.
- `kind`: `str` or `content`, the kind of statblock. Default `"Creature"`.
- `traits`: `str` or `array`, the traits of the creature. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `family`: , the creature family of this creature. Not shown but can be used for filtering.
- `size`: `str`, the size of the creature. The `Creature.sizes` enumeration can be used. Default `none`.
- `perception`: `int`, Default `0`.
- `senses`: `array`, list of the special senses of the creature. Default `()`.
- `languages`: `array`, list of the languages spoken by the creature. Default `()`.
- `skills`: `dict`, dictionary of the skill bonuses of the creature. Format is `(SkillName: bonus)`. Default `(:)`.
- `strength`: `int`, Default `0`.
- `dexterity`: `int`, Default `0`.
- `constitution`: `int`, Default `0`.
- `intelligence`: `int`, Default `0`.
- `wisdom`: `int`, Default `0`.
- `charisma`: `int`, Default `0`.
- `items`: `array`, list of the items transported, wielded or worn by this creature. Default `()`.
- `ac`: `int`, Default `0`.
- `fortitude`: `int`, Default `0`.
- `reflex`: `int`, Default `0`.
- `will`: `int`, Default `0`.
- `hp`: `int`, Default `0`.
- `hardness`: `int`, Default `0`.
- `resistances`: `dict`, dictionary of the resistance values for this creature. Format is `(damage_type: value)`. Default `(:)`.
- `weaknesses`: `dict`, dictionary of the weakness values for this creature. Format is `(damage_type: value)`. Default `(:)`.
- `immunities`: `array`, list of all immunities for this creature. Default `()`.
- `speed`: `int` or `dict`, the speeds of the creature. If given only a number, will show it. If given a dictionary with the format `(speed_type: value)`, will show all of the speeds. Use `land` or `walk` for the key of the regular speed. Default `(:)`.
- `attacks`: `array`, list of attack objects that represent all of the creature's standard Strikes. Default `()`.
- `abilities`: `array`, list of ability objects that represent all of the creature's special abilities. Default `()`.
- `spellcastings`: `array`, list of spellcasting objects that represent all of the creature's spellcasting abilities. Default `()`.
- `dc`: `int`, common DC for the creature's ability. Default `none`.
- `others`: `dict`, dictionary of other entry to add in the general section of the statblock. Format is `(EntryName: entry_value)`. Default `(:)`.
- `notes`: `dict`, notes for this creature's properties. You can give notes to a specific resistance, weakness, immunity or speed by giving a dictionary using the resistance, weakness, immunity or speed name as the key. Ex: `notes: (resistances: (slashing: [Except from adamantine]))`. Default `(:)`.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `feats`: `array`, list of extra feats this creature has
- `specials`: `array`, list of other features the creature has (such as weapon specialization). Default `()`.
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Attacks

Attack objects represent a creature's basic Strikes. They can be created with the `new_attack()` function and the associated make function is `mk_attack()`.

- `name`: `str` or `content`, the name of the attack. Mandatory. Positional Argument.
- `damage`: `str` or `content`, the damage and effect of the attack. Mandatory. Positional Argument.
- `bonus`: `int`, the bonus to the attack roll for this attack. Default `0`.
- `traits`: `str` or `array`, the traits of the attack. Default `()`.
- `type`: `str`, the weapon type, either melee or ranged, of the attack. The `Weapon.types` enumeration can be used. Default `"Melee"`.
- `actions`: `content`, the actions it takes to use this attack. Default `a`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Abilities

Ability objects represent a creature's special abilities. They can be created with the `new_ability()` function and the associated make function is `mk_ability()`.

- `name`: `str` or `content`, the name of the object. Mandatory. Positional Argument.
- `body`: `content`, the ability's effect. Mandatory. Positional Argument.
- `actions`: `content`, the amount of action it takes to use this ability. Default `none`.
- `traits`: `str` or `array`, the traits of the ability. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `category`: `str`, either `"general"`, `"defensive"` or `"offensive"`. Changes in which section the ability appears. The `Creature.ability.categories` enumeration can be used. Default `"general"`.
- `prerequisites`: `str` or `content`, prerequisites to take this ability, if any. Default `none`.
- `requirements`: `str` or `content`, requirements to use this ability, if any. Default `none`.
- `trigger`: `str` or `content`, trigger to use this ability, if any. Default `none`.
- `duration`: `str` or `content`, the duration of the ability, if any. Default `none`.
- `range`: `str` or `content`, the range of the ability, if any. Default `none`.
- `target`: `str` or `content`, the target of the ability, if any. Default `none`.
- `defense`: `str` or `content`, the defense against the ability, usually a saving throw. Default `none`.
- `area`: `str` or `content`, the area of the ability, if any. Default `none`.
- `frequency`: `str` or `content`, the frequency at which the ability can be used, if any. Default `none`.
- `others`: `dict`, dictionary of other entry to add before the ability's effect. Format is `(EntryName: entry_value)`. Default `(:)`.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Spellcasting

Ability objects represent a creature's ability to cast spells. They can be created with the `new_spellcasting()` function and the associated make function is `mk_spellcasting()`.

- `tradition`: `str` or `content`, the spellcasting tradition. The `Spell.traditions`enumeration can be used. Default `none`.
- `type`: `str` or `content`, the type of the spellcasting (spontaneous, focus, prepared, etc). The `Spell.types` enumeration can be used. Default `none`.
- `note`: `content`, additional info that will be shown in parenthesis with the tradition and type. Default `none`.
- `dc`: `int`, the spellcasting DC. The spellcasting modifier is automatically calculated. Default `10`.
- `focus`: `int`, the amount of focus point available for this spellcasting. Default `none`.
- `spell_lists`: `array`, list of spell list objects. Default `()`.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Spell List

A spell list object is just a collection of spells at a certain rank. They can be created with the `new_spell_list()` function and the associated make function is `mk_spell_list()`

- `rank`: `int`, the rank of the spells. `0` for cantrips. Default `0`.
- `slots`: `int`, number of spell slots for this list, for spontaneous casting. Default `none`.
- `heightened`: `int`, for cantrip, the rank at which they are heightened. Will calculate automatically based on the creature's level if set to `auto`. Default `auto`.
- `notes`: `dict`, notes for specific spells. Default `(:)`.
- `..spells`: `array`, list of spell name.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Hazards

Hazards can be created with the `new_hazard()` function and its associated make function is `mk_hazard()`.

- `name`: `str` or `content`, the name of the hazard. Mandatory. Positional Argument.
- `description`: `content`, the description of the hazard. Default `none`.
- `level`: `int`, the level of the hazard. Default `none`.
- `kind`: `str` or `content`, the kind of statblock. Default `"Hazard"`.
- `traits`: `str` or `array`, the traits of the hazard. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `stealth`: `int`, the stealth modifier of the hazard. Default `none`.
- `disable`: `content`, what it takes to disable the hazard. Default `none`.
- `ac`: `int`, Default `0`.
- `saves`: `dict`, dictionary of the saving throw of the hazard. Format is `(save: modifier)`. Default `(:)`.
- `hp`: `int`, Default `0`.
- `hardness`: `int`, Default `0`.
- `resistances`: `dict`, dictionary of the resistance values for this hazard. Format is `(damage_type: value)`. Default `(:)`.
- `weaknesses`: `dict`, dictionary of the weakness values for this hazard. Format is `(damage_type: value)`. Default `(:)`.
- `immunities`: `array`, list of all immunities for this hazard. Default `()`.
- `action`: `activation`, the action that triggers the hazard, usually a reaction or free action. Default `none`.
- `routine`: `content`, the routine of the hazard. Default `none`.
- `reset`: `content`, what it takes to reset the hazard, if it can be reset. Default `none`.
- `activations`: `array`, list of actions the hazard can take. Each action takes the form of an activation object. Default `()`.
- `others`: `dict`, dictionary of other entry to add in the upper part of the hazard's description. Format is `(EntryName: entry_value)`. Default `(:)`
- `notes`: `dict`, notes for the hazard entries. Default `(:)`
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Backgrounds

Backgrounds can be created with the `new_background()` function and its associated make function is `mk_background()`.

- `name`: `str` or `content`, the name of the background. Mandatory. Positional Argument.
- `body`: `content`, the description of the background. Mandatory. Positional Argument.
- `level`: `int`, the level of the background. Default `none`.
- `kind`: `str` or `content`, the kind of statblock. Default `"Background"`.
- `traits`: `str` or `array`, the traits of the background. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Heritages

Heritages can be created with the `new_heritage()` function and its associated make function is `mk_heritage()`.

- `name`: `str` or `content`, the name of the heritage. Mandatory. Positional Argument.
- `body`: `content`, the description of the heritage. Mandatory. Positional Argument.
- `traits`: `str` or `array`, the traits of the heritage. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `addons`: `array`, list of additional components that are associated with the heritage but do not need to be on the same page, like actions. Default `()`.
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Obstacles

Obstacles can be created with the `new_obstacle()` function and its associated make function is `mk_obstacle()`.

- `name`: `str` or `content`, the name of the obstacle. Mandatory. Positional Argument.
- `body`: `content`, the description of the obstacle. Mandatory. Positional Argument.
- `level`: `int`, the level of the obstacle. Default `none`.
- `kind`: `str` or `content`, the kind of statblock. Default `"Obstacle"`.
- `traits`: `str` or `array`, the traits of the obstacle. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `vp`: `int`, the amount of victory points one needs to overcome this obstacle. Default `none`.
- `vp_title`: `content`, changes the name of the VP entry. Default `none`.
- `disable`: `content`, what it takes to overcome the obstacle. Default `none`.
- `others`: `dict`, dictionary of other entry to add in the upper part of the obstacle's description. Format is `(EntryName: entry_value)`. Default `(:)`
- `url`: `str`, a link or url to other resources
- `extra`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.

### Settlement

Settlements can be created with the `new_settlement()` function and its associated make function is `mk_settlement()`.

- `name`: `str` or `content`, the name of the obstacle. Mandatory. Positional Argument.
- `body`: `content`, the description of the obstacle. Mandatory. Positional Argument.
- `level`: `int`, the level of the obstacle. Default `none`.
- `kind`: `str` or `content`, the kind of statblock. Default `"Obstacle"`.
- `traits`: `str` or `array`, the traits of the obstacle. Default `()`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `government`: `content`, overview of the government of the settlement. Default `none`.
- `population`: `content`, overview of the population of the settlement. Default `none`.
- `languages`: `content`, overview of the languages spoken in the settlement. Default `none`.
- `religions`: `content`, overview of the religions of the settlement. Default `none`.
- `threats`: `content`, overview of the threats the settlement faces. Default `none`.
- `npcs`: `dict`, dictionary of the important npcs of the settlement. Format is `("NPC's name": [npc's description])`
- `others`: `dict`, dictionary of other entry to add in the upper part of the obstacle's description. Format is `(EntryName: entry_value)`. Default `(:)`
- `url`: `str`, a link or url to other resources. Default `none`
- `extra`: `dict`, dictionary of extra data on this object. Default `(:)`
- `image`: `content`, image for this object. Default `none`.
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.


### Affliction
Afflictions can be created with the `new_affliction()` function and its associated make function is `mk_affliction()`. There is also a `mk_affliction_inline()` for the inline representation of the affliction.

- `name`: `str` or `content`, the name of the obstacle. Mandatory. Positional Argument.
- `level`: `int`, the level of the obstacle. Default `none`.
- `traits`: `str` or `array`, the traits of the obstacle. Default `()`.
- `save`: `str`, The saving throw against the affliction. Default `none`.
- `dc`: `int`, the DC of the affliction's saving throw. Default `none`.
- `max_duration`: `content`, maximum duration of the affliction. Default `none`.
- `stages`: `array`, list of stages for the affliction. Can be created with `new_stage()`. Default `()`.
- `kind`: `str` or `content`, the kind of statblock. Default `"Affliction"`.
- `onset`: `content`, onset of the affliction. Default: `none`.
- `tags`: `str` or `array`, list of tags. Tags are not shown but can be used to sort and categorize statblocks. Default `()`.
- `others`: `dict`, dictionary of other entry to add in the upper part of the obstacle's description. Format is `(EntryName: entry_value)`. Default `(:)`.
- `notes`: `dict`, notes for the hazard entries. Default `(:)`.
- `url`: `str`, a link or url to other resources. Default `none`
- `extras`: `dict`, dictionary of extra data on this object
- `image`: `content`, image for this object. Default `none`.
- `short_desc`: `content`, a short description of the object. Useful when creating tables. Default `none`.
- `description`: `content`, a longer description of the affliction. Default `[]`

## Enumerations
Here are the names and values for each enumeration

### Creature.sizes
- tiny
- small
- medium
- large
- huge
- gargantuan

### Creature.ability.categories
- general
- offensive
- defensive

### Armor.proficiencies
- unarmored
- light
- medium
- heavy

### Armor.groups
- cloth
- leather
- chain
- composite
- plate
- skeletal
- wood

### Item.grades
- minor
- lesser
- moderate
- greater
- major
- true

### Spell.traditions
- occult
- divine
- arcane
- primal

### Spell.types
- spontaneous
- prepared
- innate
- focus
- ritual

### Spell.kinds
- focus
- spell


### Weapon.categories
- simple
- martial
- advanced
- improvised
- unarmed

### Weapon.damages
- slashing
- piercing
- bludgeoning

### Weapon.groups
- axe
- bomb
- bow
- brawling
- club
- crossbow
- dart
- firearm
- flail
- hammer
- knife
- pick
- polearm
- shield
- sling
- spear
- sword

### Weapon.types
- ranged
- melee

### Weapons.hands
- zero
- one
- one_plus
- two

### Proficiencies
- untrained
- trained
- expert
- master
- legendary
- mythic

### Damages
- piercing
- slashing
- bludgeoning
- force
- acid
- cold
- electricity
- fire
- sonic
- spirit
- void
- vitality
- mental
- poison
- bleed
- precision

### Saves
- fortitude
- reflex
- will

### Skills
- acrobatics
- arcana
- athletics
- crafting
- deception
- diplomacy
- intimidation
- lore
- medicine
- nature
- occultism
- performance
- religion
- society
- stealth
- survival
- thievery