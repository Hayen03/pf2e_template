#import "base.typ": *

#let split_number(n, group: 3, sep: ",") = {
  let parts = ()
  let count = 0
  while n > 0 {
    if count == group {
      parts.push(sep)
      count = 0
    } else {
      let d = calc.rem(n, 10)
      parts.push([#d])
      n = calc.trunc(n/10)
      count = count + 1
    }
  }
  parts.rev().join()
}

#let convert_price(amount) = {
  if not exists(amount) {
    return null
  }
  if type(amount) != int and type(amount) != float {
    return amount
  }
  let a = calc.abs(amount)
  let gp = calc.floor(a)
  let sp = calc.floor(calc.rem(a*10, 10))
  let cp = calc.floor(calc.rem(a*100, 10))
  if gp > 0 [#split_number(gp);gp]
  if sp > 0 [#sp;sp]
  if cp > 0 [#cp;cp]
  if gp == 0 and sp == 0 and cp == 0 {null}
}
#let convert_bulk(amount) = {
  if amount == "L" {
    "L"
  } else if type(amount) == int or type(amount) == float {
    let a = calc.abs(amount)
    if a == 0 {
      null
    } else if a < 1 {
      "L"
    } else {
      calc.floor(a)
    }
  } else if not exists(amount) {
    null
  } else {
    amount
  }
}
#let convert_modifier(amount, strong: false) = {
  if type(amount) == int or type(amount) == float {
    let a = calc.trunc(amount)
    if a == 0 and strong != true {
      null
    } else if a >= 0{
      [+#a]
    } else {
      [#a]
    }
  } else if not exists(amount) {
    null
  } else {
    amount
  }
}
#let convert_data(data) = {
  if data == none {null} else {data}
}
#let convert_rank(rank) = {
  if rank == 1 [1st]
  else if rank == 2 [2nd]
  else if rank == 3 [3rd]
  else if not exists(rank) {none}
  else [#rank;th]
}
#let list_traits(traits) = {
  let traits = clean_list(split_traits(traits))
  if not exists(traits) {
    return none
  } else {
    traits.join(", ")
  }
}
#let as_list(value) = {
  let t = type(value)
  if t == array {
    value
  }
  else if value == none {
    none
  }
  else {
    (value,)
  }
}

#let class_item = "item" // new
#let class_variant = "variant" // new
#let class_weapon = "weapon" // new
#let class_armor = "armor" // new
#let class_spell = "spell" // new
#let class_background = "background" // new
#let class_heritage = "heritage" // new
#let class_shield = "shield"
#let class_feat = "feat"
#let class_creature = "creature"
#let class_spell_list = "spell_list"
#let class_activation = "activation"
#let class_ability = "ability"
#let class_spellcasting = "spellcasting"
#let class_attack = "attack"

#let new_itembox(name, body, actions: none, kind: none, level: none, traits: none, size: 100%, breakable: false) = {
  return (name: name, body: body, actions: actions, kind: kind, level: level, traits: traits, size: size, breakable: breakable)
}
#let mk_itembox(src, theme: THEME) = {
  itembox(src.name, src.body, actions: src.actions, kind: src.kind, level: src.level, traits: src.traits, size: src.size, breakable: src.breakable, theme: theme)
}

