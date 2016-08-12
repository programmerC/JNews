# JNews
## 模仿News Digest做的一个小项目，学习用(Just for Learning)

####注：右上角点击菜单栏按钮之后选择新闻，后台不一定会返回数据(本人懒得打理后台以及上传新闻)
####打开APP默认读取新闻数据依次顺序: 本地读取今日新闻->从后台读取今日新闻->读取本地最新的新闻->读取后台某一天的新闻.(前者取不到数据的时候执行下一操作)
####本地存储是用CoreData，打开APP默认删除六天前的数据(好像现在被我关了)


####打开APP效果
![image](https://github.com/programmerC/JNews/raw/master/Gif/1.gif)
<table>
<tr>
  <th>Effect</th>
  <th>Class</th>
</tr>
<tr>
  <td>加载新闻效果</td>
  <td>LoadingView</td>
</tr>
<tr>
  <td>下拉顶部图片放大</td>
  <td>ViewController</td>
</tr>
<tr>
  <td>底部已读新闻效果</td>
  <td>MainBottomTableViewCell/CircleLayout</td>
</tr>
</table>

####浏览新闻效果
![image](https://github.com/programmerC/JNews/raw/master/Gif/3.gif)
<table>
<tr>
  <th>Effect</th>
  <th>Class</th>
</tr>
<tr>
  <td>浏览新闻效果</td>
  <td>NewsViewController</td>
</tr>
</table>

####具体新闻左右滑效果
![image](https://github.com/programmerC/JNews/raw/master/Gif/2.gif)

####菜单栏按钮效果
![image](https://github.com/programmerC/JNews/raw/master/Gif/4.gif)
<table>
<tr>
  <th>Effect</th>
  <th>Class</th>
</tr>
<tr>
  <td>菜单栏按钮效果</td>
  <td>MenuView</td>
</tr>
<tr>
  <td>快速计时效果</td>
  <td>CountdownView</td>
</tr>
<tr>
  <td>底部选择新闻效果</td>
  <td>DatesCollectionView</td>
</tr>
</table>
