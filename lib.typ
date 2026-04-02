#let report(
  title: "A Report Template",
  subtitle: "",
  authors: (
    (
      name: "John Doe",
      number: "123123123",
    ),
  ),
  font: "",
  font_size: 11pt,
  lang: "en",
  date: none,
  sans: true,
  cover_image: "",
  paper: "a4",
  doc,
) = {

  // metadata
  set document(title: title, author: authors.map(a => a.name))

  set text(
    font: 
      if (font != "") {
        font
      } else {
        if sans {"Liberation Sans"} else {"Libertinus Serif"}
      }
    ,
    size: font_size,
    lang: lang,

    ligatures: false
  )

  // COVER

  set page(
    numbering: none,
    paper: paper,
    margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm),
  )
  
  // TODO: verificar se há necessidade de colocar espaçamento de 1.5
  set par(
    first-line-indent: 1.5cm,
    justify: true,
    leading: 0.65em,
    linebreaks: "optimized",
  )

  set heading(numbering: "1.")
  set math.equation(numbering: "(1)")

  if cover_image != "" [
    #align(center)[
      #image("assets/" + cover_image, width: 10em)
    ]
  ]

  align(horizon + center)[
    #text(20pt, title, weight: "bold")
    #v(0.3em)
    #text(subtitle, weight: "regular")
  ]

  v(12em, weak: true)
  align(horizon + center)[
    #text(
      weight: "semibold",
      list(
        marker: "",
        body-indent: 0pt,
        ..authors.map(a => if a.number != none { [#columns(2, gutter: -10cm)[#a.name #colbreak() #a.number]] } else { a.name }),
      )
    )
  ]

  align(center + bottom)[#text(date)]

  pagebreak()

  // OTHER PAGES

  set footnote.entry(separator: none)
  show footnote.entry: set text(size: 0.8em, fill: rgb(0, 0, 0, 80%))

  let footer = context [
    #line(length: 100%)
    #set text(0.8em,)

    #grid(
      columns: (1fr, auto),
      align: (horizon + left, horizon + right),

      text(fill: rgb(0, 0, 0, 60%))[#title -- #subtitle],
      counter(page).display()
    )

  ]

  set page(
    footer: footer
  )

  show outline.entry.where(level: 1): it => {
    strong(it)
  }

  // TABLE OF CONTENTS
  // TODO: Verificar maneira melhor de alterar espaçamento entre titulo e corpo
  outline(title: [Table of Contents #v(1em)], indent: 2em)

  pagebreak()

  doc
}
