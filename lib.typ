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

  set page(
    numbering: "1",
    paper: "a4",
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
    #v(1em)
    #text(subtitle, weight: "regular")
  ]

  align(bottom + center)[
    #text(
      weight: "semibold",
      list(
        marker: "",
        body-indent: 0pt,
        ..authors.map(a => if a.number != none { [#a.name -- #a.number] } else { a.name }),
      )
    )

    #text(date)
  ]

  pagebreak()

  show outline.entry.where(level: 1): it => {
    strong(it)
  }

  // TODO: Verificar maneira melhor de alterar espaçamento entre titulo e corpo
  outline(title: [Sumário #v(1em)], indent: 2em)

  pagebreak()

  doc
}
