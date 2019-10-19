# 宝探しアドベンチャー・ARAR探検隊！

## 概要

ARでポスターが動き出すアドベンチャー型クイズゲーム！学校中を歩き回ってポスターを探そう！

## 実行

### クイズの設定方法

`/arar-tankentai/quests/quests.json`を編集することでクイズを設定することができる。以下に例を示す。

``` quests.json
[
    {
      "location": "３号館２階",
      "question": "三重県にはいくつ高専がある？",
      "answer": "３",
      "answerCandidates": ["１", "２", "３", "４"],
      "answerDescription": "鳥羽商船高専、鈴鹿高専、近代高専の３つがあります。",
      "fileName": "suzuki-1",
    },
    {
      "location": "ブラック号館",
      "question": "これはだれでしょう？",
      "answer": "シリウス・ブラック",
      "answerCandidates": ["ヴォルデモート", "シリウス・ブラック", "ハリー・ポッター", "ロン・ウィーズリー"],
      "answerDescription": "",
      "fileName": "black-1",
    },
]
```

|**KEY**|**VALUE**|
|---|---|
|location|場所|
|question|問題|
|answer|解答（選択肢に含まれている必要がある）|
|answerCandidates|４つの解答選択肢（＊４択のため）|
|answerDescription|解答の説明|
|fileName|ビデオとポスター画像のファイル名（拡張子なし）|

### ビデオの保存場所

`/arar-tankentai/videos/*`

ここで、ビデオファイル名はjsonファイルに記載したfileNameと対応させる。

### ポスター画像の保存場所

`/arar-tankentai/Assets.xcassets/AR Resources.arresourcegroup/*`

ここで、画像ファイル名はjsonファイルに記載したfileNameと対応させる。
