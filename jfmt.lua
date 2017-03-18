
local Mecab = require "mecab"
local split = require("pl.utils").split
local argparse = require "argparse"

local waga = "どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。しかもあとで聞くとそれは書生という人間中で一番獰悪な種族であったそうだ。この書生というのは時々我々を捕えて煮て食うという話である。しかしその当時は何という考もなかったから別段恐しいとも思わなかった。ただ彼の掌に載せられてスーと持ち上げられた時何だかフワフワした感じがあったばかりである。掌の上で少し落ちついて書生の顔を見たのがいわゆる人間というものの見始であろう。この時妙なものだと思った感じが今でも残っている。第一毛をもって装飾されべきはずの顔がつるつるしてまるで薬缶だ。その後猫にもだいぶ逢ったがこんな片輪には一度も出会わした事がない。のみならず顔の真中があまりに突起している。そうしてその穴の中から時々ぷうぷうと煙を吹く。どうも咽せぽくて実に弱った。これが人間の飲む煙草というものである事はようやくこの頃知った。"

function main(text)
  local parser = argparse("jfmt", "Japanese text wrapper")
  parser:argument("input", "Input file", '-')
  parser:option("-w --width", "Width in full-width characters", 35)
  parser:flag("-z --zero-width", "Use zero-width spaces", false)

  local args = parser:parse()

  local wrapper = args.zero_width and reflowz or reflow
  local input = (args.input == '-') and io.input() or io.input(args.input) 
  local width = tonumber(args.width)

  while true do
    local text = input:read()
    if not text then break end
    print(wrapper(get_words(text), width))
  end
end

function freader(fname)
  if fname == '-' then return io.read end
  return function ()
    return io.read(fname)
  end
end

function reflow(words, width)
  local out = ''
  local cline = ''
  local wi = 1

  while wi < #words + 1 do
    local chunk = words[wi].token
    wi = wi + 1

    while not split_ok(words[wi]) do
      chunk = chunk .. words[wi].token
      wi = wi + 1
    end
    
    if utf8.len(cline .. chunk) < width then
      cline = cline .. chunk
    else
      out = out .. cline .. '\n'
      cline = chunk
    end
  end
  return out .. cline
end

function reflowz(words)
  local zws = utf8.char(0x200b) -- zero width space
  local out = ''
  local wi = 1
  while wi < #words + 1 do
    local chunk = words[wi].token
    wi = wi + 1

    while not split_ok(words[wi]) do
      chunk = chunk .. words[wi].token
      wi = wi + 1
    end

    out = out .. chunk .. zws
  end
  return out
end

function split_ok(word)
  if not word then return true end
  if word.pos[1] == '助詞' then return false end
  if word.pos[1] == '記号' then return false end
  return true
end

function get_words(text)
  local tagger = Mecab:new("")
  local lines = split(tagger:parse(text), "\n")
  local words = {}
  for ii, line in ipairs(lines) do
    words[1+#words] = get_parts(line)
  end
  return words
end

function get_parts(line)
  if line == "EOS" then return nil end

  local parts = split(line, "\t")

  return {token=parts[1], pos=split(parts[2],',')}
end

main(waga)
