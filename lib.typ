#import "base.typ": *
#import "objects/armor.typ": Armor, new_armor
#import "objects/background.typ": Background, new_background
#import "objects/common.typ": *
#import "objects/creature.typ": Creature, new_creature, new_ability, new_attack
#import "objects/feat.typ": Feat, new_feat
#import "objects/hazard.typ": Hazard, new_hazard
#import "objects/heritage.typ": Heritage, new_heritage
#import "objects/item.typ": Item, new_activation, new_item, new_variant
#import "objects/obstacle.typ": Obstacle, new_obstacle
#import "objects/settlement.typ": Settlement, new_settlement
#import "objects/shield.typ": Shield, new_shield
#import "objects/spell.typ": Spell, new_spell, new_spell_list, new_spellcasting
#import "objects/staff.typ": Staff, new_staff,
#import "objects/wand.typ": Wand, new_wand,
#import "objects/weapon.typ": Weapon, new_weapon,

// ------------ TRANSFORM -----------\\


#let DEFAULT_MK_REGISTRY = (
  armor: Armor.make,
  background: Background.make,
  creature: Creature.make,
  ability: Creature.ability.make,
  attack: Creature.attack.make,
  feat: Feat.make,
  hazard: Hazard.make,
  heritage: Heritage.make,
  item: Item.make,
  activation: Item.activation.make,
  variant: Item.variant.make,
  obstacle: Obstacle.make,
  settlement: Settlement.make,
  shield: Shield.make,
  spell: Spell.make,
  spellcasting: Spell.spellcasting.make,
  spell_list: Spell.spell_list.make,
  staff: Staff.make,
  wand: Wand.make,
  weapon: Weapon.make,
)

#let mk(object, theme: THEME, short: auto, breakable: auto, hide: (), mk_reg: DEFAULT_MK_REGISTRY) = {
  if type(object) != dictionary or "class" not in object {object}
  else if object.class in mk_reg {
    mk_reg.at(object.class)(object, theme: theme, short: short, breakable: breakable, hide: hide)
  } else {object}
}

#let old_mk(object, theme: THEME, short: auto, breakable: auto, hide: ()) = {
  if type(object) != dictionary or "class" not in object {object}
  else if object.class == class_ability {mk_ability(object)}
  else if object.class == class_activation {mk_activation(object)}
  else if object.class == class_armor {mk_armor(object, theme: theme, breakable: breakable)}
  else if object.class == class_attack {mk_attack(object)}
  else if object.class == class_background {mk_background(object, theme: theme, breakable: breakable)}
  else if object.class == class_creature {mk_creature(object, theme: theme, breakable: breakable, short: short)}
  else if object.class == class_feat {mk_feat(object, theme: theme, breakable: breakable)}
  else if object.class == class_heritage {mk_heritage(object, theme: theme, breakable: breakable)}
  else if object.class == class_item {mk_item(object, theme: theme, breakable: breakable)}
  else if object.class == class_shield {mk_shield(object, theme: theme, breakable: breakable)}
  else if object.class == class_spell {mk_spell(object, theme: theme, breakable: breakable)}
  else if object.class == class_spell_list {mk_spell_list(object)}
  else if object.class == class_spellcasting {mk_spellcasting(object)}
  else if object.class == class_variant {mk_item_variant(object)}
  else if object.class == class_weapon {mk_weapon(object, theme: theme, breakable: breakable)}
  else if object.class == class_hazard {mk_hazard(object, theme: theme, short: short, breakable: breakable, hide: hide)}
  else if object.class == class_settlement {mk_settlement(object, theme: theme, short: short, breakable: breakable, hide: hide)}
  else if object.class == class_obstacle {mk_obstacle(object, theme: theme, short: short, breakable: breakable, hide: hide)}
  else if object.class == class_staff {mk_staff(object, theme: theme, short: short, breakable: breakable)}
  else if object.class == class_wand {mk_wand(object, theme: theme, short: short, breakable: breakable)}
  else if object.class == class_spellhold {mk_spellhold(object, theme: theme, short: short, breakable: breakable)}
  else {object}
}


// ------------ TEMPLATE ------------ \\
#let title_page(
  title,
  subtitle: none,
  authors: (),
) = {}

#let pf2e(body, columns: 1, theme: THEME, title: none, subtitle: none, authors: (), content_table: false, title_page: none, mk_reg: DEFAULT_MK_REGISTRY) = {
  set page(
    paper: "us-letter",
    columns: columns,
    margin: (left:12%, right: 12%, bottom: 6%, top:7%),
    numbering: "1",
    number-align: center + bottom,
  //  fill: DARK_GREEN,
  )
  set par(
    justify: true,
    spacing: 0.7em,
    //first-line-indent: 1em,
  )
  set text(
    font: theme.main_text_font,
    size: theme.normal_font_size,
  )
  show heading: set text(
    font: theme.small_heading_font,
    fill: theme.first_level_heading_color,
  )
  show heading.where(depth: 1): set text(
    size: theme.first_level_heading_font_size,
    font: theme.big_heading_font,
    fill: theme.first_level_heading_color,
  )
  show heading.where(depth: 2): set text(
    font: theme.small_heading_font,
    fill: theme.second_level_heading_color,
  )
  set heading(offset: 4, outlined: false)
  set outline(depth: 5, indent: 2em, title: [
      #set text(size: theme.first_level_heading_font_size); 
      = Table of Contents
    ]
  )
  show heading.where(level: 5): set text(size: theme.first_level_heading_font_size)
  show heading.where(level: 6): set text(size: theme.second_level_heading_font_size)
  show heading.where(level: 7): set text(size: theme.third_level_heading_font_size)
  show heading.where(level: 8): it => {
    set text(
      font: theme.block_heading_font, 
      fill: white, 
      size: theme.fourth_level_heading_font_size,
      weight: "bold",
    )
    block(
      it, 
      fill: theme.fourth_level_heading_background_color, 
      width: 100%,
      inset: 0.4em,
      radius: (top: 40%),
      below: 0pt,
      above: 5pt,
    )
    set block(above: 3pt)
    line(length: 100%)
  }
  show heading.where(level: 9): it => {
    set text(
      font: theme.block_heading_font,
      size: theme.fifth_level_heading_font_size,
      fill: black,
    )
    set block(above: 5pt, below: 0.3em)
    it
  }

  //#show table.header: h => set
  set table(
    fill: (_, y) => if y == 0 {theme.accent} else {theme.table_fill.at(calc.rem(y, theme.table_fill.len()))},
    stroke: none,
    align: left,
  )
  show table.cell: c => {
    set text(font: theme.block_font, size: theme.block_font_size)
    show theme.center_cell_pattern: n => align(center)[#n]
    c
  }
  show table.cell.where(y: 0): set text(fill: white, weight: "bold")
  show table: set block()
  
  show ":a:": a
  show ":aa:": aa
  show ":aaa:": aaa
  show ":r:": r
  show ":f:": f

  if exists(title_page) {
    if type(title_page) == bool and title_page {
      // faire la page de titre automatiquement
      [TODO!!!]
      pagebreak()
    } else if type(title_page) == content {
      title_page
      pagebreak()
    } else if type(title_page) == function {
      title_page()
      pagebreak()
    } else {

    }
  }
  if content_table {
    set page(columns: 2)
    outline() 
  }

  let mk(object, short: auto, breakable: auto, hide: ()) = mk.with(theme: theme, mk_reg: mk_reg)
  
  body
}