#let size_tag_list = ("tiny", "small", "medium", "large", "huge", "gargantuan")
#let alignement_tag_list = ("lg", "ng", "cg", "ln", "n", "cn", "le", "ne", "ce")
#let rarity_tag_list = ("uncommon", "rare", "unique")
#let DARK_GREEN = rgb("#042407")
#let DARK_RED = rgb("#5d0000")
#let DARK_BLUE = rgb("#002564")
#let TAG_BORDER_COLOR = rgb("#d8c384")
#let TAG_COLOR = rgb("#5d0000")
#let UNCOMMON_TAG_COLOR = rgb("#98503c")
#let RARE_TAG_COLOR = rgb("#002564")
#let UNIQUE_TAG_COLOR = rgb("#54166d")
#let SIZE_TAG_COLOR = rgb("#3a7a58")
#let ALIGNEMENT_TAG_COLOR = rgb("#566193")
#let TAG_TEXT_COLOR = rgb("#fff")
#let FIRST_LEVEL_HEADING_COLOR = DARK_GREEN
#let SECOND_LEVEL_HEADING_COLOR = rgb("#2e0e03")
#let NOTE_BACKGROUND_COLOR = rgb("#c9c8a3")
#let RULEBOX_BACKGROUND_COLOR = rgb("#c4c0c4")
#let FOURTH_LEVEL_HEADING_BACKGROUND_COLOR = rgb("#002564")
#let TABLE_FILL = (rgb("#cecfbe"), rgb("#eff0e4"))
#let INFOBOX_COLOR = DARK_GREEN
#let BLOCK_FONT = "Open Sans"
#let MAIN_TEXT_FONT = "libre baskerville"
#let BIG_HEADING_FONT = "eagle lake"
#let BLOCK_HEADING_FONT = "Bebas Neue"
#let SMALL_HEADING_FONT = "Roboto"
#let CENTER_CELL_PATTERN = regex("^[+-]?\d+(?:(?:\s*(?i:gp|sp|cp|pp))?|L).*$")
#let NORMAL_FONT_SIZE = 10pt
#let BLOCK_FONT_SIZE = 10pt
#let TITLE_HEADING_FONT_SIZE = 23pt
#let TITLE_TEXT_FONT_SIZE = 12pt
#let SUBTITLE_HEADING_FONT_SIZE = 20pt
#let FIRST_LEVEL_HEADING_FONT_SIZE = 18pt
#let SECOND_LEVEL_HEADING_FONT_SIZE = 15pt
#let THIRD_LEVEL_HEADING_FONT_SIZE = 12pt
#let FOURTH_LEVEL_HEADING_FONT_SIZE = 15pt
#let FIFTH_LEVEL_HEADING_FONT_SIZE = 15pt
#let BLOC_HEADING_FONT_SIZE = 15pt
#let TRAIT_FONT_SIZE = 8pt

