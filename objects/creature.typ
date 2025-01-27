#import "../base.typ": *
#import "common.typ": *
#import "weapon.typ": Weapon
#import "spell.typ": new_spellcasting, mk_spellcasting, mk_spell_list, new_spell_list

#let class_creature = "creature"
#let class_ability = "ability"
#let class_attack = "attack"

#let ability_category = (
  general: "general",
  defensive: "defensive",
  offensive: "offensive",
)
#let creature_sizes = (
  tiny: "tiny",
  small: "small",
  medium: "medium",
  large: "large",
  huge: "huge",
  gargantuan: "gargantuan",
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
#let mk_ability(ability, short: auto, breakable: auto, hide: (), theme: THEME) = {
  let name = [#{ability.name} #ability.actions]
  let pre = ()
  short = if short == auto {ability.short} else {short}
  let traits = list_traits(ability.traits)
  if exists(traits) {pre.push([(#{traits})])}
  if not short {
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
  [*#name* #pre.join(" ")]
}
#let new_attack(name, damage, traits: (), bonus: 0, type: Weapon.types.melee, actions: a, tags:()) = (
  class: class_attack,
  name: name,
  type: type,
  actions: actions,
  bonus: bonus,
  traits: clean_list(split_traits(traits)),
  damage: damage,
  tags: clean_list(split_traits(tags)),
)
#let mk_attack(attack, theme: THEME, breakable: auto, short: false, hide: ()) = {
  let line = ()
  let name = if attack.type != none [#{attack.type} #attack.actions] else {none}
  //if attack.actions != none {line.push(attack.actions)}
  if attack.name != none {line.push(lower(attack.name))}
  if attack.bonus != none {line.push(convert_modifier(attack.bonus))}
  let traits = list_traits(attack.traits)
  if traits != none {line.push([(#{traits})])}
  if attack.damage != none {line.push([*Damage* #{attack.damage}])}
}

#let mk_creature(creature, short: auto, breakable: auto, theme: THEME, hide: ()) = {
  itembox(
    creature.name,
    level: creature.level,
    traits: creature.traits,
    kind: creature.kind,
    breakable: if breakable == auto {creature.breakable} else {breakable},
    theme: theme,
    hanging: true,
  )[
    #let short = if type(short) == array {short.map(it => lower(it))} else if type(short) == str or type(str) == content {lower(short)} else {()}
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
      let abilities = creature.abilities.filter(ab => ab.category == ability_category.general)
      for ability in abilities {
        let s = if short == true {true} else if type(short) == array and exists(ability.name) and lower(ability.name) in short {true} else if exists(ability.name) and type(short) == str and short == lower(ability.name) {true} else {auto}
        bloc.push(mk_ability(ability, short: s))
      }
    }
    #bloc.filter(it => exists(it)).join(parbreak())
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
        [*HP* #creature.hp#if "hp" in creature.notes [ (#creature.notes.hp)]],
        if exists(creature.hardness) [*Hardness* #creature.hardness],
        if exists(creature.resistances) [*Resistances* #creature.resistances.keys().map(res => [
          #let note = if "resistances" in creature.notes and res in creature.notes.resistances {creature.notes.resistances.at(res)} else {none}
          #res #convert_data(creature.resistances.at(res))#if exists(note) [ (#note)]]).join(", ")],
        if exists(creature.weaknesses) [*Weaknesses* #creature.weaknesses.keys().map(weak => [
          #let note = if "weaknesses" in creature.notes and weak in creature.notes.weaknesses {creature.notes.weaknesses.at(weak)} else {none}
          #weak #convert_data(creature.weaknesses.at(weak))#if exists(note) [ (#note)]]).join(", ")],
        if exists(creature.immunities) [*Immunities* 
        #creature.immunities.map(imm => [
          #let note = if "immunities" in creature.notes and imm in creature.notes.immunities {creature.notes.immunities.at(imm)} else {none}
          #imm#if exists(note) [ (#note)]
        ]).join(", ")],
      ).filter(it => exists(it)).join("; ")
    )
    #if exists(creature.abilities) {
      let abilities = creature.abilities.filter(ab => ab.category == ability_category.defensive)
      for ability in abilities {
        let s = if short == true {true} else if type(short) == array and exists(ability.name) and lower(ability.name) in short {true} else if exists(ability.name) and type(short) == str and lower(short) == lower(ability.name) {true} else {auto}
        bloc.push(mk_ability(ability, short: s))
      }
    }
    #bloc.filter(it => exists(it)).join(parbreak())
    #hr()

    #let bloc = ()
    #if exists(creature.speed) {
      bloc.push[*Speed* #{
        let s = creature.speed
        if type(s) == int [#s feet #if "speed" in creature.notes [(#creature.notes.speed)]]
        else if type(s) == str [#s]
        else {
          let l = ()
          for spd in s.keys() {
            let lspd = lower(spd)
            let note = if "speed" in creature.notes and lspd in creature.notes.speed {creature.notes.speed.at(lspd)} else {none}
            l.push[#if not (lspd == "walk" or lspd == "land") [#spd] #s.at(spd) feet#if exists(note) [ (#note)]]
          }
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
    #for ability in creature.abilities.filter(ab => ab.category == ability_category.offensive) {
      let s = if short == true {true} else if type(short) == array and exists(ability.name) and lower(ability.name) in short {true} else if exists(ability.name) and type(short) == str and lower(short) == lower(ability.name) {true} else {auto}
      trms.push(mk_ability(ability, short: s))
    }
    #bloc.push(trms.join(parbreak()))
    #bloc.filter(it => exists(it)).join(parbreak())
  ]
}

#let Creature = (
  new: new_creature,
  make: mk_creature,
  ability: (
    new: new_ability,
    class: class_ability,
    make: mk_ability,
    categories: ability_category,
  ),
  attack: (
    class: class_attack,
    new: new_attack,
    make: mk_attack,
  ),
  sizes: creature_sizes,
  class: class_creature,
)