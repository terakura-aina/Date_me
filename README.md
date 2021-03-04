# :bouquet:Date me
ちょっとマンネリしてきた夫婦に久しぶりのドキドキを提供してくれる、  
デートサポートサービスです。  
<br>
![トップ画像](https://user-images.githubusercontent.com/72124914/109914470-68147380-7cf3-11eb-9c05-4438ad216dcb.png)
<br>
<br>

* デート日を決めてもらえれば、あとはアプリがデートのお誘い、当日のアクションのアドバイスをしてくれます。  
* 当日のアクションは、「ミッション」という形で通知が届くため、リアル体験型ゲームのような感覚で楽しむことができます。  

</div>

## :bouquet:App URL(スマートフォンから見ることをおすすめします)
https://love-dateme.com/top

## :bouquet:Date meについて
### 登場人物
パートナーと仲良くしたい人

### ユーザーが抱える問題
奥さん  
「仲は悪くない。だけど最近、"デートしよ"みたいなやりとりはもはやない。  
新婚の時のようなドキドキする関係に戻りたい！もっと仲良くしたい！」  

旦那さん  
「そう言われても、具体的に何をしたらいいのかわからない…それに今更恥ずかしい…」

### 解決方法
直接デートに誘ったり、デート中に自分からドキドキアクションを起こすのが恥ずかしいなら、第三者が代わりに提案してくれれば良い。  

* デート中に携帯はあまり見ることができない…  
→LINE上で手軽にアドバイスが確認できます。

### プロダクト
LINE上で、デート中に"ドキドキするアクション"を提案、行動を後押ししてくれるアプリケーション  

* デートのお誘いにOKすると、前日にリマインドの連絡が届きます。  
* デートの時間が始まると、奥さんと旦那さんそれぞれにLINE botから「ミッション」が届きます。(時間はランダムです)  
* ミッションの一例→「手を繋ごう！」「10秒見つめてみて」など  
* アクションの内容は、どんなデートでも実行できるようなものが中心となっています。

### マーケット
結婚3年以上たって「ドキドキって何？」となってきた夫婦

## :bouquet:使用技術
* Ruby 2.6.6
* Rails 6.1.2
* MYSQL
* Nginx
* Puma
* Capistrano
* AWS
  * VPC
  * EC2
  * RDS
  * ALB
  * Route53
  * ACM
* RSpec
* TailwindCSS

## :bouquet:機能一覧
* ユーザー特定機能(LINE API、fetch)
* スケジュール作成、更新機能(LIFF、ajax)
* ミッション通知機能(whenever、messaging API)
* ミッション完了/未完了機能(ajax)
* LINE応答機能(messaging API)

## :bouquet:画面遷移図
https://xd.adobe.com/view/1720b733-f087-4b61-a494-12e01cba8629-4273/

## :bouquet:ER図
![ER図](https://user-images.githubusercontent.com/72124914/109919119-7e263200-7cfb-11eb-955e-f668d374a2ec.png)