#let theme(
  accent: DARK_GREEN,
  tag_border_color: TAG_BORDER_COLOR,
  tag_color: TAG_COLOR,
  uncommon_tag_color: UNCOMMON_TAG_COLOR,
  rare_tag_color: RARE_TAG_COLOR,
  unique_tag_color: UNIQUE_TAG_COLOR,
  size_tag_color: SIZE_TAG_COLOR,
  alignement_tag_color: ALIGNEMENT_TAG_COLOR,
  tag_text_color: TAG_TEXT_COLOR,
  first_level_heading_color: FIRST_LEVEL_HEADING_COLOR,
  second_level_heading_color: SECOND_LEVEL_HEADING_COLOR,
  fourth_level_heading_background_color: FOURTH_LEVEL_HEADING_BACKGROUND_COLOR,
  notebox_background_color: NOTE_BACKGROUND_COLOR,
  rulebox_background_color: RULEBOX_BACKGROUND_COLOR,
  table_fill: TABLE_FILL,
  block_font: BLOCK_FONT,
  block_heading_font: BLOCK_HEADING_FONT,
  main_text_font: MAIN_TEXT_FONT,
  big_heading_font: BIG_HEADING_FONT,
  small_heading_font: SMALL_HEADING_FONT,
  center_cell_pattern: CENTER_CELL_PATTERN,
  normal_font_size: NORMAL_FONT_SIZE,
  block_font_size: BLOCK_FONT_SIZE,
  title_font_size: TITLE_HEADING_FONT_SIZE,
  subtitle_font_size: SUBTITLE_HEADING_FONT_SIZE,
  first_level_heading_font_size: FIRST_LEVEL_HEADING_FONT_SIZE,
  second_level_heading_font_size: SECOND_LEVEL_HEADING_FONT_SIZE,
  third_level_heading_font_size: THIRD_LEVEL_HEADING_FONT_SIZE,
  fourth_level_heading_font_size: FOURTH_LEVEL_HEADING_FONT_SIZE,
  fifth_level_heading_font_size: FIFTH_LEVEL_HEADING_FONT_SIZE,
  bloc_heading_font_size: BLOC_HEADING_FONT_SIZE,
  trait_font_size: TRAIT_FONT_SIZE,
  infobox_color: INFOBOX_COLOR,
  title_text_font_size: TITLE_TEXT_FONT_SIZE,
) = (
  accent: accent,
  tag_border_color: tag_border_color,
  tag_color: tag_color,
  uncommon_tag_color: uncommon_tag_color,
  rare_tag_color: rare_tag_color,
  unique_tag_color: unique_tag_color,
  size_tag_color: size_tag_color,
  alignement_tag_color: alignement_tag_color,
  tag_text_color: tag_text_color,
  first_level_heading_color: first_level_heading_color,
  second_level_heading_color: second_level_heading_color,
  fourth_level_heading_background_color: fourth_level_heading_background_color,
  notebox_background_color: notebox_background_color,
  rulebox_background_color: rulebox_background_color,
  table_fill: table_fill,
  block_font: block_font,
  main_text_font: main_text_font,
  big_heading_font: big_heading_font,
  small_heading_font: small_heading_font,
  center_cell_pattern: center_cell_pattern,
  normal_font_size: normal_font_size,
  block_font_size: block_font_size,
  block_heading_font: block_heading_font,
  title_font_size: title_font_size,
  subtitle_font_size: subtitle_font_size,
  first_level_heading_font_size: first_level_heading_font_size,
  second_level_heading_font_size: second_level_heading_font_size,
  third_level_heading_font_size: third_level_heading_font_size,
  fourth_level_heading_font_size: fourth_level_heading_font_size,
  fifth_level_heading_font_size: fifth_level_heading_font_size,
  bloc_heading_font_size: bloc_heading_font_size,
  trait_font_size: trait_font_size,
  infobox_color: infobox_color,
  title_text_font_size: title_text_font_size,
)
#let THEME = theme()

#let a = box(image("/rsrcs/imgs/single_action.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let aa = box(image("/rsrcs/imgs/double_action.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let aaa = box(image("/rsrcs/imgs/triple_action.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let r = box(image("/rsrcs/imgs/reaction.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let f = box(image("/rsrcs/imgs/free_action.png", height: 0.8em), inset: (x: 0pt), baseline: 10%)
#let L = 0.1
#let null = [---]

#let hr(fill: black) = {
  set block(above: 5pt, below: 5pt)
  line(length: 100%, stroke: fill)
}
#let vr(fill: black) = {
  line(start: (50%, 0%), end: (50%, 100%), stroke: fill)
}
#let floating(..body) = {
  place(auto, float: true, ..body)
}
#let full(..body) = place(auto, float: true, scope: "parent", block(width: 100%, ..body))
#let col(body) = columns(2, body)
#let exists(var) = {
  var != none and var != "" and var != [] and var != () and var != (:)
}
#let mark(h) = {
  set heading(outlined: true)
  h
}

#let split_args(..args, f: a => a) = {
  args
  .pos()
  .flatten()
  .filter(e => type(e) == str)
  .map(s => s.split(",").filter(it => it != none and it != ""))
  .flatten()
  .map(s => f(s.trim()))
}

