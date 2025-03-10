#import "../base.typ": *
#import "common.typ": *
#import "item.typ": mk_variant, new_activation, mk_activation
#import "spell.typ": mk_spell_list, new_spell_list

#let class_wand = "wand"

#let wand_cast_spell_activation = new_activation(actions: "Cast a Spell", frequency: "once per day, plus overcharge")[You cast one of the spell from the wand.]
#let new_wand(name, body, price: none, bulk: L, usage: [held in 1 hand], activate: [cast a spell], level: none, traits: (), variants: (), dc: none, short: none, variant: none, kind: "Item", plus: false, requirements: none, activations: (), others: (:), hardness: none, hp: none, notes: (:), breakable: false, tags:(), after: none, craft_requirements: [a casting of each spell], spell_lists: (), runes: (), url: none) = (
  class: class_wand,
  variant: variant,
  name: name,
  body: body,
  price: price,
  bulk: bulk,
  usage: usage,
  activate: activate,
  level: level,
  traits: clean_list(split_traits(traits) + ("wand",)),
  variants: as_list(variants),
  dc: dc,
  short: short,
  kind: kind,
  plus: plus,
  requirements: requirements,
  activations: (wand_cast_spell_activation,) + as_list(activations),
  others: others,
  hardness: hardness,
  hp: hp,
  notes: notes,
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  after: after,
  craft_requirements: craft_requirements,
  spell_lists: as_list(spell_lists),
  runes: clean_list(split_traits(runes)),
  url: url,
)
#let mk_wand(item, theme: THEME, breakable: auto, short: (), hide: ()) = {
  itembox(
    [#item.name#if exists(item.variant) [ (#item.variant)]],
    kind: item.kind,
    level: [#item.level#if item.plus == true [+]],
    traits: item.traits,
    breakable: if breakable == auto {item.breakable} else {breakable},
    theme: theme,
    hanging: true,
    url: wand.url,
  )[
    #let bloc = ()
    #if exists(item.price) {bloc.push[*Price* #convert_price(item.price)#if "price" in item.notes [ (#item.notes.price)]]}
    #bloc.push((
      if not exists(item.usage) {none} else [*Usage* #convert_data(item.usage)], 
      if not exists(item.bulk) {none} else [*Bulk* #convert_bulk(item.bulk)#if "bulk" in item.notes [ (#item.notes.bulk)]],
    ).filter(it => exists(it)).join("; "))
    #if exists(item.dc) {bloc.push[*Check Bonus* #convert_modifier(item.dc - 10) (DC #item.dc)#if "dc" in item.notes [ (#item.notes.dc)]]}
    #for key in item.others.keys() {bloc.push[*#key* #item.others.at(key)]}
    #if exists(item.activate) {bloc.push[*Activate* #item.activate]}
    #if exists(item.requirements) {bloc.push[*Requirements* #item.requirements]}
    #bloc.push((
      if exists(item.hardness) [*Hardness* #item.hardness#if "hardness" in item.notes [ (#item.notes.hardness)]] else {none},
      if exists(item.hp) [*HP(BT)* #item.hp;(#{item.hp/2})#if "hp" in item.notes [ (#item.notes.hp)]] else {none},
    ).filter(it => exists(it)).join("; "))
    #let bloc = bloc.filter(it => exists(it))
    #if exists(item.runes) {bloc.push[*Runes* #item.runes.map(it => lower(it)).join(", ")]}
    #bloc.join(parbreak())
    #if bloc.len() > 0 {hr()}
    #straight(item.body)
    #if exists(item.craft_requirements) [#parbreak()*Craft Requirements* #item.craft_requirements#parbreak()]
    #if exists(item.activations) {item.activations.map(var => mk_activation(var)).join(parbreak())}
    #let b = ()
    #for spell_list in item.spell_lists {
      b.push(mk_spell_list(spell_list))
    }
    #let b = b.filter(it => exists(it))
    #if b.len() > 0 {
      hr()
      b.join(parbreak())
    }
    #if exists(item.after){
      hr()
      item.after
    }
    #if exists(item.variants) {
      hr()
      item.variants.map(var => mk_variant(var)).join(hr())
    }
  ]
}

#let Wand = (
  class: class_wand,
  new: new_wand,
  make: mk_wand,
)