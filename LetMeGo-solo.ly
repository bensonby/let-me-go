\version "2.18.2"
#(load "swing.scm")
#(set-global-staff-size 13)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

makeOctaves = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

cr = \change Staff = "right"
cl = \change Staff = "left"

melody = \relative c'' {
  \clef treble \key c \major \time 4/4 \tempo 4 = 80

  \mark \default %A
  r4 g^"Freely"\( g g g f8 f~ f\) e\( d f
  e4 f8 e~ e4 c8 c~ c f,4.\) r2
  r4 g8\( e g b d e g4 f8 e~ e c4\) e8\(
  e4 f8 d~ d d c c~ c d4.~ d4\) r

  \mark \default %B
  \tempo 4 = 120
  \tripletFeel 8 {
  r4 g8^"Swing"\( g b g e g f e f a~ a\) g\( f g e4 f2\) e8\( c f, e f2.\)
  r4 g8\( e g b d e g4 f8 e~ e c4\) e8\( e f4 c8~ c4 b8 c~ c2\) r2
  }

  \mark \default %C
  \tripletFeel 8 {
  r4 a'8\( gis a4\) g8\( f g f e g~ g\) c,\( d e e f\) r d~\( d d c4 d8 e8~ e4\) r2
  r8 f\( e f~ f aes g f g g r e~( e d) c\) e~\( e f d2.\) r2 r8 g,\( g g
  }

  \mark \default %D
  \tripletFeel 8 {
  c8 c b c~ c4. d8 c g4 g8~ g\) g\( g g
  c c b c d e4 g8~
  g c,4.\) r8 c\( c c
  a' a g a~ a4 b8 c g ees( d) c~ c4\) g'8\( g~
  g c, c a c d e ees~ ees d\) % r4 r2
  r8 g,\( g g g c
  }
  \mark \default %E
  \tripletFeel 8 {
  d d c4 d8 e4.
  d8 b( a) g\) r g\( g c
  d4 r8 c e g4 d'8(~ d c4.)\) r8 a\( a b
  c b c d b4\) a8\( g~ g e g a e d c g a b~ b\) c\( d e g d~
  d\) d\( d e f e d d~
  \mark \default %F
  d c4.\) r2
  }

  R1 R1 R1

  \mark \default %G
  \tripletFeel 8 {
    r4 r8 g'\( g g~ g4  g8 f4 f8~ f\) e8\( d f
    e4 f e4. c8 c4. f,8~ f4\) r4
    r4 g8\( e g b d e g4 f8 e~ e c4\) e8\(
    e8 f4 d8~ d d c c~ c d4.~ d4\) r
  }
  \mark \default %H
  \tripletFeel 8 {
    r4 g8\( g b g e g f e f a~ a\) g\( f g e4 f e4. c8 f, e f2.\)
    r4 g8\( e g b d e g4 f8 ees~( ees d) c8\) e8\( e4. f8 c4 b8 c~ c2\) r2
  }

  \mark \default %J
  \tripletFeel 8 {
  r4 a'8\( gis a4 g8 f g f e g~ g\) c,\( d e e f r d~ d d( c4) d8 e4.\) r2
  r4 f8\( e f aes g f g g r e~( e d) c\) e~\( e f d2.\) r2 r8 g,\( g g
  }

  \mark \default %K
  \tripletFeel 8 {
  c8 c b c~ c4. d8 c g4 g8~ g\) g\( g g
  c c b c d e4 g8~
  g c,4.\) r8 c\( c c
  a' a g a~ a4 b8 c g ees( d) c~ c4\) g'8\( g8~
  g c, c a c d e ees~ ees d\) % r4 r2

  r8 g,\( g g g c
  }

  \mark \default %L
  \tripletFeel 8 {
  d d c4 d8 e4.
  d8 b( a) g\) r g\( g c
  d4 r8 c e g4 d'8(~ d c4.)\) r8 a\( a b
  c b c d b4\) a8\( g~ g e g a e d c g a b~ b\) c\( d e g d~
  d\) d\( d e f e d d~
  \mark \default %M
  d c4.\) r2
  R1 R1 R1
  R1 R1 R1 R1
  R1 R1
%  \compressFullBarRests R1*9
  }

  \mark \default %N
  \tempo 4 = 80
  \tripletFeel 8 {
  r4 a'8\( gis a4 g8 f g f e g~ g\) c,\( d e e f\) r4 aes\( g8 f d4. e8~ e2\)
  r4 f8\( e f aes~ \times 2/3 { aes8 g f } g4 g \times 2/3 {ees8( d) c~} c4\) e8\( f d2.\) r2 r8 g,\( g g
  }

  \mark \default %O
  \tripletFeel 8 {
  d'8 d c d\) r4 e\( d8 b( a) g\) r g\( g g d' d c4 d8 e4 g8~ g c,4.\) r8 c\( c c
  a' a g4 a b c\) r8 g\( \times 2/3 {ees8( d) c\)} r8 g'\( g c,\) r c16\( a c8 d4 e8 ees4. d8~
  d2\)
  }

  \mark \default %P
  \tempo 4 = 120
  \tripletFeel 8 {
  r4 r8 g,\( g g g c8 d d c4 d8 e4.
  d8 b( a) g\) r g\( g c
  d4 r8 c e g4 d'8(~ d c4.)\) r8 a\( a b
  c b c d b4\) a8\( g~ g e g a e d c g a b~ b\) c\( d e g d~
  d\) d\( d e f e d d~
  \mark \default %Q
  d c4.\) r2
  }

  \tempo 4 = 90
  r2 r8 a'\(^"Not swing" a b c b c d b4\)
  a8\( g~ g e g a e d c g a b\) c\( d e4 b' a8( g~) g2.\)
  \tempo 4 = 120
  \tripletFeel 8 {
  r8 d\(^"Swing" d e f g e d~ d c8\) r4 r2 R1
  }

  \bar "|."
}

lyrics-main = \lyricmode {
  天 真 得 只 有 你 令 神 仙 魚 歸 天 要 怪 誰
  以 為 留 在 原 地 不 夠 遨 遊 就 讓 牠 沙 灘 裡 戲 水
  那 次 得 你 冒 險 半 夜 上 山 爭 拗 中 隊 友 不 想 撐 下 去
  那 時 其 實 嚐 盡 真 正 自 由 但 又 感 到 沒 趣
  不 要 緊 山 野 都 有 霧 燈 頑 童 亦 學 乖 不 敢 太 勇 敢
  世 上 有 多 少 個 繽 紛 樂 園 任 你 行
  從 何 時 你 也 學 會 不 要 離 群 從 何 時 發 覺 沒 有 同 伴 不 行
  從 何 時 惋 惜 蝴 蝶 困 於 那 桃 源 飛 多 遠 有 誰 會 對 牠 操 心
  曾 迷 途 才 怕 追 不 上 滿 街 趕 路 人 無 人 理 睬 如 何 求 生
  頑 童 大 了 沒 那 麼 笨 可 以 聚 腳 於 康 莊 旅 途 然 後 同 沐 浴 溫 泉
  為 何 在 雨 傘 外 獨 行
  這 麼 多 好 去 處 漫 遊 到 獨 家 村 去 探 誰
  既 然 沿 著 尋 夢 之 旅 出 發   就 站 出 點 吸 引 讚 許
  逛 夠 幾 個 睡 房 到 達 教 堂 仿 似 一 路 飛 奔 七 八 十 歲
  既 然 沿 著 情 路 走 到 這 裡 盡 量 不 要 後 退
  親 愛 的 闖 遍 所 有 路 燈 還 是 令 大 家 開 心 要 緊
  抱 住 兩 廳 雙 套 天 空 海 闊 任 你 行
  從 何 時 你 也 學 會 不 要 離 群 從 何 時 發 覺 沒 有 同 伴 不 行
  從 何 時 惋 惜 蝴 蝶 困 於 那 桃 源 飛 多 遠 有 誰 會 對 牠 操 心
  曾 迷 途 才 怕 追 不 上 滿 街 趕 路 人 無 人 理 睬 如 何 求 生
  頑 童 大 了 沒 那 麼 笨 可 以 聚 腳 於 康 莊 旅 途 然 後 同 沐 浴 溫 泉
  為 何 在 雨 傘 外 獨 行
  親 愛 的 等 遍 所 有 綠 燈 還 是 讓 自 己 瘋 一 下 要 緊
  馬 路 戲 院 商 店 天 空 海 闊 任 你 行
  從 何 時 開 始 忌 諱 空 山 無 人 從 何 時 開 始 怕 遙 望 星 塵
  原 來 神 仙 魚 橫 渡 大 海 會 斷 魂 聽 不 到 世 人 愛 聽 的 福 音
  曾 迷 途 才 怕 追 不 上 滿 街 趕 路 人 無 人 理 睬 如 何 求 生
  頑 童 大 了 沒 那 麼 笨 可 以 聚 腳 於 康 莊 旅 途 然 後 同 沐 浴 溫 泉
  為 何 在 赤 地 上 獨 行
  頑 童 大 了 別 再 追 問
  可 以 任 我 走 怎 麼 到 頭 來 又 隨 著 大 隊 走
  人 群 是 那 麼 像 羊 群
}

upper-part-a = \relative c'' {
  <e g c e>1\arpeggio
  <f a e'>\arpeggio
  <g b e>\arpeggio
  <d f a e'>\arpeggio
  <d g b e>\arpeggio
  <e g b c e>\arpeggio
  <f g a c e>\arpeggio
  <f a c e>2\arpeggio
  \tempo 4 = 120
  \tripletFeel 8 { <b, ees>8 g <aes d> g }
}

lower-part-a = \relative c' {
  c1 f c f, e a d g2
  g4 g,
}

upper-part-b = \relative c' {
  \tripletFeel 8 {
    r8 e g <d' e>~ <d e>2
    r8 c, f <a e'>~ <a e'>2
    r8 e g <d' e>~ <d e> <aes' b> <g c>4
    \tuplet 3/2 4 {e'8 ees d des c b bes a aes}
    g8 ges16 f
    e8 e, d' d, c' c, b' b, c' <c, dis> e d' e e, g' g,
    <d f>4. <f aes>8~ q2
    r4 <dis b'>8 <e c'> r2
  }
}

lower-part-b = \relative c {
  <c b'>1 <f e'> <c d'>
  << {
    r4 \tripletFeel 8 {
      c'8 d~ d2
      r8 <b d>4. r8 <d e>4.
    }
  } \\ {
    <f, e'>1
    e2 \tripletFeel 8 {g4. e8}
  } >>
  \tripletFeel 8 {
    a4 a, b c8 cis d e f g8~ g2 c,8 g' c4 r8 c, \times 2/3 {cis8 d e}
  }
}

upper-part-c = \relative c'' {
  << {
    <a c e>1
    <g b d>1
  } \\ {
    \stemNeutral
    \tripletFeel 8 {
      r4 a8 b16 c cis8 d~ d4
      r4 g,8 a16 ais b8 c~ c4
    }
  } >>
  \tripletFeel 8 {
    a8 f'4 <aes, f'>8~ q2
  }
  \tuplet 3/2 4 {b,8 d e g b e bes, e g bes d g}
  \tripletFeel 8 {
    \tuplet 3/2 4 {r8 f,, c'} f4
    e'8 f16 aes b4
    \tuplet 3/2 4 {r8 e,,, c'} g'4
    d'8 e16 fis <ees a>8 e'
  }
  \tuplet 3/2 4 { f8 e d b d b bes a f d cis c }
  \tripletFeel 8 { b8 c cis <d f,>~ q2 }
}

lower-part-c = \relative c {
  \tripletFeel 8 {
    f8 e'~ e2.
    e,8 d'~ d <ees, bes' des>~ q2
    d4 f8 g~ g4 g,
    c8 g' d'4
    bes,8 g' c4
  }
  a,2
  \clef treble
  << {
    \tripletFeel 8 {
      f''8 aes16 b d4
    }
  } \\ {
    aes,2
  } >>
  \clef bass
  g,2
  \clef treble
  << {
    \tripletFeel 8 {
      e''8 fis16 a c4
    }
  } \\ {
    fis,,2
  } >>
  << {
    \tripletFeel 8 {
      r8 <e' a>
    }
  } \\ {
    \clef bass f,,4
  } >>
  \tripletFeel 8 {
    r8
    \clef bass <f' a>8
  }
  << {
    \tripletFeel 8 {
      r8  <a c d>4.
    }
  } \\ {
    bes,2
  } >>
  g1
}

upper-part-d = \relative c'' {
  \tripletFeel 8 {
    <g e b>8 a b <c g e>~ q g,
  }
  << { \tripletFeel 8 { g'4~ <g bes,>4. d'8 c bes aes g }} \\ { \tripletFeel 8 { c,8 b }} >>
  \tripletFeel 8 {
    <e c'>4. <g b>8~ q4 \tuplet 3/2 4 { c,8 b a }
    <c a'>8 aes' ges <f c g>~ q4. <c fis,>8
    e8 c g <a f> c' b a gis g8~ <g c>4 <fis c'>8~ q2
    a,4 <c f>8 <e c'> r4 fis8 <ees a c> <f d'>4. ees'8 \tuplet 3/2 4 { d8 b g bes a f }
  }
}

lower-part-d = \relative c {
  <c b'>1
  \tripletFeel 8 {
    bes4. <g' c f>8~ q2
    a,8 g' e'2.
    <aes,, g'>4. g8~ g4. fis8
    f2. r8 e ees1
    d4. fis8~ fis4. g8~ <g aes'>1
  }
}

upper-part-e = \relative c' {
  \tripletFeel 8 {
    e4 c8 <e g>~ q e <g a c>4
    <g d'>8 ais b <g fis d>~ q4 fis8 f
    <c e>8 g f' <g c, g>~ q4 \tuplet 3/2 4 { g'8 fis f }
    <g, e'>8 gis fis <ees a>~ q2
    <e c'>8 <d b'>4 <ees b'>8~ q2
    <d a'>8 <b aes'>4 <g c d g>8~ q2
    <d' f c' d>2 <f a c e>4 <aes f'>8 <g c d g>~ q1
  }
}

lower-part-e = \relative c {
  <c b'>1
  \tripletFeel 8 {
    b2 c'8 b a g <bes, f'>1
  }
  << { \tripletFeel 8 { a'8 gis fis f~ f2 }} \\ { a,1 } >>
  f2 
  << { \tripletFeel 8 { ees'8 g f dis }} \\ { g,2 } >>
  \tripletFeel 8 {
    <e e'>4. a8~ a2
    d2. aes8 g << { \tripletFeel 8 { r8 <b' d aes'>8~ q2. }} \\ { g,,1 } >>
  }
}

upper-part-f = \relative c'' {
  \tripletFeel 8 {
    r8 c \acciaccatura fis16 g4 \tuplet 3/2 4 { c,8 d dis e f g }
    aes8 b, c <aes fis'>~ q2
    r8 g'16 aes <bes c,>4 \tuplet 3/2 4 { ges8 f e dis cis <b gis dis>~ }
    q1
  }
}

lower-part-f = \relative c' {
  << {
    \tripletFeel 8 {
      <g bes c ees>4. q8~ q2
      r8 <ges aes c ees>~ q2.
      <f aes c ees>4. q8~ q2
      r2
      \tuplet 3/2 4 { e8 b' dis } \cr \tuplet 3/2 4 { gis8 b fis' }
      \cl
    }
  } \\ {
    \tripletFeel 8 { 
      <aes,,,, aes'>2~ q4. <g g'>8
      <fis fis'>1
      <f f'>1
      <e e'>1
    }
  } >>
}

upper-part-g = \relative c'' {
  <aes c g'>4 r
  \tripletFeel 8 {
    r8 g <aes c>4
    <aes c d fis>4 r8 <aes b d f>~ q2
    r8 <g b c e>4. r8 c <fis, a c d>4
    r8 gis <a c e f> q~ q2
    r8 <b d e g>4. r8 <d e gis b>4.
    r4 <a c e g>8 <g a c> r <aes c e>4.
    r4 r8 <d f a bes>~ q4 r8 fis
    g4 <ais, cis>8 <b d>~ q2
  }
}

lower-part-g = \relative c {
  <aes aes,>4 r r2
  \tripletFeel 8 {
    <d d,>4 r8 <g, g,>~ q2
    c,4 e g fis f c' a f
    e4 f g gis a e' c b
    bes4 d, f aes8 fis g4 d' bes8 g b g
  }
}

upper-part-h = \relative c' {
  \tripletFeel 8 {
    <b d>8 e g <d' e>~ q2
    <b, e>8 c f <a e'>~ q2
    <b, d>8 e g <d' e>~ <d e> <aes' b> <g c>4
    \tuplet 3/2 4 {e'8 ees d des c b bes a aes} g8 ges16 f
    e8 <e, d> d' d, c' <c, d> b' b, c' <c, dis> e d' e e, g' g,
    <d f>4. <f aes>8~ q2
    r4 <dis b'>8 <e c'> r2
  }
}

lower-part-h = \relative c {
  \tripletFeel 8 {
    c4 c, e g f8 f' aes,4 bes b
    c4 cis d e f f,8 c' f e d c
    b4 e, f gis a e c \tuplet 3/2 4 { a8 b cis }
    d4. g8~ g a bes b
    c4 c, d e
  }
}

% No part I

upper-part-j = \relative c'' {
  << {
    <a c e>1
    <g b d>1
  } \\ {
    \stemNeutral
    \tripletFeel 8 {
      r8 e a8 b16 c cis8 d~ d4
      r8 d, g8 a16 ais b8 c~ c4
    }
  } >>
  \tripletFeel 8 {
    a8 f'4 <aes, f'>8~ q2
  }
  \tuplet 3/2 4 {b,8 d e g b e bes, e g bes d g}
  \tripletFeel 8 {
    \tuplet 3/2 4 {r8 f,, c'} f4
    e'8 f16 aes b4
    \tuplet 3/2 4 {r8 e,,, c'} g'4
    d'8 e16 fis <ees a>8 e'
  }
  \tuplet 3/2 4 { f8 e d b d b bes a f d cis c }
  \tripletFeel 8 { b8 c cis <d f,>~ q2 }
}

lower-part-j = \relative c, {
  \tripletFeel 8 {
    f4 a c f8 f,
    e4 b' e ees
    d4 e8 f g4 \tuplet 3/2 4 { g,8 a b }
    c8 g' d'4
    bes,8 g' c4
  }
  a,2
  \clef treble
  << {
    \tripletFeel 8 {
      f''8 aes16 b d4
    }
  } \\ {
    aes,2
  } >>
  \clef bass
  g,2
  \clef treble
  << {
    \tripletFeel 8 {
      e''8 fis16 a c4
    }
  } \\ {
    fis,,2
  } >>
  << {
    \tripletFeel 8 {
      r8 <e' a>
    }
  } \\ {
    \clef bass f,,4
  } >>
  \tripletFeel 8 {
    r8
    \clef bass <f' a>8
  }
  << {
    \tripletFeel 8 {
      r8 <a c d>4.
    }
  } \\ {
    bes,2
  } >>
  \tripletFeel 8 {
    g4 g'8 ees d c aes g
  }
}

upper-part-k = \relative c' {
  \tripletFeel 8 {
    e8 f e f \tuplet 3/2 4 { fis g e'~ } e8 <b gis>
    <a c>8 r r <ais, cis>( <b d>) \tuplet 3/2 8 { b'16( c cis } d8 <dis b>
    <c e>4)
  }
  << {
    \tripletFeel 8 {
      \stemNeutral g8\( aes b c~ \tuplet 3/2 4 { c8 d e } g4
      \tuplet 3/2 4 { fis8 g a } b8 c~ \tuplet 3/2 4 { c8 b c }
      a4.\)
      <aes, a'>8~ q8
      \tuplet 3/2 8 { g16( aes c }
      g'8 f
      \stemUp g4
      \stemNeutral
      g8 <e des bes>)
    }
  } \\ {
    s2.
    s1
    s1
    \tripletFeel 8 {
       r8 <d b>
    }
  } >>
  \tripletFeel 8 {
    r8 <d aes>\( <c g> <a fis> <d f,> e d e \tuplet 3/2 4 { g8 gis a~ } a8 b
    a g fis g~ g f e d\)
  }
}

lower-part-k = \relative c {
  \tripletFeel 8 {
    <c b'>4 <d c'> <e d'> <f e'> g d b g
    <a g'> <b a'> <c b'> <d c'> <ees d'> <e d'> <fis e'> <e bes' d>
    f,4 e' b8 a g f e4 bes'8 a-> r f e ees
    d4 f a \tuplet 3/2 4 { d,8 e fis } g4 gis a b
  }
}

upper-part-l = \relative c'' {
  \tripletFeel 8 {
    b8 c dis e \tuplet 3/2 4 { g8 aes b~ } b8 c16 cis
    d4 r8 <ais, cis> <b d g> fis' g f e <f c bes>~ q g~ \tuplet 3/2 4 { g8 gis a c d dis }
    e1
    <a,, e' gis>8 a' gis a~ <a fis d> <b d, c>4.
    \tuplet 3/2 4 { <b e,>8 c d a c d } gis,8 <f gis d'>4.~
    \tuplet 3/2 4 { q8 c' d } \acciaccatura dis16 <e g,>8 g~ g4 \tuplet 3/2 4 { g8 fis f~ }
    f8 <d aes f>~ q2.
  }
}

lower-part-l = \relative c {
  \tripletFeel 8 {
    <c b'>4 <d c'> <e d'> <f e'> g d b g
    <bes a'> f' <e d'> d8 gis,
  }
  << {
    \tripletFeel 8 {
      g'8 <e a c> <f a dis> <g b e>~ q2
    }
  } \\ {
    a,4 c, d e
  } >>
  \tripletFeel 8 {
    f4 f fis8 fis4.
    <g e'>4 q <gis f'> q8 <a g'>~
    q4 bes b \tuplet 3/2 4 { c8 cis d }
    g,~ <g g,>~ q2.
  }
}

upper-part-m = \relative c'''' {
  \tripletFeel 8 {
    g8 f e c~ c aes g f e f4 g8~ g c,4.
    g''8 f e c~ c \acciaccatura g16 aes8 g f e f4 g8~ g c4. \grace { a32 b c d e f}
    g8 f e c~ c aes g f e f4 g8~ g c,4.
    <a a'>2 <c c'> <d d'> <e e'>
  }
  \tempo 4 = 112
  g,16 a b c
  \tempo 4 = 100
  a b c d
  \tempo 4 = 86
  b c d e
  \tempo 4 = 72
  c d e f
  \tempo 4 = 80
  g4 <g, b ees> <f aes d> <g bes des>
}

lower-part-m = \relative c' {
  << {
    \tripletFeel 8 {
      r4 a8 <b e>~ <b e>2
      r4 g8 <a c>~ <a c>2
      r4 f8 <aes c>~ <aes c>2
      r8 d, f <aes c>~ <aes c>2
      r4 a8 <b e>~ <b e>2
      r4 g8 <a c>~ <a c>2
      r8 f <a c>4 <f e'>8 <a f'>4.
      r8 \acciaccatura dis,8 e f g <f a>4~ <f aes>
    }
  } \\ {
    \tripletFeel 8 {
      f,1 e d g f e
      d2.~ d8 c bes1
    }
  } >>
  g1 g'2. e4
}

upper-part-n = \relative c' {
  \tripletFeel 8 {
    r8 e a b16 c cis8 d~ d4
    r8 b,8 <d g> <des a'>16 ais' b8 c~ c4
    <f, a>8 <g f'>4 <aes c f>8~ q2
    \tuplet 3/2 4 { b,8 d e g b e bes, e g bes d g }
    \tuplet 3/2 4 {r8 f,, c'} f4
    e'8 f16 aes b4
    \tuplet 3/2 4 {r8 e,,, c'} g'4
    d'8 e16 fis <ees a>8 e'
    \tuplet 3/2 4 { f8 e d b d b bes a f d cis c }
    <g b fis'>4. <g b f' g>8~ q2
  }
}

lower-part-n = \relative c' {
  << {
    <a c e f>1
    <g b d e>
  } \\ {
    \tripletFeel 8 {
      f,1
      e4. ees8~ ees2
    }
  } >>
  << {
    \tripletFeel 8 {
      r8 f' c' aes~ aes4 g
    }
  } \\ {
    \tripletFeel 8 {
      d,4. g8~ g2
    }
  } >>
  \tripletFeel 8 {
    c8 g' d'4
    bes,8 g' c4
  }
  a,2
  \clef treble
  << {
    \tripletFeel 8 {
      f''8 aes16 b d4
    }
  } \\ {
    aes,2
  } >>
  \clef bass
  g,2
  \clef treble
  << {
    \tripletFeel 8 {
      e''8 fis16 a c4
    }
  } \\ {
    fis,,2
  } >>
  << {
    \tripletFeel 8 {
      r8 <e' a>
    }
  } \\ {
    \clef bass f,,4
  } >>
  \tripletFeel 8 {
    r8
    \clef bass <f' a>8
  }
  << {
    \tripletFeel 8 {
      r8  <a c d>4.
      b8 c cis d~ d2
    }
  } \\ {
    bes,2
    g1
  } >>
}

upper-part-o = \relative c' {
  \tripletFeel 8 {
    <g a d g>8 c
    \tuplet 3/2 4 {
      d8 e fis g gis a
    }
    c4
    <g, a d>8 a'4 <d, e g>8~
    <d e g d'>8 e16 f \tuplet 3/2 4 { fis8 g a }
    <d, e bes'>4 c'8 bes~ bes <g, bes e>4.
    \tuplet 6/4 { <a c e f>16 g' gis a c d }
    <f, a c e>4
    bes8 a16 aes \tuplet 3/2 4 { g8 fis f }
  }
  << {
    \tripletFeel 8 {
      s2 \tuplet 6/4 { f16 g gis a b c } g'8 fis16 f
    }
  } \\ {
    \stemNeutral
    \tripletFeel 8 {
      <f,, a c e>8 f~ <f a f'> <f a c e>~ \stemDown q2
    }
  } >>
  \tripletFeel 8 {
    <g' b d e>4 <e, g b>8 c''16 d
    <g, a c ees>8 d'16 c \tuplet 3/2 4 { a8 aes g }
    <f c a g>8 \tuplet 3/2 { g16 a b } <c a g d>4
    <fis, d a>8 \tuplet 3/2 { g16 a b } <c a g d>8 e
    <ees b g>1
  }
}

lower-part-o = \relative c, {
  \tripletFeel 8 {
    c8 c' e~ <e g a d>~ q4 c8 c,
    b8 b' d <g a>~ q4 <b,, b'>
    <bes bes'>8 bes' <d a' c> <d g a d>~ q4 bes8 bes,
    a8 a'4 a,8 g g'4 g,8
    f8~ <f f'>~ q2 f'8 f,
    e8 e'4 e,8 ees ees'4 ees,8
    <d d'>2 <fis fis'>4 fis'8 fis,
    <g g'>1
  }
}

upper-part-p = \relative c''' {
  \tuplet 3/2 4 { g8 d b } g4 r2
  \tripletFeel 8 {
    b8 c dis e \tuplet 3/2 4 { g8 aes b~ } b8 c16 cis
    d4 r8 <ais, cis> <b d g> fis' g f e <f c bes>~ q g~ \tuplet 3/2 4 { g8 gis a c d dis }
    e1
    <a,, e' gis>8 a' gis a~ <a fis d> <b d, c>4.
    \tuplet 3/2 4 { <b e,>8 c d a c d } gis,8 <f gis d'>4.~
    \tuplet 3/2 4 { q8 c' d } \acciaccatura dis16 <e g,>8 g~ g4 \tuplet 3/2 4 { g8 fis f~ }
    f8 <d aes f>~ q2.
  }
}

lower-part-p = \relative c' {
  \tuplet 3/2 4 { g8 d b } g4 a b
  \tripletFeel 8 {
    <c b'>4 <d c'> <e d'> <f e'> g d b g
    <bes a'> f' <e d'> d8 gis,
  }
  << {
    \tripletFeel 8 {
      g'8 <e a c> <f a dis> <g b e>~ q2
    }
  } \\ {
    a,4 c, d e
  } >>
  \tripletFeel 8 {
    f4 f fis8 fis4.
    <g e'>4 q <gis f'> q8 <a g'>~
    q4 bes b \tuplet 3/2 4 { c8 cis d }
    g,~ <g g,>~ q2.
  }
}

upper-part-q = \relative c''' {
  \tripletFeel 8 {
    <aes ees c aes>8 f fis <g ees c g>~ q ees \tuplet 3/2 4 { e f <fis ees c fis,>~ } q1
    <f, a e'>1 <d g d'>2 <g c> <f c'>1 <g ees'>2~ <g d'>
    R1
    \makeOctaves 1 {
      c8 bes aes ges r e d des c r
    }
    \clef bass
    r8 <e, g a d>~ q2
  }
}

lower-part-q = \relative c {
  \tripletFeel 8 {
    <aes aes,>4. <g g,>8~ q4. <fis fis,>8~ q1
    f'1 e2 a d1 g,
    <g, g,>8 r r4 r2
    <c, c,>8 r r4 r2
    r4 <c c'>2.
  }
}

upper = \relative c {
  \clef treble
  \key c \major
  \time 4/4
  \upper-part-a
  \upper-part-b
  \upper-part-c
  \upper-part-d
  \upper-part-e
  \upper-part-f
  \upper-part-g
  \upper-part-h
  \upper-part-j
  \upper-part-k
  \upper-part-l
  \upper-part-m
  \upper-part-n
  \upper-part-o
  \upper-part-p
  \upper-part-q
}

lower = \relative c {
  \clef bass
  \key c \major
  \time 4/4
  \lower-part-a
  \lower-part-b
  \lower-part-c
  \lower-part-d
  \lower-part-e
  \lower-part-f
  \lower-part-g
  \lower-part-h
  \lower-part-j
  \lower-part-k
  \lower-part-l
  \lower-part-m
  \lower-part-n
  \lower-part-o
  \lower-part-p
  \lower-part-q
}

dynamics = {
  s1
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
  title = \markup \center-align { "任我行 - swing version" }
  subtitle = "for female vocal"
  arranger = \markup { "Arrangement by Benson" }
}

\book {
\score {
  \new Score \with {
%    \override NonMusicalPaperColumn #'page-break-permission = ##f
  }
  \new StaffGroup <<
    \new Staff = "melodyastaff" <<
      % \set Staff.midiInstrument = #"recorder"
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.midiMinimumVolume = #0.9
      \set Staff.midiMaximumVolume = #1
      \new Voice = "melody" \melody
      \context Lyrics = "sopranolyrics" { \lyricsto "melody" { \lyrics-main } }
    >>

    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Primo  "
      \new Staff = "right" \upper {
        \set Staff.midiMinimumVolume = #0.7
        \set Staff.midiMaximumVolume = #0.8
      }
      \new Dynamics = "pdynamics" \dynamics
      \new Staff = "left" \lower {
        \set Staff.midiMinimumVolume = #0.7
        \set Staff.midiMaximumVolume = #0.8
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
      \consists "Dynamic_align_engraver"
      \consists "Text_engraver"
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
  }
}
}

\book {
\bookOutputSuffix "no-vocal"
\score {
  \new StaffGroup <<
    \new Staff = "melodyastaff" <<
      % \set Staff.midiInstrument = #"recorder"
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.midiMinimumVolume = #0
      \set Staff.midiMaximumVolume = #0
      \new Voice = "melody" \melody
      \context Lyrics = "sopranolyrics" { \lyricsto "melody" { \lyrics-main } }
    >>

    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" \upper {
        \set Staff.midiMinimumVolume = #0.7
        \set Staff.midiMaximumVolume = #0.8
      }
      \new Dynamics = "pdynamics" \dynamics
      \new Staff = "left" \lower {
        \set Staff.midiMinimumVolume = #0.7
        \set Staff.midiMaximumVolume = #0.8
      }
    >>
  >>
  \midi {
  }
}
}

\book {
\bookOutputSuffix "vocal"
\score {
  \new Staff = "melodyastaff" <<
    \set Staff.midiInstrument = #"electric guitar (clean)"
    \set Staff.midiMinimumVolume = #0.9
    \set Staff.midiMaximumVolume = #1
    \new Voice = "melody" \melody
    \context Lyrics = "sopranolyrics" { \lyricsto "melody" { \lyrics-main } }
  >>
  \layout {
  }
}
}
