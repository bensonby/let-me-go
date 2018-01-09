#(load "swing.scm")
#(set-global-staff-size 13)
%add phrasing
%add dynamics
%add melody for non-words (start and end)
%add stem up/down issues on bass
%make glissando sign
%make left hand vs right hand display
%modify beginning's primo
%\pageBreak

shapeSlur =
  #(define-music-function (parser location offsets) (list?)
    #{
       \once \override Slur #'control-points = #(alter-curve $offsets)
    #})

#(define ((alter-curve offsets) grob)
   (let ((coords (ly:slur::calc-control-points grob)))

     (define (add-offsets coords offsets)
       (if (null? coords)
       '()
       (cons
   (cons (+ (caar coords) (car offsets))
         (+ (cdar coords) (cadr offsets)))
   (add-offsets (cdr coords) (cddr offsets)))))

     (add-offsets coords offsets)))

offsetPositions =
  #(define-music-function (parser location offsets) (pair?)
    #{
       \once \override Slur #'positions = #(lambda (grob)
   `(,(+ (car $offsets) (cdar (ly:slur::calc-control-points grob))) .
     ,(+ (cdr $offsets) (cdr (cadddr (ly:slur::calc-control-points grob))))))
    #})

melodya = \relative c'' {
  \clef treble \key c \major \time 4/4 \tempo 4 = 80
\set midiInstrument = #"pan flute"

  %\mark \default %A
  r4 g\f^"Freely" g g g f8 f4 e8 d f
  e4 f8 e~ e4 c8 c~ c f,4. r2
  %r4 g8 e g b d e g4 f8 e~ e c4 e8
  %e4 f8 d~ d d c c~ c d4.~ d4 r
  R1 R1 R1 R1

  %\mark \default %B
  \tempo 4 = 120
  \tripletFeel 8 {
  %r4 g8 \mark "Swing feel" g b g e g f e f a~ a g f g e4 f2 e8 c f, e f2.
  R1 R1 R1 R1
  r4 g8^"Swing" e g b d e g4 f8 e~ e c4 e8 e f4 c8~ c4 b8 c~ c2 r2
  }

  %\mark \default %C
  \tripletFeel 8 {
%  r4 a'8 g a4 g8 f g f e g~ g c, d e e f r d~ d d c d~ d e4. r2
%  r8 f e f~ f aes g f g g r e~( e d) c e~ e f d2. r2 r8 g, g g
   R1 R1 R1 R1 R1 R1 R1 r2 r8 g g g
  }

  %\mark \default %D
  \tripletFeel 8 {
  c8 c b c~ c4. d8 c g4 g8~ g g g g
  c c b c d e4 g8~
  g c,4. r8 c c c
  a' a g a~ a4 b8 c g ees( d) c~ c4 g'8 g~
  g c, c a c d e ees~ ees d r4 r2
  %\mark \default %E
  R1 R1 R1 R1
  r2 r4 c'8 b~ b g b c c b a c, c d~ \times 2/3 {d e f} g4 c8 g~
  g8 r8 r4 r2
  }

  \tripletFeel 8 {
  %\mark \default %F
    R1 R1 R1 R1
  %\mark \default %G
    R1 c8 aes4 aes8~ aes r r4 R1 R1
    r4 b,8 g b d fis g c4 aes8 g~ g e4 r8 R1 R1
  %\mark \default %H
    r4 g8 g b g e g f e f a~ a g f g e4 f8 e8~ e4. c8 f, e f2.
    r4 g8 e g b d e g4 f8 ees~( ees d) c8 e8 e4. f8 c4 b8 c~ c2 r2
  }

  %\mark \default %J
  \tripletFeel 8 {
%  r4 a'8 g a4 g8 f g f e g~ g c, d e e f r d~ d d c d~ d e4. r2
%  r8 f e f~ f aes g f g g r e~( e d) c e~ e f d2. r2 r8 g, g g
   R1 R1 R1 R1 R1 R1 R1 r2 r8 g g g
  }

  %\mark \default %K
  \tripletFeel 8 {
  c8 c b c~ c4. d8 c g4 g8~ g g g g
  c c b c d e4 g8~
  g c,4. r8 c c c
  a' a g a~ a4 b8 c g ees( d) c~ c4 g'8 g8~
  g c, c a c d e ees~ ees d r4 r2

  %\mark \default %L
  r2 r4 gis8 a~ a8 f e d r2 R1 R1 % e changed to ees?
  r2 r4 c'8 b~ b g b c c b a c, c d~ \times 2/3 {d e f} g4 c8 g~
  g8 d d e f e d d~ d c4. r2
  }

  %\mark \default %M
  R1 R1 R1 R1
  R1 R1 R1 R1
  R1
%  \compressFullBarRests R1*9

  %\mark \default %N
  \tempo 4 = 80
  \tripletFeel 8 {
  r4 a'8 gis a4 g8 f g f e g~ g c, d e e f r4 aes g8 f d4. e8~ e2
  r4 f8 e f aes~ \times 2/3 { aes8 g f } g4 g \times 2/3 {ees8( d) c~} c4 e8 f d2. r2 r8 g, g g
  }

  %\mark \default %O
  \tripletFeel 8 {
  g'8 g e f r4 g g8 d( c) b r b b b g' g e4 f8 g4 c8~ c e,4. r8 e e e
  c' c b4 c d e r8 c \times 2/3 {g8( f) ees} r8 c' c f, r f16 e fis8 g4 a8 b4. g8~
  g2
  }

  %\mark \default %P
  \tempo 4 = 120
  R1
  \tripletFeel 8 {
  r2 r4 gis8 a~ a8 f ees d r2 R1 R1 % e change to ees?
  r2 r4 c'8 b~ b g b c c b a c, c d~ \times 2/3 {d e f} g4 c8 g~
  g8 d d e f e d d~ d c4. r2
  }

  %\mark \default %Q
  \tempo 4 = 90
  R1 r2 r4 a'8 g~ g e g a e d c g a b c d e4 b' a8( g~) g2.
  \tempo 4 = 120
  \tripletFeel 8 {
  r8 d d e f g e d~ d c8 r4 r2 R1
  }
  \bar "|."
}

melodyb = \relative c'' {
  \clef treble \key c \major \time 4/4 \tempo 4 = 80
\set midiInstrument = #"flute"

  \mark \default %A
%  r4 g\f g g g f8 f4 e8 d f
%  e4 f8 e~ e4 c8 c~ c f,4. r2
  R1 R1 R1 R1
  r4 g,8\f^"Freely" e g b d e g4 f8 e~ e c4 e8
  e4 f8 d~ d d c c~ c d4.~ d4 r

  \mark \default %B
  \tempo 4 = 120
  \tripletFeel 8 {
  r4 g8^"Swing" g b g e g f e f a~ a g f g e4 f2 e8 c f, e f2.
  %r4 g8 e g b d e g4 f8 e~ e c4 e8 e f4 c8~ c4 b8 c~ c2 r2
  R1 R1 R1 R1
  }

  \mark \default %C
  \tripletFeel 8 {
  r4 a'8 gis a4 g8 f g f e g~ g c, d e e f r d~ d d c d~ d e4. r2
  r8 f e f~ f aes g f g g r e~( e d) c e~ e f d2. % r2 r8 g, g g
  R1
  }

  \mark \default %D
  \tripletFeel 8 {
  %c8 c b c~ c4. d8 c g4 g8~ g g g g
  %c c b c d e4 g8~
  %g c,4. r8 c c c
  r2 r4 r8 f e d4 d8~ d r r4
  r4 d8 e g a4 b8~ b g4. r2 %r8 c c c
  %a' a g a~ a4 b8 c g e d c~ c g'4 g8~
  %g c, c a c d e ees~ ees d r g, g g g c
  R1 R1 R1
  r4 r8 g, g g g c
  }
  \mark \default %E
  \tripletFeel 8 {
  d d c d~ d e4 d8~
  d b( a) g r g g c
  d4 r8 c e g4 d'8(~ d c4.) r8 a a b
  c b c d b4 a8 g~ g e g a e d c g a b~ \times 2/3 {b c d} e4 g8 d~
  d d d e f e d d~
  \mark \default %F
  d c4. r2
  }

  R1 R1 R1

  \mark \default %G
  \tripletFeel 8 {
    r4 r8 g' g g~ g4  g8 f4 f8~ f e8 d f
    e4 f8 e~ e4. c8 c4. f,8~ f4 r4
    r4 g8 e g b d e g4 f8 e~ e c4 e8
    e8 f4 d8~ d d c c~ c d4.~ d4 r
  }
  \mark \default %H
    R1 R1 R1 R1
    \tripletFeel 8 { R1 r2 r4 r8 g g4. aes8 f4 d8 e~ e2 r2 }


  \mark \default %J
  \tripletFeel 8 {
  r4 a8 gis a4 g8 f g f e g~ g c, d e e f r d~ d d( c4) d8 e4. r2
  r4 f8 e f aes g f g g r e~( e d) c e~ e f d2. % r2 r8 g, g g
  R1
  }

  \mark \default %K
  \tripletFeel 8 {
  %c8 c b c~ c4. d8 c g4 g8~ g g g g
  %c c b c d e4 g8~
  %g c,4. r8 c c c
  r2 r4 r8 f e d4 d8~ d r r4
  r4 d8 e g a4 b8~ b g4. r2 %r8 c c c
  %a' a g a~ a4 b8 c g e d c~ c g'4 g8~
  %g c, c a c d e ees~ ees d r g, g g g c
  R1 r2 r4 c4~ c4. c8~ c4. b8~ b4
  r8 g, g g g c
  }
  \mark \default %L
  \tripletFeel 8 {
  d d c4 d8 e4.
  d8 b( a) g r g g c
  d4 r8 c e g4 d'8(~ d c4.) r8 a a b
  c b c d b4 a8 g~ g e g a e d c g a b~ \times 2/3 {b c d} e4 g8 d~
  d d d e f e d d~
  \mark \default %M
  d c4. r2
  R1 R1 R1
  R1 R1 R1 R1
  R1 R1
%  \compressFullBarRests R1*9
  }

  \mark \default %N
  \tripletFeel 8 {
  c'1 b4. bes8~ bes2 a2 c d4. e8~ e2
  a,2 c e4 c \times 2/3 {g8( f) ees~} ees4 g8 a f2. r2 r8 g, g g
  }

  \mark \default %O
  \tripletFeel 8 {
  d'8 d c d r4 e d8 b( a) g r g g g d' d c4 d8 e4 g8~ g c,4. r8 c c c
  a' a g4 a b c r8 g \times 2/3 {ees8( d) c} r8 g' g c, r c16 a c8 d4 e8 ees4. d8~
  d2
  }

  \mark \default %P
  \tripletFeel 8 {
  r4 r8 g, g g g c8 d d c4 d8 e4.
  d8 b( a) g r g g c
  d4 r8 c e g4 d'8(~ d c4.) r8 a a b
  c b c d b4 a8 g~ g e g a e d c g a b~ \times 2/3 {b c d} e4 g8 d~
  d d d e f e d d~
  \mark \default %Q
  d c4. r2
  }

  r2 r8 a' a b c b c d b4 r4 R1 R1 R1
  \tripletFeel 8 {
  r8 d, d e f g e d~ d c8 r4 r2 R1
  }

  \bar "|."
}

lyricsa = \lyricmode {
  天 真 得 只 有 你 令 神 仙 魚 歸 天 要 怪 誰
  那 時 其 實 嚐 盡 真 正 自 由 但 又 感 到 沒 趣
  從 何 時 你 也 學 會 不 要 離 群 從 何 時 發 覺 沒 有 同 伴 不 行
  從 何 時 惋 惜 蝴 蝶 困 於 那 桃 源 飛 多 遠 有 誰 會 對 牠 操 心
  可 以 聚 腳 於 康 莊 旅 途 然 後 同 沐 浴 溫 泉
  好 去 處
  既 然 沿 著 尋 夢 之 旅 出 發
  逛 夠 幾 個 睡 房 到 達 教 堂 仿 似 一 路 飛 奔 七 八 十 歲
  既 然 沿 著 情 路 走 到 這 裡 盡 量 不 要 後 退
  從 何 時 你 也 學 會 不 要 離 群 從 何 時 發 覺 沒 有 同 伴 不 行
  從 何 時 惋 惜 蝴 蝶 困 於 那 桃 源 飛 多 遠 有 誰 會 對 牠 操 心
  滿 街 趕 路 人
  可 以 聚 腳 於 康 莊 旅 途 然 後 同 沐 浴 溫 泉
  為 何 在 雨 傘 外 獨 行
  親 愛 的 等 遍 所 有 綠 燈 還 是 讓 自 己 瘋 一 下 要 緊
  馬 路 戲 院 商 店 天 空 海 闊 任 你 行
  從 何 時 開 始 忌 諱 空 山 無 人 從 何 時 開 始 怕 遙 望 星 塵
  原 來 神 仙 魚 橫 渡 大 海 會 斷 魂 聽 不 到 世 人 愛 聽 的 福 音
  滿 街 趕 路 人
  可 以 聚 腳 於 康 莊 旅 途 然 後 同 沐 浴 溫 泉
  為 何 在 赤 地 上 獨 行
  可 以 任 我 走 怎 麼 到 頭 來 又 隨 著 大 隊 走
  人 群 是 那 麼 像 羊 群
}

lyricsb = \lyricmode {
  以 為 留 在 原 地 不 夠 遨 遊 就 讓 牠 沙 灘 裡 戲 水
  那 次 得 你 冒 險 半 夜 上 山 爭 拗 中 隊 友 不 想 撐 下 去
  不 要 緊 山 野 都 有 霧 燈 頑 童 亦 學 乖 不 敢 太 勇 敢
  世 上 有 多 少 個 繽 紛 樂 園 任 你 行
  不 要 離 群
  沒 有 同 伴 不 行
  曾 迷 途 才 怕 追 不 上 滿 街 趕 路 人 無 人 理 睬 如 何 求 生
  頑 童 大 了 沒 那 麼 笨 可 以 聚 腳 於 康 莊 旅 途 然 後 同 沐 浴 溫 泉
  為 何 在 雨 傘 外 獨 行
  這 麼 多 好 去 處 漫 遊 到 獨 家 村 去 探 誰
  既 然 沿 著 尋 夢 之 旅 出 發   就 站 出 點 吸 引 讚 許
  盡 量 不 要 後 退
  親 愛 的 闖 遍 所 有 路 燈 還 是 令 大 家 開 心 要 緊
  抱 住 兩 廳 雙 套 天 空 海 闊 任 你 行
  不 要 離 群
  沒 有 同 伴 不 行
  飛 多 遠
  曾 迷 途 才 怕 追 不 上 滿 街 趕 路 人 無 人 理 睬 如 何 求 生
  頑 童 大 了 沒 那 麼 笨 可 以 聚 腳 於 康 莊 旅 途 然 後 同 沐 浴 溫 泉
  為 何 在 雨 傘 外 獨 行
  woo - - - -
  要 緊
  woo -
  天 空 海 闊 任 你 行
  從 何 時 開 始 忌 諱 空 山 無 人 從 何 時 開 始 怕 遙 望 星 塵
  原 來 神 仙 魚 橫 渡 大 海 會 斷 魂 聽 不 到 世 人 愛 聽 的 福 音
  曾 迷 途 才 怕 追 不 上 滿 街 趕 路 人 無 人 理 睬 如 何 求 生
  頑 童 大 了 沒 那 麼 笨 可 以 聚 腳 於 康 莊 旅 途 然 後 同 沐 浴 溫 泉
  為 何 在 赤 地 上 獨 行
  頑 童 大 了 別 再 追 問
  人 群 是 那 麼 像 羊 群
}

pupper = \relative c' {
  \clef treble \key c \major \time 4/4

  \override Script #'padding = #2
  \mark \default %A
  \ottava #1
  <e' g c e g c e>1\arpeggio\mp
  <e a c f a e'>\arpeggio
  <c g' b e g b e>\arpeggio
  <c f a d a' e'>\arpeggio
  <d g b d g b e>\arpeggio
  <c e a e' g b e>\arpeggio
  <c f a e' g a e'>\arpeggio
  <d f a e' g bes des e>2~\arpeggio <d f a e' g b d>

  \mark \default %B
  R1 %<c g' b e>2
  R1 %<f c' e a>2
  <c g b e g b>2 \tripletFeel 8 {r8 <aes' b> <e g c>4}
  \ottava #0
  \times 2/3 {e'8 ees d des c b bes a aes} \tripletFeel 8 {g8 ges16 f}
  \tripletFeel 8 {e'8 e, d' d, c' c, b' b, c' c, r d' e e, g' g,}
  \tripletFeel 8 {<d f>4. <d f>8~ <d f>2} R1

  \mark \default %C
  \tripletFeel 8 {
  r4 a'8 b16 c cis8 d r4
  r4 g,8 a16 ais b8 c r4
  a8 f'4 < aes, f' >8~ < aes f' >2
  }
  \times 2/3 {e,8 g c e g b} \times 2/3 {d,, g bes c g' bes}
  \ottava #1
  \tripletFeel 8 {r2 e8 f16 aes b4
  r2 d,8 e16 fis a8 e'}
  \times 2/3 {f8 e d b d b bes a f d des c}
  \ottava #0
  %\tripletFeel 8 {< g fis'>8 < g fis'> < g fis'> < g g'>~ < g g'>2}
  \tripletFeel 8 {< g fis'>4. < g g'>8~ < g g'>2}

  \mark \default %D
  \tripletFeel 8 {
    g8 a b c~ c2
    r4 r8 d c bes aes g
    < g c>4. < g b>8~ < g b>2
    a8 aes ges f~ f2
    r2 c'8 b a gis
    g4. ees8 d c aes g
    r4 f'8 c' r4 fis,8 c'
    r4. ees8 \times 2/3 {d b g bes a f}
  }

  \mark \default %E
  \tripletFeel 8 {
    e4. g8~ g4 c d8 ais b g r4 fis8 f
    e4. g8~ g4 \times 2/3 {g'8 fis f} < g, e'>8 gis fis < ees a>~ < ees a>2
    < e c'>8 < e b'>4 < ees b'>8~ < ees b'>2
    < d a'>8 < b aes'>4 < c g'>8~ < c g'>2
    < f d'>2 < f e'>4 < aes f'>8 < g c d g>~ < g c d g>1
  }

  \mark \default %F
%    R1 R1 R1 R1
  \tripletFeel 8 {
    r8 c \acciaccatura fis16 g4 \times 2/3 { c,8 d dis e f g}
    aes8 b, c < aes fis'>~ < aes fis'>2
    \times 2/3 {r8 g' aes} < c, bes'>4 \times 2/3 {ges'8 f e dis cis b}
    R1
  }
  \mark \default %G
    R1 R1 R1 R1
    R1 R1 R1 R1

  \mark \default %H
  R1 %<c g' b e>2
  R1 %<f c' e a>2
  < c, g b e g b>2 \tripletFeel 8 {r8 <aes' b> <e g c>4}
  \ottava #0
  \times 2/3 {e'8 ees d des c b bes a aes} \tripletFeel 8 {g8 ges16 f}
  \tripletFeel 8 {e'8 e, d' d, c' c, b' b, c' c, r d' e e, g' g,}
  \tripletFeel 8 {<d f>4. <d f>8~ <d f>2} R1

  \mark \default %J
  \tripletFeel 8 {
  r4 a'8 b16 c cis8 d r4
  r4 g,8 a16 ais b8 c r4
  a8 f'4 < aes, f' >8~ < aes f' >2
  }
  \times 2/3 {e,8 g c e g b} \times 2/3 {d,, g bes c g' bes}
  \ottava #1
  \tripletFeel 8 {r2 e8 f16 aes b4
  r2 d,8 e16 fis a8 e'}
  \times 2/3 {f8 e d b d b bes a f d des c}
  \ottava #0
  %\tripletFeel 8 {< g fis'>8 < g fis'> < g fis'> < g g'>~ < g g'>2}
  \tripletFeel 8 {< g fis'>4. < g g'>8~ < g g'>2}

  \mark \default %K
  \ottava #1
  \tripletFeel 8 { e'8 f e f \times 2/3 {fis g e'~} e8 < gis, b >8
  < a c > r r4 r8 \times 2/3 {b16 c cis} d8 < b dis >
  < c e >4 g,8 aes b c~ \times 2/3 {c d e}
  g4 \times 2/3 {fis8 g a} b8 c~ \times 2/3 { c b c }
  a4. < aes, a'>8~ < aes a'> \times 2/3 { g16 aes c } g'8 f
  g4 g8 e r d c a
  d8 e d e \times 2/3 {g8 gis a~} a b a g fis g~ g f e d
  }

  \mark \default %L
  \tripletFeel 8 {
    b8 c dis e \times 2/3 {g aes b~} b8 c16 cis
    d4 r g,8 fis-> g f->
    e8 < bes c f >~ < bes c f > g'~ \times 2/3 { g gis a c d dis}
    e4. ees32 b g f e2
    gis8 a gis a~ a < c, b' >4.
    \times 2/3 {b'8 c d a c d} gis,8 < f gis d' >4.~
    \times 2/3 {< f gis d' >8  c' d } \acciaccatura dis16 e8 g~ g4 \times 2/3 {g8 fis f~} f8 < f, aes d >4.~ < f aes d >2
  }
  \ottava #0

  \mark \default %M
%  \tripletFeel 8 {
%   g8 f e c~ c aes g f e f4 g8~ g c,4.
%   g''8 f e c~ c \acciaccatura g16 aes8 g f e f4 g8~ g c4.
%   g'8 f e c~ c aes g f e f4 g8~ g c,4.
% }
%   a2 c d e g,16 a b c a b c d b c d e c d e f
%   g4 r4 r2

  \times 2/3 {
  f,,,8\pp a e' c' e a \ottava #1 f' g a c d dis
  e c a g e c \ottava #0 e, c g c, a g
  f aes c aes' f' aes \ottava #1 d f aes b c cis
  d c aes g d aes \ottava #0 d, des c aes g d
  f,8 a e' c' e a \ottava #1 f' g a c d dis
  e c a g e c \ottava #0 e, c g c, a g
  }
  a''2 c d e
  g,,16_"rit. "\mp a b c a b c d b c d e c d e f
  g4 < g, b ees> < g b d> < g bes des>


  \mark \default %N
  \tripletFeel 8 {
  r4 a'8 b16 c cis8 d r4
  r4 g,8 a16 ais b8 c r4
  a8 f'4 < aes, f' >8~ < aes f' >2
  }
  \times 2/3 {e,8 g c e g b} \times 2/3 {d,, g bes c g' bes}
  \ottava #1
  \tripletFeel 8 {r2 e8 f16 aes b4
  r2 d,8 e16 fis a8 e'}
  \times 2/3 {f8 e d bes d c bes g f d des c}
  \ottava #0
  %\tripletFeel 8 {< g fis'>8 < g fis'> < g fis'> < g g'>~ < g g'>2}
  \tripletFeel 8 {< g fis'>4. < g g'>8~ < g g'>2}

  \mark \default %O
  \tripletFeel 8 {
  g8 c, \times 2/3 {d8 e fis} \times 2/3 { g gis a} c4
  r2 d8 e,16 f \times 2/3 {fis8 g a} bes4 c8 bes~ bes2
  \times 2/3 {f16 g gis a c d }  e4 bes8 a16 aes g4
  r2 \times 2/3 {f16 g gis a b c} g'8 fis16 f e4. c16 d ees8 d16 c \times 2/3 {a8 gis g}
  f8 \times 2/3 {g16 a b} c4 fis,8 \times 2/3 {g16 a b} c4
  \times 2/3 {g,,16 a b cis dis f g a b cis dis f g a b cis dis f~} f4
  }

  \mark \default %P
  R1
  \ottava #1
  \tripletFeel 8 {
    b,8 c dis e \times 2/3 {g aes b~} b8 c16 cis
    d4 r g,8 fis-> g f->
    e8 < bes c f >~ < bes c f > g'~ \times 2/3 { g gis a c d dis}
    e4. ees32 b g f e2
    gis8 a gis a~ a < c, b' >4.
    \times 2/3 {b'8 c d a c d} gis,8 < f gis d' >4.~
    \times 2/3 {< f gis d' >8  c' d } \acciaccatura dis16 e8 g~ g4 \times 2/3 {g8 fis f~} f8 < f, aes d >4.~ < f aes d >2
  }
  \ottava #0

  \mark \default %Q
  R1
  \times 2/3 {c,,16 ees fis a c ees fis a \ottava #1 c ees fis a} c16 ees fis a~ a4
  \ottava #0
  < a,,, e'>1 < g e'>2 < g c> < a e'>1 << { ees'2 d } \\ { g,1 } >>
  R1 \tripletFeel 8 { c'8 bes aes ges r e d des} c r r4 r2
  \bar "|."
}

plower = \relative c' {
  \clef treble \key c \major \time 4/4

  \override ParenthesesItem #'font-size = #-2
  \override TextScript #'staff-padding = #2

  \mark \default %A
  R1\mp R1 R1 R1 R1 R1 R1 R1
  \mark \default %B
  R1 R1 R1 R1 R1 R1 R1 R1
  \mark \default %C
  \tripletFeel 8 {
  <a' c e f>1 <g b d e>
  f8 <g a>4 < f aes >8~ < f aes>2
  s1
  }
  \tripletFeel 8 {
  r2 f8 aes16 b d4
  r2 e8 fis16 a < c ees>4
  }
  \times 2/3 {f8 e d b d b bes a f d des c}
  \tripletFeel 8 { b8 c cis d~ d2  }

  \mark \default %D
  \tripletFeel 8 {
    < g, b e>1 < g bes e>1 < a e'>1 c4. < a c>8~ < a c>2
    r4 r8 < f e'>~ < f e'>2 < g ees'>4. < fis a>8~ < fis a>2
    r4 f8 c' r4 fis,8 c'
    < f, aes d>1
  }

  \mark \default %E
  \tripletFeel 8 {
    r4 r8 < g b>~ < g b> g < c g'> < a g'>
    < b g'>4. < fis b>8~ < fis b>2
    r8 g f'2 \times 2/3 {d8 c bes} < e, a>4. < ees a>8~ < ees a>2
    c'8 b4 b8~ b2  a8 aes4 g8~ g2
    < d c'>2 < a' c>4 aes8 g~ g1
  }

  \mark \default %F
    R1 R1 R1 R1
  \mark \default %G
    R1 R1 R1 R1
    R1 R1 R1 R1

  \mark \default %H
  \clef bass
  <c,, b'>1 <f e'> <c d'> <f, e'>
  R1 R1 R1 R1
  \mark \default %J
  \tripletFeel 8 {
  \clef treble
  < a'' c e f>1 <g b d e>
  f8 <g a>4 < f aes >8~ < f aes>2
  s1
  }
  \tripletFeel 8 {
  r2 f8 aes16 b d4
  r2 e8 fis16 a < c ees>4
  }
  \times 2/3 {f8 e d b d b bes a f d des c}
  \tripletFeel 8 { b8 c cis d~ d2  }

  \mark \default %K
  \tripletFeel 8 { e8 f e f \times 2/3 {fis g e'~} e8 < gis, b >8
  < a c > r r4 r8 \times 2/3 {b16 c cis} d8 < b dis >
  < c e >4 g,8 aes b c~ \times 2/3 {c d e}
  g4 \times 2/3 {fis8 g a} b8 c~ \times 2/3 { c b c }
  a4. < aes, a'>8~ < aes a'> \times 2/3 { g16 aes c } g'8 f
  g4 g8 e r d c a
  d8 e d e \times 2/3 {g8 gis a~} a b a g fis g~ g f e d
  }

  \mark \default %L
  \tripletFeel 8 {
    b8 c dis e \times 2/3 {g aes b~} b8 c16 cis
    d4 r g,8 fis-> g f->
    e8 < bes c f >~ < bes c f > g'~ \times 2/3 { g gis a c d dis}
    e4. ees32 b g f e2
    gis8 a gis a~ a < c, b' >4.
    \times 2/3 {b'8 c d a c d} gis,8 < f gis d' >4.~
    \times 2/3 {< f gis d' >8  c' d } \acciaccatura dis16 e8 g~ g4 \times 2/3 {g8 fis f~} f8 < f, aes d >4.~ < f aes d >2
  }

  \mark \default %M
  R1 R1 R1 R1
  R1 R1 a,2 c d e
  R1 R1

  \mark \default %N
  \tripletFeel 8 {
  <a, c e f>1 <g b d e>
  f8 <g a>4 < f aes >8~ < f aes>2
  s1
  }
  \tripletFeel 8 {
  r2 f8 aes16 b d4
  r2 e8 fis16 a < c ees>4
  }
  \times 2/3 {f8 e d bes d c bes g f d des c}
  \tripletFeel 8 { b8 c cis d~ d2  }

  \mark \default %O
  \tripletFeel 8 {
    r4 r8 d \acciaccatura dis16 < g, b e>8  < g b g'>4.
    r8 < b d a'>4 < b d e g>8~ < b d e g>2
    r4 r8 d \acciaccatura dis16 < g, bes e>8  < g bes g'>4.
    r4 < f c'>8 < g c>~  < g c>4 \times 2/3 { r8 < g a c fis> < g a c f> }
    R1
    r8 \acciaccatura ais16 < g b>4. r8 < ees f c'>4.
    f8 \times 2/3 {g16 a b} c4 fis,8 \times 2/3 {g16 a b} c4
    R1
  }

  \mark \default %P
  R1
  \tripletFeel 8 {
    b8 c dis e \times 2/3 {g aes b~} b8 c16 cis
    d4 r g,8 fis-> g f->
    e8 < bes c f >~ < bes c f > g'~ \times 2/3 { g gis a c d dis}
    e4. ees32 b g f e2
    gis8 a gis a~ a < c, b' >4.
    \times 2/3 {b'8 c d a c d} gis,8 < f gis d' >4.~
    \times 2/3 {< f gis d' >8  c' d } \acciaccatura dis16 e8 g~ g4 \times 2/3 {g8 fis f~} f8 < f, aes d >4.~ < f aes d >2
  }

  \mark \default %Q
  %aes,, g2 ges
  \tripletFeel 8 { aes8 f fis g~ g ees \times 2/3 {e f fis~} fis1 }
  \clef bass
  f,,1 e2 a d1 g,1
  R1 \clef treble \tripletFeel 8 { c'8 bes aes ges r e d des} c r r4 r2

  \bar "|."

}

supper = \relative c' {
  \clef treble \key c \major \time 4/4
  \override Script #'padding = #2
  \set fingeringOrientations = #'(up)

  %\mark \default %A
  R1\mp R1 R1 R1 R1 R1 R1 R1

  %\mark \default %B
  \tripletFeel 8 {
  r8 e g <d' e>~ <d e>2
  r8 c, f <a e'>~ <a e'>2
  r8 e g <d' e>~ <d e>2
  r4 <e,, c'>8 <e' g>~ <e g>2
  r8 <b d g>4. r8 <g' d' e>4.
  r8 ees e4 r8 <b g'>4.
  r4 r8 <f' aes>~ <f aes>2
  r4 <ees b'>8 <e c'> r2
  }

  %\mark \default %C

  \tripletFeel 8 {
  r8 e4.~ e2
  r8 b d < bes des g >~ < bes des g >2
  r8 f c' < aes c >~ < aes c>4 g
  r8 c < e b' >4 r8 < c g' >4.
  }

  \times 2/3 {r8 f, c' f4 a8} r2
  \times 2/3 {r8 e, c' e4 g8} r2
  \tripletFeel 8 {r8 < c, e a > r < c a'> r < c d f a>4.
  g8 < g b>4 < g b f'>8~ < g b f'>2
  }

  %\mark \default %D
  \tripletFeel 8 {
    r4 r8 < g b>~ < g b> g < c g'> < b g'>
    < bes g'>4. < g c f>8~ < g c f>2
    r8 g e'2 \times 2/3 {c8 b a} < g c>4. < g c>8~ < g c>4. < fis c'>8
    \clef bass e'8 c g < f a>~ < f a>4. gis8
    g < g c>4 < fis c'>8~ < fis c'>2
    < d g>8 a' c < fis, a e'>~ < g a e'>4. < a c ees fis>8~ < aes c f>4. \appoggiatura dis16 < a c e>8~ < a c e>2
  }

  %\mark \default %E
  \tripletFeel 8 {
    g8 a b d~ d2
    r4 r8 d c b a g
    < f c'>4. < g c>8~ < g c>2
    a8 aes ges f~ f2
    r2 ees8 g f dis e4. < g d'>8~ < g d'>2
    r8 f < f c'> < aes f'>~ < aes f'>2
    r8 < b d aes'>8~ < b d aes'>2.
  }

  %\mark \default %F
  \tripletFeel 8 {
    < g bes c ees>4. < g bes c ees>8~ < g bes c ees>4. < ges aes c ees>8~ < ges aes c ees>1
    < f aes c ees>4. < f aes c ees>8~ < f aes c ees>4. < e gis b dis>8~ < e gis b dis>1
  }

  %\mark \default %G
  \tripletFeel 8 {
    < aes c ees g>4 r4 r2 < aes c d fis>4 r8 < aes b d f>~ < aes b d f>2
    r8 < g b c e> r4 r8 c < fis, a c d>4
    r8 gis < a c e f>8 < a c e f>~ < a c e f>2
    r8 < b d e g>4. r8 < d e gis b>4.
    r4 < a c e g>8 < g a c> r < aes c e>4.
    r4 r8 < d, f a bes>~ < d f a bes>4 r8 fis' g4 < ais, cis>8 < b d>~ < b d>2
  }

  %\mark \default %H
  \tripletFeel 8 {
  \clef treble
  r8 e g <d' e>~ <d e>2
  r8 c, f <a e'>~ <a e'>2
  r8 e g <d' e>~ <d e>2
  r4 <e,, c'>8 <e' g>~ <e g>2
  r8 <b d g>4. r8 <g' d' e>4.
  r8 ees e4 r8 <b g'>4.
  r4 r8 <f' aes>~ <f aes>2
  r4 <ees b'>8 <e c'> r2
  }

  %\mark \default %J

  \tripletFeel 8 {
  r8 e4.~ e2
  r8 b d < bes des g >~ < bes des g >2
  r8 f c' < aes c >~ < aes c>4 g
  r8 c < e b' >4 r8 < c g' >4.
  }

  \times 2/3 {r8 f, c' f4 a8} r2
  \times 2/3 {r8 e, c' e4 g8} r2
  \tripletFeel 8 {r8 < c, e a > r < c a'> r < c d f a>4.
  g8 < g b>4 < g b f'>8~ < g b f'>2
  }

  %\mark \default %K
  \tripletFeel 8 {
  \clef bass
  < b e > 4 < c f > < d g > < e a >
  < d g > r8 < ais cis> < b d >4 r
  < g c > < a d > < b e > < c f >
  < d f > < d g > < e a > < g bes >
  < a, c e >1
  r8 < b d g >4 < bes des e >8 r < aes d > < g c > < fis c' >~
  < f g c >4 < fis c' > < g c > < fis c' >8 < ais cis >8~
  < ais cis >8 < b d>4. r2
  }
  %\mark \default %L
  \tripletFeel 8 {
  < b e > 4 < c f > < d g > < e a >
  < d g > r8 < ais cis> < b d >4 r
  < c f > < c f > < d g > < e a >
  < d, g b >8 < e g c > < f a dis > < g b e >~ < g b e >2
  \clef treble
  <a e' >4 <a e' > <d fis >8 <dis fis >4. <e b' >4 <e b' > <f b > <f b >8 <g c>~
  < g c >4 < c g' > < bes e > < g bes des >8 < g c d >~ < g c d > < g d' >~ < g d' >2.
  }

  \mark \default %M
  \tripletFeel 8 {
    g''8 f e c~ c aes g f e f4 g8~ g c,4.
    g''8 f e c~ c \acciaccatura g16 aes8 g f e f4 g8~ g c4. \grace { a32 b c d e f}
    g8 f e c~ c aes g f e f4 g8~ g c,4.
    \clef bass r8 f,, < a c>4 < f e'>8 < a f'>4.
    r8 \acciaccatura dis,8 e f g < f a>4~ < f aes>
    g1 R1
  }

%    g,16 a b c a b c d b c d e c d e f
%    g4 < g, b ees> < g b d> < g bes des>
%  \clef bass
%  \tripletFeel 8 {
%  r4 a,8 < b e>~ < b e>2
%  r4 g8 < a c>~ < a c>2
%  r4 f8 < aes c>~ < aes c>2
%  r8 d, f < aes c>~ < aes c>2
%  r4 a8 < b e>~ < b e>2
%  r4 g8 < a c>~ < a c>2
%  f8 < a c>4. < f e'>8 < a f'>4.
%  r8 e f g < f a>2
%  R1 g'4 ees d des
%  }

  \mark \default %N
  \tripletFeel 8 {
  \clef treble
  r8 e'4.~ e2
  r8 b d < bes des g >~ < bes des g >2
  r8 f c' < aes c >~ < aes c>4 g
  r8 c < e b' >4 r8 < c g' >4.
  }

  \times 2/3 {r8 f, c' f4 a8} r2
  \times 2/3 {r8 e, c' e4 g8} r2
  \tripletFeel 8 {r8 < c, d f a > r < c a'> r < c d f a>4.
  g8 < g b>4 < g b f'>8~ < g b f'>2
  }

  \mark \default %O
  \tripletFeel 8 {
    \clef bass < e g a d>4 < e c'>8 < e g a d>~ < e g a d>2
    < d g a d>4 < d b'>8 < d g a d>~ < d g a d>2
    < d g a d>4 < d a' c>8 < d g a d>~ < d g a d>2
    < e f a c>8 e~ < e f a c>4 < e f a c>8 e~ < e f a c>4
    < f a c e>8 f~ < f a f'> < f a c e>~ < f a c e>2
    < e g b d>8 e~ < e g b>4 < ees g a c>4 < ees g a>8 b
    < d g a c>4 < d g a>8 < d g a c>~ < d g a c>4 < d g a d>8 e'
    < g, b ees>1
  }

  \mark \default %P
  %< g b ees>4 < g a c f> < a b d fis> < g b ees g>
  R1
  \tripletFeel 8 {
  < b e > 4 < c f > < d g > < e a >
  < d g > r8 < ais cis> < b d >4 r
  < c f > < c f > < d g > < e a >
  < d, g b >8 < e g c > < f a dis > < g b e >~ < g b e >2
  \clef treble
  <a e' >4 <a e' > <d fis >8 <dis fis >4. <e b' >4 <e b' > <f b > <f b >8 <g c>~
  < g c >4 < c g' > < bes e > < g bes des >8 < g c d >~ < g c d > < g d' >~ < g d' >2.
  }

  \mark \default %Q
  \tripletFeel 8 {
  < aes c ees>4. < g c ees>8~ < g c ees>4. < fis c' ees>8~ < fis c' ees>1
  R1 R1 R1 R1
  R1 R1
  \clef bass r4 r8 < e, g a d>8~ <e g a d>2
  }
  \bar "|."
}

slower = \relative c' {
  \clef bass \key c \major \time 4/4
  \override Script #'padding = #2

  %\mark \default %A
  c1\mp f c f, e a d g,2. g,4

  %\mark \default %B
  <c b'>1 <f e'> <c d'> <f, e'>
  e2 \tripletFeel 8 {g4. e8 a4 a, b c8 cis d4. g8~ g2 c,8 g' c4 r8 c,} \times 2/3 {cis8 d e}

  %\mark \default %C
  \tripletFeel 8 {f1 e4. ees8~ ees2 d4. g8~ g2 c2 bes
  a2 aes' g, ges' f,4. f'8 bes,2 g1}

  %\mark \default %D
  \tripletFeel 8 {
    c1 bes1 a1 aes4. g8~ g4. ges8
    f2. r8 e ees1 d4. fis8~ fis4. g8~ g1
  }

  %\mark \default %E
  \tripletFeel 8 {
    c1 b bes a f2 g2 e4. a8~ a2
    d2. aes8 g g,1
  }

  %\mark \default %F
  \tripletFeel 8 {
    < aes aes'>4. < aes aes'>8~ < aes aes'>4. < ges ges'>8~ < ges ges'>1
    < f f'>4. < f f'>8~ < f f'>4. < e e'>8~ < e e'>1
  }

  %\mark \default %G
  \tripletFeel 8 {
    < aes aes'>4 r4 r2 < d d'>4 r8 < g, g'>~ < g g'>2
    \ottava #-1
    c,4 e g fis f c' a f
    e f g gis a e' c b
    bes d, f aes8 fis g4 d' bes8 g b g
  }

  %\mark \default %H
  %<c' b'>1 <f e'> <c d'> <f, e'>
  %e2
  \tripletFeel 8 {
%g4. e8 a4 a, b c8 cis d4. g8~ g2 c,8 g' c4 r8 c,} \times 2/3 {cis8 d e}

  c4 c' g e f8 f, aes4 bes b c cis d e f f,8 c' f e d c b4 e, f  gis a e c \times 2/3 {a8 b cis} d4. g8~ g a bes b c4 c, d e
  }

  %\mark \default %J
  \tripletFeel 8 {
  %f1 e4. ees8~ ees2 d4. g8~ g2 c2 bes
  %a2 aes' g, ges' f,4. f'8 bes,2 g1

  f4 a c f8 f, e4 b' e ees d e8 f g4 \times 2/3 {g,8 a b} c8 c' g bes,~ bes d f bes
  a4 a, aes aes' g8 c, g fis~ fis d e fis f4 d'8 c bes4 a g g'8 ees d c aes g
  }

  %\mark \default %K
  \tripletFeel 8 {c4 d e f g d b g a b c d ees e fis e
  f, e' b8 a g f e4 bes'8 a-> r f e ees d4 d' a \times 2/3 {d,8 e fis}
  g4 gis a b
  }
  %\mark \default %L
  \tripletFeel 8 {c4 d e f g d b g bes f' e d8 gis, a4 c, d e
  f f fis8 fis4. g4 g gis gis8 a~ a4 bes b \times 2/3 {c8 cis d~} d < g, g'>~ < g g'>2.
  }

  %\mark \default %M
  \ottava #0
  <<
  {
    \tripletFeel 8 {
    r4 a''8 < b e>~ < b e>2
    r4 g8 < a c>~ < a c>2
    r4 f8 < aes c>~ < aes c>2
    r8 d, f < aes c>~ < aes c>2
    r4 a8 < b e>~ < b e>2
    r4 g8 < a c>~ < a c>2
%    f8 < a c>4. < f e'>8 < a f'>4.
%    r8 e f g < f a>2
%    R1 g'4 ees d des
    }
  } \\ {
    f,1 e d g f e
  } >>
  d2.~ d8 c bes1
  g1 g'2. e4

  %\mark \default %N
  \tripletFeel 8 {f1 e4. ees8~ ees2 d4. g8~ g2 c2 bes
  a2 aes g ges < bes, bes'>2 bes'4 f8 fis g4.~ < g, g'>8~ < g g'>2 }

  %\mark \default %O
  \tripletFeel 8 {
  c8~ < c c'>8~ < c c'>2 c'8 c,
  b8~ < b b'>8~ < b b'>2 < b b'>4
  < bes bes'>8 bes'~ bes2 bes8 bes,
  a8~ < a a'>4 a8 g~ < g g'>4 g8
  f8~ < f f'>8~ < f f'>2 f'8 f,
  e8~ < e e'>4 e8 ees~ < ees ees'>4 ees8
  < d d'>2 < fis fis'>4 fis'8 fis,
  < g g'>1
  }

  %\mark \default %P
  g'4\glissando g, a b
  \tripletFeel 8 {c4 d e f g d b g bes f' e d8 gis, a4 \ottava #-1 c, d e
  f f fis8 fis4. g4 g gis gis8 a~ a4 bes b \times 2/3 {c8 cis d~} d < g, g'>~ <g g'>2.
  }

  %\mark \default %Q
  \ottava #0
  \tripletFeel 8 { < aes aes'>4. <g g'>8~ <g g'>4. < ges ges'>8~ < ges ges'>1 }
  R1 R1 R1 R1
  < g g'>8 r r4 r2 < c, c'>8 r r4 r2 r4 < c c'>2.

  \bar "|."
}


pdynamics = {


}

sdynamics = {
}

\paper {
  print-first-page-number = ##t
  oddHeaderMarkup = \markup \fill-line { " " }
  evenHeaderMarkup = \markup \fill-line { " " }
  oddFooterMarkup = \markup { \fill-line {
    \bold \fontsize #3 \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string } }
  evenFooterMarkup = \markup { \fill-line {
    \bold \fontsize #3 \on-the-fly #print-page-number-check-first
    \fromproperty # 'page:page-number-string } }
}

\header {
  title = \markup \center-align { "任我行" }
  subtitle = "for JIBA Double Duo"
  arranger = \markup { "Arrangement by Benson" }
}

\score {
  \new Score \with {
%    \override NonMusicalPaperColumn #'page-break-permission = ##f
  }
  \new StaffGroup <<
    \new Voice = "melodya" \melodya <<
%      \set Staff.instrumentName = #"Voice  "
%      \set Staff.midiInstrument = #"pan flute"
% \set Staff.fontSize = #-2
% \override StaffSymbol #'staff-space = #(magstep -3)

    >>
    \context Lyrics = "sopranolyrics" { \lyricsto "melodya" { \lyricsa } }
    \new Voice = "melodyb" \melodyb <<
%      \set Staff.instrumentName = #"Voice  "
%      \set Staff.midiInstrument = #"recorder"
    >>
    \context Lyrics = "tenorlyrics" { \lyricsto "melodyb" { \lyricsb } }

    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Primo  "
      \new Staff = "pupper" \pupper {
        \set Staff.midiMinimumVolume = #0.4
        \set Staff.midiMaximumVolume = #0.6
      }
      \new Dynamics = "pdynamics" \pdynamics
      \new Staff = "plower" \plower {
        \set Staff.midiMinimumVolume = #0.4
        \set Staff.midiMaximumVolume = #0.6
      }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Secondo  "
      \new Staff = "supper" \supper {
        \set Staff.midiMinimumVolume = #0.4
        \set Staff.midiMaximumVolume = #0.6
      }
      \new Dynamics = "sdynamics" \sdynamics
      \new Staff = "slower" \slower {
        \set Staff.midiMinimumVolume = #0.4
        \set Staff.midiMaximumVolume = #0.6
      }
    >>
  >>
  \layout {
    \context {
      \type "Engraver_group"
      \name Dynamics
      \alias Voice
      \consists "Output_property_engraver"
%      \consists "Piano_pedal_engraver"
      \consists "Script_engraver"
      \consists "New_dynamic_engraver"
      \consists "Dynamic_align_engraver"
      \consists "Text_engraver"
      \consists "Skip_event_swallow_translator"
      \consists "Axis_group_engraver"

      \override DynamicLineSpanner #'Y-offset = #0
      \override TextScript #'font-size = #2
      \override TextScript #'font-shape = #'italic
      \override VerticalAxisGroup #'minimum-Y-extent = #'(-1 . 1)
    }
    \context {
      \PianoStaff
      \accepts Dynamics
    }
  }
  \midi {
    \context {
      \Staff
      \remove "Staff_performer"
    }
    \context {
      \Voice
      \consists "Staff_performer"
    }
  }
}