#let item_grades = (
  minor: "Minor",
  lesser: "Lesser",
  moderate: "Moderate",
  greater: "Greater",
  major: "Major",
  "true": "True",
)
#let new_item(name, body, price: none, bulk: none, usage: none, activate: none, level: none, traits: (), variants: (), dc: none, short: none, variant: none, kind: "Item", plus: false, requirements: none, activations: (), others: (:), hardness: none, hp: none, notes: (:), breakable: false, tags:(), after: none) = (
  class: class_item,
  variant: variant,
  name: name,
  body: body,
  price: price,
  bulk: bulk,
  usage: usage,
  activate: activate,
  level: level,
  traits: clean_list(split_traits(traits)),
  variants: as_list(variants),
  dc: dc,
  short: short,
  kind: kind,
  plus: plus,
  requirements: requirements,
  activations: as_list(activations),
  others: others,
  hardness: hardness,
  hp: hp,
  notes: notes,
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  after: after,
)
#let new_activation(name: none, actions: a, traits: (), frequency: none, requirements: none, trigger: none, prerequisites: none, duration: none, body, notes: (:), tags:()) = (
  class: class_activation,
  name: name,
  actions: actions,
  traits: clean_list(split_traits(traits)),
  frequency: frequency,
  requirements: requirements,
  trigger: trigger,
  prerequisites: prerequisites,
  body: body,
  duration: duration,
  notes: notes,
  tags: clean_list(split_traits(tags)),
)
#let new_item_variant(name, body, dc:none, price: none, bulk: none, usage:none, level:none, short: none, hardness: none, hp: none, others: (:), notes: (:), tags: ()) = (
  class: class_variant,
  name: name,
  body: body,
  dc: dc,
  price: price,
  bulk: bulk,
  usage: usage,
  level: level,
  short: short,
  hardness: hardness,
  hp: hp,
  others: others,
  notes: notes,
  tags: clean_list(split_traits(tags)),
)
#let mk_activation(activation) = {
  let name = [Activation#if exists(activation.name) [---#activation.name]]
  let pre = (activation.actions,)
  let traits = list_traits(activation.traits)
  if exists(traits) {pre.push([(#traits)])}
  let body = ()
  if exists(activation.prerequisites) {body.push([*Prerequisites* #activation.prerequisites])}
  if exists(activation.requirements) {body.push([*Requirements* #activation.requirements])}
  if exists(activation.frequency) {body.push([*Frequency* #activation.frequency])}
  if exists(activation.duration) {body.push([*Duration* #activation.duration])}
  if exists(activation.trigger) {body.push([*Trigger* #activation.trigger])}
  if exists(activation.body) {body.push([#if body.len() > 0 [*Effect*] #activation.body])}
  body = body.filter(it => exists(it))
  [/ #name: #pre.filter(it => exists(it)).join(" ")#if not exists(activation.traits) and body.len() > 0 [;]#body.join("; ")]
}
#let mk_item_variant(variant) = {
  [
    #let bloc = ()
    #bloc.push((
      if not exists(variant.name) {none} else if type(variant.name) == int [*Rank* #convert_rank(variant.name)] else [*#if variant.name in item_grades.values() [Grade] else [Type]* #variant.name], 
      if not exists(variant.bulk) {none} else [*Bulk* #convert_bulk(variant.bulk)#if "bulk" in variant.notes [ (#variant.notes.bulk)]],
      if not exists(variant.price) {none} else [*Price* #convert_price(variant.price)#if "price" in variant.notes [ (#variant.notes.price)]],
      if not exists(variant.level) {none} else [*Level* #convert_data(variant.level)#if "level" in variant.notes [ (#variant.notes.level)]],
    ).filter(it => exists(it)).join("; "))
    #bloc.push((
      if variant.usage == none {none} else [*Usage* #variant.usage],
    ).filter(it => exists(it)).join("; "))
    #if exists(variant.dc) {bloc.push[*Check Bonus* #convert_modifier(variant.dc - 10) (DC #variant.dc)]}
    #bloc.push((
      if not exists(variant.hardness) {none} else [*Hardness* #variant.hardness#if "hardness" in variant.notes [ (#variant.notes.hardness)]],
      if not exists(variant.hp) {none} else [*HP(BT)* #variant.hp;(#{variant.hp/2})#if "hp" in variant.notes [ (#variant.notes.hp)]],
    ).filter(it => exists(it)).join("; "))
    #for other in variant.others.keys() {bloc.push[*#other* #variant.others.at(other)]}
    #bloc.push(variant.body)
    #bloc.filter(it => exists(it)).join(linebreak())
  ]
}
#let mk_item(item, theme: THEME, breakable: auto) = {
  itembox(
    [#item.name#if exists(item.variant) [ (#item.variant)]],
    kind: item.kind,
    level: [#item.level#if item.plus == true [+]],
    traits: item.traits,
    breakable: if breakable == auto {item.breakable} else {breakable},
    theme: theme,
  )[
    #let bloc = ()
    #if exists(item.price) {bloc.push[*Price* #convert_price(item.price)#if "price" in item.notes [ (#item.notes.price)]]}
    #bloc.push((
      if not exists(item.usage) {none} else [*Usage* #convert_data(item.usage)], 
      if not exists(item.bulk) {none} else [*Bulk* #convert_bulk(item.bulk)#if "bulk" in item.notes [ (#item.notes.bulk)]],
    ).filter(it => exists(it)).join("; "))
    #if exists(item.dc) {bloc.push[*Check Bonus* #convert_modifier(item.dc - 10) (DC #item.dc)#if "dc" in item.notes [ (#item.notes.dc)]]}
    #for key in item.others.keys() {bloc.push[*#key* #item.others.at(key)]}
    #if exists(item.activate) {bloc.push[*Activate*#item.activate]}
    #if exists(item.requirements) {bloc.push[*Requirements* #item.requirements]}
    #bloc.push((
      if exists(item.hardness) [*Hardness* #item.hardness#if "hardness" in item.notes [ (#item.notes.hardness)]] else {none},
      if exists(item.hp) [*HP(BT)* #item.hp;(#{item.hp/2})#if "hp" in item.notes [ (#item.notes.hp)]] else {none},
    ).filter(it => exists(it)).join("; "))
    #let bloc = bloc.filter(it => exists(it))
    #bloc.join(linebreak())
    #if bloc.len() > 0 {hr()}
    #item.body
    #if exists(item.activations) {item.activations.map(var => mk_activation(var)).join()}
    #if exists(item.after){
      hr()
      item.after
    }
    #if exists(item.variants) {
      hr()
      item.variants.map(var => mk_item_variant(var)).join(hr())
    }
  ]
}

#let weapon_type = (
  ranged: "Ranged",
  melee: "Melee",
)
#let weapon_category = (
  simple: "Simple",
  martial: "Martial",
  advanced: "Advanced",
)
#let weapon_group = (
  axe: "Axe",
  bomb: "Bomb",
  bow: "Bow",
  brawling: "Brawling",
  club: "Club",
  crossbow: "Crossbow",
  dart: "Dart",
  firearm: "Firearm",
  flail: "Flail",
  hammer: "Hammer",
  knife: "Knife",
  pick: "Pick",
  polearm: "Polearm",
  shield: "Shield",
  sling: "Sling",
  spear: "Spear",
  sword: "Sword",
)
#let weapon_damage = (
  slashing: "S",
  piercing: "P",
  bludgeoning: "B",
)
#let damage_types = (
  acid: "acid",
  bludgeoning: "bludgeoning",
  cold: "cold",
  electricity: "electricity",
  fire: "fire",
  force: "force",
  spirit: "spirit",
  vitality: "vitality",
  void: "void",
)
#let new_weapon(name, body, damage: none, bulk: none, hands: none, range: none, reload: none, type: none, category: none, group: none, ammo: none, traits: (), level: none, price: none, ammo_price: none, ammo_bulk: none, short: none, damage_type: none, base: none, hardness: none, hp: none, others: (:), dc: none, activations: (), plus: false, variants: (), notes: (:), breakable: false, tags: (), after: none, kind: "Item") = (
  class: class_weapon,
  name: name,
  body: body,
  damage: damage,
  bulk: bulk,
  hands: hands,
  range: range,
  reload: reload,
  type: type,
  category: category,
  group: group,
  ammo: ammo,
  traits: clean_list(split_traits(traits)),
  level: level,
  price: price,
  ammo_price: ammo_price,
  ammo_bulk: ammo_bulk,
  short: short,
  damage_type: damage_type,
  base: base,
  hardness: hardness,
  hp: hp,
  others: others,
  dc: dc,
  activations: as_list(activations),
  plus: plus,
  variants: as_list(variants),
  notes: notes,
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  after: after,
  kind: kind,
)
#let mk_weapon(weapon, theme: THEME, breakable: auto) = {
  itembox(
    weapon.name,
    kind: weapon.kind,
    level: [#weapon.level#if weapon.plus == true [+]],
    traits: weapon.traits,
    breakable: if breakable == auto {weapon.breakable} else {breakable},
    theme: theme,
  )[
    #let bloc = ()
    #bloc.push((
      if exists(weapon.base) [*Base Weapon* #weapon.base],
      [*Price* #convert_price(weapon.price)],
    ).filter(it => exists(it)).join("; "))
    #bloc.push((
      [*Damage* #if exists(weapon.damage) [1d#weapon.damage #if exists(weapon.damage_type) {weapon.damage_type}] else {null}],
      [*Bulk* #convert_bulk(weapon.bulk)],
      [*Hands* #convert_data(weapon.hands)],
    ).join("; "))
    #bloc.push((
      if exists(weapon.range) [*Range* #convert_data(weapon.range) ft.], 
      if exists(weapon.reload) [*Reload* #convert_data(weapon.reload)],
    ).filter(it => exists(it)).join("; "))
    #bloc.push((
      [*Type* #convert_data(weapon.type)],
      [*Category* #convert_data(weapon.category)],
      [*Group* #convert_data(weapon.group)],
    ).join("; "))
    #if exists(weapon.ammo) [
      #let line = (
        if weapon.ammo == none {none} else [*Ammunition* #convert_data(weapon.ammo)], 
        if weapon.ammo_bulk == none {none} else [*Ammo Bulk* #convert_bulk(weapon.ammo_bulk)],
        if weapon.ammo_price == none {none} else [*Ammo Price* #convert_price(weapon.ammo_price)],
      ).filter(it => it != none).join("; ")
      #bloc.push(line)
    ]
    #let line = ()
    #if exists(weapon.hardness) {line.push[*Hardness* #weapon.hardness]}
    #if exists(weapon.hp) {line.push[*HP(BT)* #weapon.hp;(#{weapon.hp/2})]}
    #if exists(weapon.dc) {line.push[*Check Bonus* #convert_modifier(weapon.dc - 10);(DC#weapon.dc)]}
    #bloc.push(line.join("; "))
    #for other in weapon.others.keys() {bloc.push[*#other* #weapon.others.at(other)]}
    #bloc.filter(it => exists(it)).join(linebreak())
    #if bloc.len() > 0 {hr()}
    #weapon.body
    
    #if exists(weapon.activations) {weapon.activations.map(var => mk_activation(var)).join()}
    #if exists(weapon.after){
      hr()
      weapon.after
    }
    #if exists(weapon.variants) {
      hr()
      weapon.variants.map(var => mk_item_variant(var)).join(hr())
    }
  ]
}

#let armor_group = (
  cloth: "Cloth",
  leather: "Leather",
  chain: "Chain",
  composite: "Composite",
  plate: "Plate",
  skeletal: "Skeletal",
  wood: "Wood",
)
#let armor_proficiency = (
  unarmored: "Unarmored",
  light: "Light",
  medium: "Medium",
  heavy: "Heavy",
)
#let new_armor(name, body, price: none, ac_bonus: none, dex_cap: none, check_penalty: none, speed_penalty: none, bulk: none, group: none, traits: (), short: none, level: none, proficiency: none, strength: none, hardness: none, hp: none, others: (:), activations: (), plus: false, variants: (), breakable: false, tags: (), after: none, kind: "Item") = (
  name: name,
  body: body,
  price: price,
  ac_bonus: ac_bonus,
  dex_cap: dex_cap,
  check_penalty: check_penalty,
  speed_penalty: speed_penalty,
  bulk: bulk, 
  group: group,
  traits: clean_list(split_traits(traits)),
  class: class_armor,
  short: short,
  level: level,
  proficiency: proficiency,
  strength: strength,
  hardness: hardness,
  hp: hp,
  others: others,
  activations: as_list(activations),
  plus: plus,
  variants: as_list(variants),
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  after: after,
  kind: kind,
)
#let mk_armor(armor, theme: THEME, breakable: auto) = {
  itembox(
    armor.name,
    kind: armor.kind,
    level: [#armor.level#if armor.plus == true [+]],
    traits: armor.traits,
    breakable: if breakable == auto {armor.breakable} else {breakable},
    theme: theme,
  )[
    #let body = ()
    #if armor.price != none {body.push[*Price* #convert_price(armor.price)]}
    #let line = (
      if armor.proficiency == none {none} else [*Type* #armor.proficiency],
      if armor.ac_bonus == none {none} else [*AC Bonus* #convert_modifier(armor.ac_bonus)],
      if armor.dex_cap == none {none} else [*Dex Cap* #convert_modifier(armor.dex_cap)]
    ).filter(it => exists(it)).join("; ")
    #body.push(line)
    #let line = (
      if armor.check_penalty == none {none} else [*Check Penalty* #convert_modifier(armor.check_penalty)], 
      if armor.speed_penalty == none {none} else [
        *Speed Penalty* #convert_modifier(armor.speed_penalty) #if armor.speed_penalty != 0 [ ft.]
      ]
    ).filter(it => exists(it)).join("; ")
    #body.push(line)
    #let line = (
      if armor.strength == none {none} else [*Str Requirement* #convert_modifier(armor.strength)], 
      if armor.bulk == none {none} else [*Bulk* #convert_bulk(armor.bulk)],
      if armor.group == none {none} else [*Group* #armor.group]
    ).filter(it => exists(it)).join("; ")
    #body.push(line)
    #let line = ()
    #if exists(armor.hardness) {line.push[*Hardness* #armor.hardness]}
    #if exists(armor.hp) {line.push[*HP(BT)* #armor.hp;(#{armor.hp/2})]}
    #if line.len() > 0 {body.push(line.join("; "))}
    #for other in armor.others.keys() {body.push[*#other* #armor.others.at(other)\ ]}
    #let body = body.filter(it => exists(it))
    #body.join(linebreak())
    #if body.len() > 0 {hr()}
    #armor.body
    #if exists(armor.activations) {armor.activations.map(var => mk_activation(var)).join()}
    #if exists(armor.after){
      hr()
      armor.after
    }
    #if exists(armor.variants) {
      hr()
      armor.variants.map(var => mk_item_variant(var)).join(hr())
    }
  ]
}

#let new_spell(name, body, actions: none, tradition: (), rank: none, traits: (), range: none, target: none, area: none, duration: none, save: none, locus: none, cost: none, prerequisites: none, trigger: none, requirements: none, short: none, spell_lists: (), defense: none, kind: "Spell", others: (:), heightened: (:), breakable: false, tags: ()) = (
  class: class_spell,
  name: name,
  body: body,
  actions: actions,
  tradition: clean_list(split_traits(tradition)),
  spell_lists: clean_list(split_traits(spell_lists)),
  rank: rank,
  traits: clean_list(split_traits(traits)),
  range: range,
  target: target,
  area: area,
  duration: duration,
  save: save,
  locus: locus,
  cost: cost,
  prerequisites: prerequisites,
  trigger: trigger,
  requirements: requirements,
  short: short,
  defense: defense,
  kind: kind,
  others: others,
  heightened: heightened,
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
)
#let mk_spell(spell, theme: THEME, breakable: auto) = {
  let tradition = {
    let tmp = spell.tradition
    if tmp == none or tmp == () { none }
    else if type(tmp) == array { tmp.join(", ") }
    else {tmp}
  }
  let spell_lists = {
    let tmp = spell.spell_lists
    if tmp == none or tmp == () { none }
    else if type(tmp) == array { tmp.join(", ") }
    else {tmp}
  }
  itembox(
    spell.name,
    level: spell.rank,
    traits: spell.traits,
    kind: spell.kind,
    actions: spell.actions,
    breakable: if breakable == auto {spell.breakable} else {breakable},
    theme: theme,
  )[
    #let body = ()
    #if exists(spell.prerequisites){body.push[*Prerequisites* #spell.prerequisites]}
    #if exists(tradition) {body.push[*Traditions* #tradition]}
    #if exists(spell_lists) [*Spell Lists* #spell_list]
    #let line = (
      if exists(spell.locus) [*Loci* #spell.locus], 
      if exists(spell.cost) [*Cost* #spell.cost]
    ).filter(it => exists(it)).join("; ")
    #body.push(line)
    #let line = (
      if exists(spell.range) [*Range* #spell.range], 
      if exists(spell.area) [*Area* #spell.area],
      if exists(spell.target) [*Targets* #spell.target],
    ).filter(it => exists(it)).join("; ")
    #body.push(line)
    #if exists(spell.trigger) {body.push[*Trigger* #spell.trigger]}
    #let line = (
      if exists(spell.save) [*Saving Throw* #spell.save], 
      if exists(spell.defense) [*Defense* #spell.defense],
      if exists(spell.duration) [*Duration* #spell.duration],
    ).filter(it => exists(it)).join("; ")
    #body.push(line)
    #if exists(spell.requirements) {body.push[*Requirements* #spell.requirements]}
    #for other in spell.others.keys() {body.push[*#other* #spell.others.at(other)]}
    #let body = body.filter(it => exists(it))
    #body.join(linebreak())
    #if body.len() > 0 {hr()}
    #spell.at("body")
    #if spell.heightened.len() > 0 {
      hr()
      spell.heightened.pairs().map(pair => [*Heightened (#pair.at(0))* #pair.at(1)]).join(linebreak())
    }
  ]
}

#let new_background(name, body, traits: (), short: none, tags: (), breakable: false) = (
  class: class_background,
  name: name,
  body: body,
  traits: clean_list(split_traits(traits)),
  short: short,
  tags: clean_list(split_traits(tags)),
  breakable: breakable,
)
#let mk_background(background, theme: THEME, breakable: auto) = {
  itembox(background.name, background.body, traits: background.traits, kind: "Background", theme: theme, breakable: if breakable == auto {background.breakable} else {breakable},)
}

#let new_heritage(name, body, traits: (), short: none, tags: (), breakable: true, addons: ()) = (
  class: class_heritage,
  name: name,
  body: body,
  traits: clean_list(split_traits(traits)),
  short: short,
  tags: clean_list(split_traits(tags)),
  breakable: breakable,
  addons: as_list(addons),
)
#let mk_heritage(heritage, theme: THEME, breakable: auto) = {
  block(breakable: if breakable == auto {heritage.breakable} else {breakable}, {
    heading(heritage.name, depth: 2, bookmarked: false, outlined: false)
    print_traits(heritage.traits, theme: theme)
    if exists(heritage.traits) {linebreak()}
    heritage.body
  })
  [#heritage.addons.join(linebreak())]
}

#let new_feat(name, body, traits: (), actions: none, kind: "Feat", level: none, prerequisites: none, trigger: none, requirements: none, short: none, frequency: none, others: (:), breakable: false, tags: ()) = (
  class: class_feat,
  name: name,
  body: body,
  traits: clean_list(split_traits(traits)),
  actions: actions,
  kind: kind,
  level: level,
  prerequisites: prerequisites,
  trigger: trigger,
  requirements: requirements,
  frequency: frequency,
  short: short,
  others: others,
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
)
#let mk_feat(feat, theme: THEME, breakable: auto) = {
  itembox(
    feat.name,
    actions: feat.actions,
    traits: feat.traits,
    kind: feat.kind,
    level: feat.level,
    breakable: if breakable == auto {feat.breakable} else {breakable},
    theme: theme,
  )[
    #let bloc = ()
    #if exists(feat.prerequisites) {bloc.push[*Prerequisites* #feat.prerequisites]}
    #if exists(feat.frequency) {bloc.push[*Frequency* #feat.frequency]}
    #if exists(feat.requirements) {bloc.push[*Requirements* #feat.requirements]}
    #if exists(feat.trigger) {bloc.push[*Trigger* #feat.trigger]}
    #for other in feat.others.keys() {bloc.push[*#other* #feat.others.at(other)]}
    #bloc.filter(it => exists(it)).join(linebreak())
    #if bloc.len() > 0 {hr()}
    #feat.body
  ]
}

#let new_shield(name, body, traits: (), price: none, ac_bonus: none, speed_penalty: none, bulk: none, hardness: none, hp: none, level: none, short: none, others: (:), activations: (), plus: false, variants: (), breakable: false, tags: (), after: none) = (
  class: class_shield,
  name: name,
  body: body,
  traits: clean_list(split_traits(traits)),
  price: price,
  ac_bonus: ac_bonus,
  speed_penalty: speed_penalty,
  bulk: bulk,
  hardness: hardness,
  hp: hp,
  level: level,
  short: short,
  others: others,
  activations: as_list(activations),
  plus: plus,
  variants: as_list(variants),
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  after: after,
  kind: "Item",
)
#let mk_shield(shield, theme: THEME, breakable: auto) = {
  itembox(
    shield.name, 
    traits: shield.traits,
    level: [#shield.level#if shield.plus == true [+]],
    kind: shield.kind,
    breakable: if breakable == auto {shield.breakable} else {breakable},
    theme: theme,
  )[
    #let body = ()
    #if exists(shield.price) {body.push[*Price* #convert_price(shield.price)]}
    #let line = ()
    #if exists(shield.ac_bonus) {line.push[*AC Bonus* #convert_modifier(shield.ac_bonus)]} 
    #if exists(shield.speed_penalty) {line.push[*Speed Penalty* #convert_modifier(shield.speed_penalty)]} 
    #if exists(shield.bulk) {line.push[*Bulk* #convert_bulk(shield.bulk)]}
    #body.push(line.filter(it => exists(it)).join("; "))
    #let line = ()
    #if exists(shield.hardness) {line.push[*Hardness* #shield.hardness]}
    #if exists(shield.hp) {line.push[*HP(BT)* #{let hp = shield.hp; if hp == none {null} else {let hp = calc.floor(calc.abs(hp)); let bt = hp/2; [#hp\(#bt)]}}]}
    #body.push(line.filter(it => exists(it)).join("; "))
    #for other in shield.others.keys() {body.push[*#other* #shield.others.at(other)]}
    #let body = body.filter(it => exists(it))
    #body.join(linebreak())
    #if body.len() > 0 {hr()}
    #shield.body
    #if exists(shield.activations) {shield.activations.map(var => mk_activation(var)).join()}
    #if exists(shield.after){
      hr()
      shield.after
    }
    #if exists(shield.variants) {
      hr()
      shield.variants.map(var => mk_item_variant(var)).join(hr())
    }
  ]
}

#let get_leveled_list(item_list, level) = {
  item_list.filter(item => item.at("level") == level)
}

#let spell_tradition = (
  occult: "Occult",
  divine: "Divine",
  arcane: "Arcane",
  primal: "Primal",
)
#let spell_type = (
  spontaneous: "Spontaneous",
  prepared: "Prepared",
  innate: "Innate",
  focus: "Focus",
  ritual: "Ritual",
)
#let ability_category = (
  general: "General",
  defensive: "Defensive",
  offensive: "Offensive",
)
#let creature_sizes = (
  tiny: "Tiny",
  small: "Small",
  medium: "Medium",
  large: "Large",
  huge: "Huge",
  gargantuan: "Gargantuan",
)
#let new_creature(name, level: none, traits: (), perception: 0, senses: (), skills: (:), strength: 0, dexterity: 0, constitution: 0, intelligence: 0, wisdom: 0, charisma: 0, ac: 10, fortitude: 0, reflex: 0, will: 0, hp: 0, resistances: (:), weaknesses: (:), immunities: (), speed: (:), abilities: (), attacks: (), dc: none, description, short: none, size: none, spellcastings: (), notes: (:), languages: none, others: (:), tags: (), family: none, items:(), hardness: none, kind: "Creature", breakable: false) = {
  (
    class: class_creature,
    name: name,
    traits: clean_list(if size != none {
      let traits = split_traits(traits)
      traits.push(size)
      traits
    } else {split_traits(traits)}),
    perception: perception,
    senses: as_list(senses),
    skills: skills,
    attributes: (strength: strength, dexterity: dexterity, constitution: constitution, intelligence: intelligence, wisdom: wisdom, charisma: charisma),
    level: level,
    ac: ac,
    fortitude: fortitude,
    reflex: reflex,
    will: will,
    hp: hp,
    resistances: resistances,
    weaknesses: weaknesses,
    immunities: as_list(immunities),
    speed: speed,
    abilities: as_list(abilities),
    attacks: as_list(attacks),
    dc: dc, 
    description: description,
    short: short,
    size: size,
    languages: split_args(languages),
    spellcastings: as_list(spellcastings),
    notes: notes,
    others: others,
    tags: clean_list(split_traits(tags)),
    family: family,
    items: clean_list(split_traits(items)),
    hardness: hardness,
    kind: kind,
    breakable: breakable,
  )
}
#let new_ability(name, body, actions: none, traits: (), trigger: none, requirements: none, prerequisites: none, category: ability_category.general, duration: none, others: (:), tags: (), frequency: none, range: none, targets: none, area: none, defense: none, short: false) = {
  (
    class: class_ability,
    name: name,
    body: body,
    actions: actions,
    traits: clean_list(split_traits(traits)),
    trigger: trigger,
    requirements: requirements,
    prerequisites: prerequisites,
    category: category,
    duration: duration,
    others: others,
    tags: clean_list(split_traits(tags)),
    frequency: frequency,
    range: range,
    targets: targets,
    area: area,
    defense: defense,
    short: short,
  )
}
#let mk_ability(ability, short: auto) = {
  let name = [#{ability.name} #ability.actions]
  let pre = ()
  short = if short == auto {ability.short} else {short}
  if not short {
    let traits = list_traits(ability.traits)
    if traits != none {pre.push([(#{traits})])}
    let body = ()
    if exists(ability.prerequisites) {body.push([*Prerequisites* #{ability.prerequisites}])}
    if exists(ability.frequency) {body.push([*Frequency* #{ability.frequency}])}
    if exists(ability.requirements) {body.push([*Requirements* #{ability.requirements}])}
    if exists(ability.duration) {body.push([*Duration* #{ability.duration}])}
    if exists(ability.range) {body.push([*Range* #{ability.range}])}
    if exists(ability.targets) {body.push([*Targets* #{ability.targets}])}
    if exists(ability.area) {body.push([*Area* #{ability.area}])}
    if exists(ability.defense) {body.push([*Defense* #{ability.defense}])}
    if exists(ability.trigger) {body.push([*Trigger* #{ability.trigger}])}
    for other in ability.others.keys() [*#other* #ability.others.at(other)]
    if exists(ability.body) {body.push([#if body.len() > 0 [*Effect*] #ability.body])}
    pre.push(body.join("; "))
  } 
  [/ #name: #pre.join(" ")]
}
#let new_attack(name, body, damage: none, traits: (), bonus: 0, type: weapon_type.melee, actions: a, tags:()) = (
  class: class_attack,
  name: name,
  body: body,
  type: type,
  actions: actions,
  bonus: bonus,
  traits: clean_list(split_traits(traits)),
  damage: damage,
  tags: clean_list(split_traits(tags)),
)
#let mk_attack(attack) = {
  let line = ()
  let name = if attack.type != none [#{attack.type} #attack.actions] else {none}
  //if attack.actions != none {line.push(attack.actions)}
  if attack.name != none {line.push(lower(attack.name))}
  if attack.bonus != none {line.push(convert_modifier(attack.bonus))}
  let traits = list_traits(attack.traits)
  if traits != none {line.push([(#{traits})])}
  if attack.damage != none {line.push([Damage #{attack.damage}])}
  [/ #name: #line.join(" ");#if exists(attack.body) [; #attack.body]]
}
#let new_spellcasting(tradition: none, note: none, dc: 10, heightened: auto, spell_lists: (), type: none, focus: none) = (
  class: class_spellcasting,
  tradition: tradition,
  note: note,
  dc: dc,
  heightened: heightened,
  spell_lists: as_list(spell_lists),
  type: type,
  focus: focus,
)
#let spell_use(name, uses: none) = ("name": name, "uses": uses)
#let new_spell_list(..spells, slots: none, rank: 0) = {
  let new_spells = (:)
  for spell in spells.pos() {
    let s = if type(spell) == str {
      spell_use(spell, uses: 1)
    } else if type(spell) == array {
      spell_use(spell.at(0), spell.at(1))
    } else {
      spell
    }
    if s.name in new_spells.keys() {
      new_spells.insert(s.name, spell_use(s.name, uses: s.uses + new_spells.at(s.name)))
    } else {
      new_spells.insert(s.name, s)
    }
  }
  (
    class: class_spell_list,
    slots: slots,
    spells: new_spells,
    rank: rank,
  )
}
#let mk_spell_use(spell_use) = [_#spell_use.name;_#if spell_use.uses != none and spell_use.uses > 1 [(#spell_use.uses/day)]]
#let mk_spell_list(spell_list, heightened: none) = {
  let rank = if (spell_list.rank == 0) [*Cantrip #if heightened != none [(#convert_rank(heightened))]*] else [*#convert_rank(spell_list.rank)*]
  let spells = ()
  for spell in spell_list.spells.values().sorted(key: s => s.name) {spells.push(mk_spell_use(spell))}
  let slots = if spell_list.slots == 0 or spell_list.slots == none {none} else [ (#spell_list.slots slots)]
  [#rank #spells.join(", ");#slots]
}
#let mk_spellcasting(spellcasting, heightened: auto) = {
  heightened = if heightened == auto and spellcasting.heightened == auto {0} else if spellcasting.heightened == auto {heightened} else {spellcasting.heightened}
  let line = ()
  let name = ()
  if spellcasting.type != none {name.push([#spellcasting.type])}
  if spellcasting.tradition != none {name.push([#spellcasting.tradition])}
  if spellcasting.note != none {name.push[(#spellcasting.note)]}
  name.push([Spells])
  if spellcasting.dc != none {line.push[DC #{spellcasting.dc}, attack #{convert_modifier(spellcasting.dc - 10, strong: true)}\;]}
  if exists(spellcasting.focus) {line.push[#spellcasting.focus focus points]}
  let spells = ()
  for spell_list in spellcasting.spell_lists.sorted(key: sl => -sl.rank) {spells.push(mk_spell_list(spell_list, heightened: heightened))}
  line.push(spells.join("; "))
  [/ #name.join(" "):#line.join(" ")]
}
#let mk_creature(creature, short: auto, breakable: auto, theme: THEME) = {
  itembox(
    creature.name,
    level: creature.level,
    traits: creature.traits,
    kind: creature.kind,
    breakable: if breakable == auto {creature.breakable} else {breakable},
    theme: theme,
  )[
    #let bloc = ()
    #bloc.push[*Perception* #convert_modifier(creature.perception)#if "perception" in creature.notes [ (#creature.notes.perception)]#if exists(creature.senses) [; #creature.senses.join(", ")]]
    #if exists(creature.languages) {bloc.push[*Languages* #creature.languages.join(", ")]}
    #if exists(creature.skills) {bloc.push[*Skills* #creature.skills.pairs().sorted(key: it => it.at(0)).map(skill => [#skill.at(0) #convert_modifier(skill.at(1))#if skill.at(0) in creature.notes [#creature.notes.at(skill.at(0))]]).join(", ")]}
    #bloc.push[
      *Str* #convert_modifier(creature.attributes.strength, strong: true)
      *Dex* #convert_modifier(creature.attributes.dexterity, strong: true)
      *Con* #convert_modifier(creature.attributes.constitution, strong: true)
      *Int* #convert_modifier(creature.attributes.intelligence, strong: true)
      *Wis* #convert_modifier(creature.attributes.wisdom, strong: true)
      *Cha* #convert_modifier(creature.attributes.charisma, strong: true)
    ]
    #if exists(creature.items) {
      bloc.push[*Items* #creature.items.sorted().join(", ")]
    }
    #for other in creature.others.keys() {bloc.push[*#other* #creature.others.at(other)]}
    #if creature.abilities != none {
      let trms = ()
      let abilities = creature.abilities.filter(ab => ab.category == ability_category.general)
      for ability in abilities {bloc.push(mk_ability(ability, short: short))}
    }
    #bloc.filter(it => exists(it)).join(linebreak())
    #hr()

    #let bloc = ()
    #bloc.push[
      *AC* #creature.ac #if "ac" in creature.notes [ (#creature.notes.ac)]\; 
      *Fort* #convert_modifier(creature.fortitude)#if "fortitude" in creature.notes [(#creature.notes.fortitude)],
      *Ref* #convert_modifier(creature.reflex)#if "reflex" in creature.notes [(#creature.notes.reflex)],
      *Will* #convert_modifier(creature.will)#if "will" in creature.notes [(#creature.notes.will)]
    ]
    #bloc.push(
      (
        [*HP* #creature.hp#if "hp" in creature.notes [(#creature.notes.hp)]],
        if exists(creature.hardness) [*Hardness* #creature.hardness],
        if exists(creature.resistances) [*Resistances* #creature.resistances.keys().map(res => [#res #convert_data(creature.resistances.at(res))]).join(", ")],
        if exists(creature.weaknesses) [*Weaknesses* #creature.weaknesses.keys().map(weak => [#weak #convert_data(creature.weaknesses.at(weak))]).join(", ")],
        if exists(creature.immunities) [*Immunities* #creature.immunities.join(", ")],
      ).filter(it => exists(it)).join("; ")
    )
    #if exists(creature.abilities) {
      let trms = ()
      let abilities = creature.abilities.filter(ab => ab.category == ability_category.defensive)
      for ability in abilities {trms.push(mk_ability(ability, short: short))}
      bloc.push(trms.join())
    }
    #bloc.filter(it => exists(it)).join(linebreak())
    #hr()

    #let bloc = ()
    #if exists(creature.speed) {
      bloc.push[*Speed* #{
        let s = creature.speed
        if type(s) == int [#s feet]
        else {
          let l = ()
          for spd in s.keys() {l.push[#if lower(spd) != "walk" [#spd] #s.at(spd) feet#if spd in creature.notes [(#creature.notes.at(spd))]]}
          l.join(", ")
        }
      }]
    }
    #let trms = ()
    #for attack in creature.attacks {trms.push(mk_attack(attack))}
    #for spellcasting in creature.spellcastings {trms.push(mk_spellcasting(
      spellcasting, 
      heightened: if exists(creature.level) {calc.ceil(creature.level/2)} else {auto}
    ))}
    #for ability in creature.abilities.filter(ab => ab.category == ability_category.offensive) {trms.push(mk_ability(ability, short: short))}
    #bloc.push(trms.join())
    #bloc.filter(it => exists(it)).join()
  ]
}

#let mk(object, theme: THEME, short: auto, breakable: auto) = {
  if type(object) != dictionary or "class" not in object {object}
  else if object.class == class_ability {mk_ability(object)}
  else if object.class == class_activation {mk_activation(object)}
  else if object.class == class_armor {mk_armor(object, theme: theme, breakable: breakable)}
  else if object.class == class_attack {mk_attack(object)}
  else if object.class == class_background {mk_background(object, theme: theme, breakable: breakable)}
  else if object.class == class_creature {mk_creature(object, theme: theme, breakable: breakable)}
  else if object.class == class_feat {mk_feat(object, theme: theme, breakable: breakable)}
  else if object.class == class_heritage {mk_heritage(object, theme: theme, breakable: breakable)}
  else if object.class == class_item {mk_item(object, theme: theme, breakable: breakable)}
  else if object.class == class_shield {mk_shield(object, theme: theme, breakable: breakable)}
  else if object.class == class_spell {mk_spell(object, theme: theme, breakable: breakable)}
  else if object.class == class_spell_list {mk_spell_list(object)}
  else if object.class == class_spellcasting {mk_spellcasting(object)}
  else if object.class == class_variant {mk_item_variant(object)}
  else if object.class == class_weapon {mk_weapon(object, theme: theme, breakable: breakable)}
  else {object}
}
#let Item = (
  new: new_item,
  variant: new_item_variant,
  activation: new_activation,
  make: mk_item,
  grades: item_grades,
  class: class_item,
)
#let Weapon = (
  new: new_weapon,
  variant: new_item_variant,
  activation: new_activation,
  make: mk_weapon,
  category: weapon_category,
  damage: weapon_damage,
  group: weapon_group,
  type: weapon_type,
  class: class_weapon,
)
#let Armor = (
  new: new_armor,
  variant: new_item_variant,
  activation: new_activation,
  make: mk_armor,
  proficiency: armor_proficiency,
  group: armor_group,
  class: class_armor,
)
#let Shield = (
  new: new_shield,
  variant: new_item_variant,
  activation: new_activation,
  make: mk_shield,
  class: class_shield,
)
#let Spell = (
  new: new_spell,
  make: mk_spell,
  traditions: spell_tradition,
  cast_type: spell_type,
  class: class_spell,
)
#let Feat = (
  new: new_feat,
  make: mk_feat,
  class: class_feat,
)
#let Creature = (
  new: new_creature,
  spellcasting: (
    new: new_spellcasting,
    list: new_spell_list,
  ),
  ability: (
    new: new_ability,
    categories: ability_category,
  ),
  attack: new_attack,
  sizes: creature_sizes,
  class: class_creature,
)
#let Heritage = (
  new: new_heritage,
  make: mk_heritage,
)
#let Background = (
  new: new_background,
  make: mk_background,
)