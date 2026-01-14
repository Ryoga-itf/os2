#import "@preview/tenv:0.1.2": parse_dotenv
#let env = parse_dotenv(read(".env"))

#let font-serif = ("Noto Serif CJK JP")
#let font-sans = ("Noto Sans CJK JP")

#let date-format = "[year]年[month repr:numerical padding:none]月[day padding:none]日";

#let project(week: -1, date: datetime, body) = {
  let author = env.STUDENT_NAME
  let student-id = env.STUDENT_ID

  let title = "オペレーティングシステムII 課題" + str(week)
  set document(author: author, title: title)
  set text(font: font-serif, lang: "ja")
  set par(justify: true)

  show heading: set text(font: font-sans, weight: "medium")
  show heading.where(level: 2): it => pad(top: 1em, bottom: 0.4em, it)
  show heading.where(level: 3): it => pad(top: 1em, bottom: 0.4em, it)

  show figure: it => pad(y: 1em, it)
  show figure.caption: it => pad(top: 0.6em, it)
  show figure.caption: it => text(size: 0.8em, it)

  set page(
    numbering: "1",
    number-align: center,
    header: {
      block(
        width: 100%,
        stroke: (
          bottom: (thickness: 0.5pt),
        ),
        align(
          left,
          box(
            inset: (y: 30%),
            text(size: 9pt, [
                情報科学類 #title
                #h(1fr)
                学籍番号 #student-id
                名前 #author
                提出日 #date.display(date-format)
              ]
            ),
          ),
        ),
      )
    }
  )

  body
}
