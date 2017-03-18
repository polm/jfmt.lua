# jfmt

jfmt is a tool for wrapping Japanese text. 

To run:

    luarocks install --tree lua_modules mecab penlight argparse
    lua -l set_paths jfmt.lua waga

Output: 

    どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所で
    ニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて
    人間というものを見た。しかもあとで聞くとそれは書生という人間中で一番
    獰悪な種族であったそうだ。この書生というのは時々我々を捕えて煮て
    食うという話である。しかしその当時は何という考もなかったから別段恐し
    いとも思わなかった。ただ彼の掌に載せられてスーと持ち上げられた時
    何だかフワフワした感じがあったばかりである。掌の上で少し落ちついて
    書生の顔を見たのがいわゆる人間というものの見始であろう。この時妙な
    ものだと思った感じが今でも残っている。第一毛をもって装飾されべき
    はずの顔がつるつるしてまるで薬缶だ。その後猫にもだいぶ逢ったがこんな
    片輪には一度も出会わした事がない。のみならず顔の真中があまりに突起
    している。そうしてその穴の中から時々ぷうぷうと煙を吹く。どうも咽せ
    ぽくて実に弱った。これが人間の飲む煙草というものである事はようやく
    この頃知った。

The default width is 35 characters. You can change it by using the `-w`
parameter. 

Instead of wrapping lines to a fixed width, you can add zero-width space
characters wherever a word break would be OK using the `-z` flag. The output
will look the same as the input, but should wrap only at word boundaries
wherever zero-width spaces are supported. (Note that in the browser you will
need to set `word-break: keep-all` to disable default behavior.)

## License

WTFPL, do as you please.
