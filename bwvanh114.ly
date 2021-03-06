\version "2.20.0"

\include "articulate.ly"

\header {
  title = "Minuet in G Major"
  composer = "Christian Petzold"
  opus = "BWV Anh. 114"
  style = "Baroque"
  source = "https://en.wikipedia.org/wiki/Minuets_in_G_major_and_G_minor"
  author = \markup \fromproperty #'header:composer
  subject = \markup \concat {
    "Piano partition for “"
    \fromproperty #'header:title
    "” ("
    \fromproperty #'header:opus
    ") by "
    \fromproperty #'header:composer
  }
  keywords = #(string-join '(
    "music"
    "partition"
    "piano"
    "harpsichord"
    "minuet"
  ) ", ")
  tagline = ##f
}

right = \relative c'' {
  \clef treble
  \time 3/4
  \key g \major

  \repeat volta 2 {
    d4  g,8 a b c |
    d4 g, g |
    e'  c8^\mordent d e fis |
    g4 g, g |
    c4^\mordent  d8 c b a | \break
    b4  c8 b a g |
    fis4  g8 a b g |
    \appoggiatura b8 a2. |
    d4  g,8 a b c |
    d4 g, g | \break
    e'4  c8\mordent d e fis |
    g4 g, g |
    c4\mordent  d8 c b a |
    b4  c8 b a g |
    a4  b8 a g fis |
    g2. |
  }

  \break

  \repeat volta 2 {
    b'4  g8 a b g |
    a4  d,8 e fis d |
    g4  e8 fis g d |
    cis4  b8 cis a4 |
    a8 b cis d e fis | \break
    g4 fis e |
    fis a, cis |
    d2. |
    d4  g,8 fis g4 |
    e'4  g,8 fis g4 | \break
    d'4 c b |
    a8 g fis g a4 |
    d,8 e fis g a b |
    c4 b^\prall a |
    b8 d g,4 fis |
    << { \stemUp g2. \stemNeutral }
      { \context Voice = "ii" { << \stemDown { <d b> } >> } }
    >> |
  }
}

left = \relative c' {
  \clef bass
  \time 3/4
  \key g \major

  \repeat volta 2 {
    <<
      { \stemUp { <b d>2 } \stemNeutral }
      { \context Voice = "ii" { << \stemDown g2 >> } }
    >> a4 |
    b2. |
    c2. |
    b2. |
    a2. |
    g2. |
    d'4 b g |
    d'  d,8 c' b a |
    b2 a4 |
    g b g |
    c2. |
    b4  c8 b a g |
    a2 fis4 |
    g2 b4 |
    c d d, |
    g2 g,4 |
  }

  \repeat volta 2 {
    g'2. |
    fis2. |
    e4 g e |
    a2 a,4 |
    a'2. |
    b4 d cis |
    d fis, a |
    d d, c'! |
    <<
      { \stemUp { r4 d2 } \stemNeutral }
      { \context Voice = "ii" { << \stemDown { b2 b4 } >> } }
    >> |
    <<
      { \stemUp { r4 e2 } \stemNeutral }
      { \context Voice = "ii" { << \stemDown { c2 c4 } >> } }
    >> |
    b4 a g |
    d'2 r4 |
    <<
      { \stemUp { r4 r f, } \stemNeutral }
      { \context Voice = "ii" { << \stemDown d2. >> } }
    >> |
    e4 g fis |
    g b, d |
    g d g, |
  }

  % Display two opposite \fermata signs over the last bar line
  % http://lsr.di.unimi.it/LSR/Item?id=10
  \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  \mark \markup \musicglyph #"scripts.ufermata"

  % The RehearsalMark in Staff is overriden, while not touching the one
  % from Score.
  \override Staff.RehearsalMark.direction = #DOWN
  \override Staff.RehearsalMark.rotation = #'(180 0 0)
}

pianoStaff = \new PianoStaff \with {
  midiInstrument = "harpsichord"
} <<
    \new Staff = "right" { \right }
    \new Staff = "left" \with { \consists "Mark_engraver" } { \left }
>>

\score {
  \pianoStaff
  \layout {}
}

\score {
  \unfoldRepeats \articulate \pianoStaff
  \midi {
    \tempo 4 = 140
  }
}