// create the colored box around the tag ant typeset the name of the tag
#let print_trait(name, theme: THEME) = {
  if name == none {
    return none
  }
  set text(
    fill: theme.tag_text_color, 
    font: theme.block_heading_font, 
    weight: "bold",
    size: theme.trait_font_size
  )
  let tg = lower(name)
  let fill = if tg == "uncommon" {theme.uncommon_tag_color} else if tg == "rare" {theme.rare_tag_color} else if tg == "unique" {theme.unique_tag_color} else if tg in size_tag_list {theme.size_tag_color} else if tg in alignement_tag_list {theme.alignement_tag_color} else {theme.tag_color}
  box(
    rect(
      height: auto, 
      width: auto, 
      fill: fill, 
      stroke: (
        x: 3pt + theme.tag_border_color, 
        y: 2pt + theme.tag_border_color
      ),
      inset: (
        x: 0% + 6pt,
        y: 0% + 3pt
      ),
    )[#tg]
  )
}
#let trait_sorting_key(name) = {
  if name in rarity_tag_list {
    0
  } else if name in size_tag_list {
    1
  } else if name in alignement_tag_list {
    2
  } else {
    3
  }
}
#let split_traits(..strings) = {
  split_args(..strings, f: lower)
}
#let clean_list(list) = {
  let new_list = ()
  for it in list {
    let it2 = lower(it)
    if it2 not in new_list {
      new_list.push(it2)
    }
  }
  return new_list
}
// show a line of tags from a comma separated string or list of string
#let print_traits(..args, theme: THEME) = {
  let str_array = split_traits(..args)
  .sorted(key: trait_sorting_key);
  
  str_array.map(s => print_trait(s, theme: theme))
  .join()
}

