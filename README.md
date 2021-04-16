## アプリケーション名
## mm


## アプリケーション概要
mmは、問題分析や対策探しなどに役立ち、仕事や生活において問題解決に進めるためには非常に効果的であり、あなたのお手伝いするツールであります。


## URL
<img src="/app/assets/images/813ncnvb.png" width="240px" height="240px" >

- LINE ID：@813ncnvb


## 利用方法
LINE公式アカウントと対話するユーザーは、基本『メニュー ※メニュー以外の文字入力でも対応可能。スタンプや画像は対応不可』と入力することにより、メッセージを返信します。


## 目指した課題解決
常に「これでいいのか」と考えてみよう…。  

人間の基礎力では、課題発見力を「現状を分析し、目的や課題を明らかにする力」と定義し、行動例を「目標に向かって、自ら"ここに問題があり、解決が必要だ"と提案する」としています。課題発見力は人間の基礎力の中でも欠かせない力です。しかも、課題を発見して「解決が必要だ」と指摘するところまで含まれ、その先には課題解決にまでつながるため、とてもレベルの高い能力とも言えるでしょう。


## 洗い出した要件
- 自動応答機能
- お問い合わせ機能
- アンケート機能


## 実装した機能についての画像やGIFおよびその説明
- 自動応答機能  
LINE公式アカウントと対話するユーザーは、基本『メニュー ※メニュー以外の文字入力でも対応可能。スタンプや画像は対応不可』と入力することにより、一覧（カルーセル）を返信します。
またメニュー項目を選択いただくと、質問を返信します。
<img src="/app/assets/images/Videotogif.gif" width="428px" height="926px" >
<img src="/app/assets/images/Videotogif2.gif" width="428px" height="926px" >

- お問い合わせ機能  
LINE公式アカウントと対話するユーザーは、基本『メニュー ※メニュー以外の文字入力でも対応可能。スタンプや画像は対応不可』と入力することにより、一覧（カルーセル）を返信します。
またお問い合わせ項目を選択いただくと、リンク先に遷移します。※現在（2021/4/16）MAILを選択すると、GoogleのHPに遷移します。またTELを選択すると、LINE OUTに遷移します。
<img src="/app/assets/images/Videotogif3.gif" width="428px" height="926px" >

- アンケート機能  
LINE公式アカウントと対話するユーザーは、基本『メニュー ※メニュー以外の文字入力でも対応可能。スタンプや画像は対応不可』と入力することにより、一覧（カルーセル）を返信します。
また評価項目を選択いただくと、GoodボタンやBadボタンを返信します。
<img src="/app/assets/images/Videotogif4.gif" width="428px" height="926px" >


## 実装予定の機能
- 画像やお問い合わせ機能タップの際のリンク先作成
- 定期プッシュメッセージ作成


## ローカルでの動作方法
- Ruby2.6.5
- Ruby on Rails6.0.0
- MySQL2
- ngrok2.3.38
- Messaging API