#let itembox(name, body, actions: none, kind: none, level: none, traits: none, size: 100%, breakable: false, theme: THEME) = block(width: size, inset: (y: 0.3em), above: 1.2em, breakable: breakable,
  // heading
  {
    set par(justify: true)
    block(below: 0.5em,{
      show heading: it => {
        set text(
          font: theme.block_heading_font,
          size: theme.bloc_heading_font_size,
          fill: black,
          bottom-edge: 0.3em,
          top-edge: 0.3em,
        )
        set align(bottom)
        it
      }
      grid(
        columns: (auto, 1fr, auto),
        rows: (auto,),
        heading(
          depth: 1, 
          bookmarked: false, 
          outlined: false)[#name #actions],
        [],
        heading( 
          depth: 1, 
          bookmarked: false, 
          outlined: false)[#kind #level],
      )
      hr()
      print_traits(traits, theme: theme)
    }, breakable: false)
    set text(font: theme.block_font, size: theme.block_font_size)
    set terms(tight: true)
    //set block(spacing: 0em)
    //set par(spacing: 0.6em)
    body
  }
)

#let feature(name, level, theme: THEME, actions: none) = {
  set par(justify: true)
    block(below: 0.5em,{
      show heading: it => {
        set text(
          font: theme.block_heading_font,
          size: theme.bloc_heading_font_size,
          fill: black,
          bottom-edge: 0.3em,
          top-edge: 0.3em,
        )
        set align(bottom)
        it
      }
      grid(
        columns: (auto, 1fr, auto),
        rows: (auto,),
        heading(
          depth: 1, 
          bookmarked: false, 
          outlined: false)[#name #actions],
        [],
        heading( 
          depth: 1, 
          bookmarked: false, 
          outlined: false, level),
      )
    }, breakable: false)
}

#let notebox(..body, size: 100%, theme: THEME) = block(width: size, fill: theme.note_background_color, inset: 12pt, breakable: false, stroke: theme.accent,
  {
    set heading(bookmarked: false, outlined: false, offset: 0)
    show heading: head => {
      set text(font: theme.small_heading_font, weight: "black", fill: black)
      align(center)[#{if head.level == 1 {upper(head)} else {head}}]
    }
    set text(font: theme.block_font, size: theme.block_font_size)
    set align(left)
    body.pos().join()
  }
)

#let infobox(..body, size: 100%, theme: THEME) = block(width: size, fill: theme.infobox_color, inset: 12pt, breakable: false,
  {
    set heading(bookmarked: false, outlined: false, offset: 0)
    set text(fill: white)
    show heading: head => {
      set text(font: theme.small_heading_font, weight: "black", fill: white)
      align(left)[#{if head.level == 1 {upper(head)} else {head}}]
    }
    show heading.where(level: 2): set text(
      top-edge: 0pt
    )
    set text(font: theme.block_font, size: theme.block_font_size)
    set align(left)
    body.pos().join()
  }
)

#let rulebox(..body, size: 100%, theme: THEME) = block(width: size, fill: theme.rulebox_background_color, inset: 12pt, breakable: false,
  {
    set heading(bookmarked: false, outlined: false, offset: 0)
    set text(fill: black)
    show heading: head => {
      set text(font: theme.small_heading_font, weight: "black", fill: black)
      align(center)[#head]
    }
    show heading.where(level: 2): set text(
      top-edge: 0pt
    )
    set text(font: theme.block_font, size: theme.block_font_size)
    set align(left)
    body.pos().join()
  }
)

#let header(..body, theme: THEME) = {
  pagebreak()
  place(top, float: true, scope: "parent",
  block(width: 100%, fill: theme.notebox_background_color, inset: 12pt, breakable: false, stroke: (bottom: theme.accent + 2pt),
    {
      set heading(offset: 0)
      //show heading.where(level: 3).or(heading.where(level: 4)): set heading(outlined: false)
      set text(font: theme.main_text_font, style: "italic", weight: "black", fill: theme.first_level_heading_color, size: theme.title_text_font_size)
      show heading: head => {
        set text(fill: theme.first_level_heading_color, font: theme.big_heading_font)
        set block(spacing: 4pt)
        align(if calc.odd(head.level) {center} else {left})[#head]
      }
      show heading.where(level: 1): set text(size: theme.title_font_size)
      show heading.where(level: 2): set text(size: theme.title_font_size)
      show heading.where(level: 3): set text(size: theme.subtitle_font_size)
      show heading.where(level: 4): set text(size: theme.subtitle_font_size)
      set align(left)
      body.pos().join()
    }
  ))
}

#let sidebar_body(body, theme: THEME) = {
  set text(fill: theme.second_level_heading_color, font: theme.block_font, size: theme.block_font_size)
  set par(leading: 0.4em)
  //show par: it => block(inset: (left: 0.6em), it)
  set heading(outlined: false, bookmarked: false)
  set align(left)
  show heading: set text(font: theme.block_heading_font, fill: theme.second_level_heading_color)
  body
}
#let sidebar(body, bar_body) = {
  grid(
    columns: (2fr, 1fr),
    rows: 1,
    body,
    inset: 0.8em,
    grid.vline(),
    sidebar_body(bar_body),
  )
}

#let th(body) = {
  body
}

#let title_page(
  title,
  subtitle: none,
  authors: (),
) = {}

#let pf2e(body, cols: 1, theme: THEME, title: none, subtitle: none, authors: (), content_table: false, title_page: false) = {
  set page(
    paper: "us-letter",
    columns: cols,
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
    fill: (_, y) => if y == 0 {theme.accent} else {theme.table_fill.at(calc.rem(y, TABLE_FILL.len()))},
    stroke: none,
    align: left,
  )
  show table.cell: c => {
    set text(font: theme.block_font, size: theme.block_font_size)
    show CENTER_CELL_PATTERN: n => align(center)[#n]
    c
  }
  show table.cell.where(y: 0): set text(fill: white, weight: "bold")
  show table: set block()

  show ":a:": a
  show ":aa:": aa
  show ":aaa:": aaa
  show ":r:": r
  show ":f:": f

  if exists(title) and title_page {
    title_page
  }
  if content_table {
    set page(columns: 2)
    outline() 
  }

  let mk(object, short: auto, breakable: auto) = mk.with(theme: theme)
  
  body
}